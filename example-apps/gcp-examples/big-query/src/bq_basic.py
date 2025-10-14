# bq_basic.py
# Minimal BigQuery example: create if missing, load from GCS, simple query.

from google.cloud import bigquery

PROJECT   = "YOUR_PROJECT_ID"
DATASET   = "example_dataset"
TABLE     = "events"
LOCATION  = "us-central1"
GCS_URI   = "gs://YOUR_BUCKET/path/events.json"  # NDJSON (newline-delimited JSON)

SCHEMA = [
    bigquery.SchemaField("event_id", "STRING", mode="REQUIRED"),
    bigquery.SchemaField("device_id", "STRING", mode="REQUIRED"),
    bigquery.SchemaField("timestamp", "TIMESTAMP", mode="REQUIRED"),
    bigquery.SchemaField("temperature", "FLOAT"),
]

def main():
    client = bigquery.Client(project=PROJECT)

    # 1) Create dataset if missing
    dataset_ref = bigquery.Dataset(f"{PROJECT}.{DATASET}")
    dataset_ref.location = LOCATION
    try:
        client.get_dataset(dataset_ref)
    except Exception:
        client.create_dataset(dataset_ref)
        print(f"Created dataset: {DATASET}")

    # 2) Create table if missing (with simple partition/cluster for good defaults)
    table_id = f"{PROJECT}.{DATASET}.{TABLE}"
    # try:
    #     client.get_table(table_id)
    # except Exception:
    #     table = bigquery.Table(table_id, schema=SCHEMA)
    #     table.time_partitioning = bigquery.TimePartitioning(
    #         type_=bigquery.TimePartitioningType.DAY, field="timestamp"
    #     )
    #     table.clustering_fields = ["device_id"]
    #     client.create_table(table)
    #     print(f"Created table: {TABLE}")

    # # 3) Load NDJSON from GCS (append)
    # job_config = bigquery.LoadJobConfig(
    #     source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
    #     write_disposition=bigquery.WriteDisposition.WRITE_APPEND,
    #     schema=SCHEMA,
    # )
    # load_job = client.load_table_from_uri(GCS_URI, table_id, job_config=job_config)
    # load_job.result()
    # print("Loaded data from GCS.")

    # 4) Simple query
    sql = f"""
      SELECT device_id, COUNT(*) AS events
      FROM `{table_id}`
      WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
      GROUP BY device_id
      ORDER BY events DESC
      LIMIT 10
    """
    for row in client.query(sql).result():
        print(dict(row))

if __name__ == "__main__":
    main()
