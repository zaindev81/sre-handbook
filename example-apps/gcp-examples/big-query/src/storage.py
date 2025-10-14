#!/usr/bin/env python3
"""
BigQuery bootstrap for an IoT `events` table.

Features:
- Create dataset & table if missing (partitioned + clustered)
- Load NDJSON from GCS (WRITE_APPEND or replace)
- Stream sample rows
- Run example queries
- Create an example view

Usage:
  python bq_events.py --project YOUR_PROJECT --dataset example_dataset --table events \
    --location us-central-1 --gcs_uri gs://YOUR_BUCKET/path/events.json
"""

import argparse
import datetime as dt
from typing import Optional, List

from google.cloud import bigquery

SCHEMA = [
    bigquery.SchemaField("event_id", "STRING", mode="REQUIRED", description="Unique event identifier"),
    bigquery.SchemaField("device_id", "STRING", mode="REQUIRED", description="IoT device identifier"),
    bigquery.SchemaField("timestamp", "TIMESTAMP", mode="REQUIRED", description="Event timestamp"),
    bigquery.SchemaField("temperature", "FLOAT", mode="NULLABLE", description="Temperature in Celsius"),
]


def ensure_dataset(client: bigquery.Client, dataset_id: str, location: str) -> bigquery.Dataset:
    try:
        ds = client.get_dataset(dataset_id)
        print(f"✓ Dataset exists: {dataset_id}")
        return ds
    except Exception:
        ds = bigquery.Dataset(dataset_id)
        ds.location = location
        ds = client.create_dataset(ds)
        print(f"+ Created dataset: {dataset_id} (location={location})")
        return ds


def ensure_table(client: bigquery.Client, table_id: str) -> bigquery.Table:
    try:
        tbl = client.get_table(table_id)
        print(f"✓ Table exists: {table_id}")
        return tbl
    except Exception:
        tbl = bigquery.Table(table_id, schema=SCHEMA)
        # Partition by event timestamp (per-day) and cluster by device_id
        tbl.time_partitioning = bigquery.TimePartitioning(
            type_=bigquery.TimePartitioningType.DAY, field="timestamp"
        )
        tbl.clustering_fields = ["device_id"]
        tbl = client.create_table(tbl)
        print(f"+ Created table: {table_id} (DAY partition on `timestamp`, cluster on `device_id`)")
        return tbl


def load_from_gcs(
    client: bigquery.Client, table_id: str, gcs_uri: str, replace: bool = False
) -> None:
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE
        if replace
        else bigquery.WriteDisposition.WRITE_APPEND,
        schema=SCHEMA,  # safe to include even if table exists
    )
    job = client.load_table_from_uri(gcs_uri, table_id, job_config=job_config)
    print(f"… Loading from {gcs_uri} → {table_id} (replace={replace})")
    job.result()
    dest = client.get_table(table_id)
    print(f"✓ Loaded rows. Table now has {dest.num_rows} rows.")


def stream_sample_rows(client: bigquery.Client, table_id: str) -> None:
    now = dt.datetime.utcnow().replace(tzinfo=dt.timezone.utc)
    rows = [
        {
            "event_id": "e_stream_1",
            "device_id": "dev-001",
            "timestamp": now.isoformat(),
            "temperature": 26.4,
        },
        {
            "event_id": "e_stream_2",
            "device_id": "dev-002",
            "timestamp": (now + dt.timedelta(minutes=15)).isoformat(),
            "temperature": 27.0,
        },
    ]
    errors = client.insert_rows_json(table_id, rows)
    if errors:
        raise RuntimeError(f"Streaming insert errors: {errors}")
    print(f"✓ Streamed {len(rows)} rows to {table_id}.")


def run_queries(client: bigquery.Client, fq_table: str) -> None:
    queries: List[str] = [
        f"""
        SELECT * FROM `{fq_table}`
        ORDER BY timestamp DESC
        LIMIT 10
        """,
        f"""
        SELECT device_id, COUNT(*) AS event_count
        FROM `{fq_table}`
        WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
        GROUP BY device_id
        ORDER BY event_count DESC
        """,
        f"""
        SELECT device_id, AVG(temperature) AS avg_temp_c
        FROM `{fq_table}`
        WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
        GROUP BY device_id
        ORDER BY avg_temp_c DESC
        """,
    ]
    for i, q in enumerate(queries, 1):
        job = client.query(q)
        rows = list(job.result())
        print(f"\nQuery {i}: returned {len(rows)} rows")
        # print first few rows
        for r in rows[:5]:
            print(dict(r))


def create_view_latest(client: bigquery.Client, project: str, dataset: str, table: str) -> None:
    view_id = f"{project}.{dataset}.v_device_latest"
    sql = f"""
    CREATE OR REPLACE VIEW `{view_id}` AS
    WITH ranked AS (
      SELECT device_id, timestamp, temperature,
             ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY timestamp DESC) AS rn
      FROM `{project}.{dataset}.{table}`
    )
    SELECT device_id, timestamp AS latest_ts, temperature AS latest_temp_c
    FROM ranked
    WHERE rn = 1
    """
    job = client.query(sql)
    job.result()
    print(f"✓ Created/updated view: {view_id}")


def main():
    parser = argparse.ArgumentParser(description="BigQuery IoT events helper")
    parser.add_argument("--project", required=True, help="GCP project ID")
    parser.add_argument("--dataset", required=True, help="BigQuery dataset ID")
    parser.add_argument("--table", required=True, help="BigQuery table ID (e.g., events)")
    parser.add_argument("--location", default="US", help="Dataset location (e.g., us-central1)")
    parser.add_argument("--gcs_uri", help="gs://bucket/path/file.json to load (NDJSON)")
    parser.add_argument("--replace", action="store_true", help="Truncate table when loading from GCS")
    parser.add_argument("--no_stream", action="store_true", help="Skip streaming sample rows")
    parser.add_argument("--no_queries", action="store_true", help="Skip example queries")
    parser.add_argument("--no_view", action="store_true", help="Skip creating the latest-reading view")
    args = parser.parse_args()

    client = bigquery.Client(project=args.project)

    dataset_id = f"{args.project}.{args.dataset}"
    table_id = f"{dataset_id}.{args.table}"

    ensure_dataset(client, dataset_id, args.location)
    ensure_table(client, table_id)

    if args.gcs_uri:
        load_from_gcs(client, table_id, args.gcs_uri, replace=args.replace)

    if not args.no_stream:
        stream_sample_rows(client, table_id)

    if not args.no_queries:
        run_queries(client, table_id)

    if not args.no_view:
        create_view_latest(client, args.project, args.dataset, args.table)

    print("\nAll done ✅")


if __name__ == "__main__":
    main()
