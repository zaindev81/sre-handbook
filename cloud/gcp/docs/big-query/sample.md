# Sample

Great—let’s **use BigQuery** with that `events` table right away. Below are copy-pasteable commands and a few handy queries.

## 0) Set vars (adjust to your values)

```bash
PROJECT_ID="<your-gcp-project>"
DATASET_ID="example_dataset"
TABLE_ID="events"
bq --project_id="$PROJECT_ID" ls "$DATASET_ID"
```

## 1) Verify the table

```bash
bq --project_id="$PROJECT_ID" show --format=prettyjson "$DATASET_ID.$TABLE_ID"
```

## 2) Insert sample rows (streaming)

### Option A: inline via stdin

```bash
cat <<'JSON' | bq --project_id="$PROJECT_ID" insert "$DATASET_ID.$TABLE_ID"
{"event_id":"e1","device_id":"dev-001","timestamp":"2025-10-14T00:00:00Z","temperature":26.4}
{"event_id":"e2","device_id":"dev-002","timestamp":"2025-10-14T01:30:00Z","temperature":27.1}
{"event_id":"e3","device_id":"dev-001","timestamp":"2025-10-14T02:10:00Z","temperature":25.8}
JSON
```

### Option B: from a JSON file (newline-delimited)

```bash
printf '%s\n' \
'{"event_id":"e4","device_id":"dev-003","timestamp":"2025-10-14T03:00:00Z","temperature":28.0}' \
'{"event_id":"e5","device_id":"dev-002","timestamp":"2025-10-14T04:15:00Z","temperature":26.9}' \
> rows.json

bq --project_id="$PROJECT_ID" insert "$DATASET_ID.$TABLE_ID" rows.json
```

## 3) Query the table (standard SQL)

### Get latest 10 events

```bash
bq --project_id="$PROJECT_ID" query --use_legacy_sql=false \
"SELECT * FROM \`$PROJECT_ID.$DATASET_ID.$TABLE_ID\`
 ORDER BY timestamp DESC
 LIMIT 10"
```

### Count events per device in the last 24h

```bash
bq --project_id="$PROJECT_ID" query --use_legacy_sql=false \
"SELECT device_id, COUNT(*) AS event_count
 FROM \`$PROJECT_ID.$DATASET_ID.$TABLE_ID\`
 WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
 GROUP BY device_id
 ORDER BY event_count DESC"
```

### Average temperature per device, last 7 days

```bash
bq --project_id="$PROJECT_ID" query --use_legacy_sql=false \
"SELECT device_id, AVG(temperature) AS avg_temp_c
 FROM \`$PROJECT_ID.$DATASET_ID.$TABLE_ID\`
 WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
 GROUP BY device_id
 ORDER BY avg_temp_c DESC"
```

## 4) Batch load data (from GCS)

If you have newline-delimited JSON in GCS:

```bash
bq --project_id="$PROJECT_ID" load \
  --source_format=NEWLINE_DELIMITED_JSON \
  "$DATASET_ID.$TABLE_ID" \
  gs://YOUR_BUCKET/path/events-*.json
```

CSV example (schema already defined in Terraform, so no schema flag needed if columns match order):

```bash
bq --project_id="$PROJECT_ID" load \
  --skip_leading_rows=1 \
  --source_format=CSV \
  "$DATASET_ID.$TABLE_ID" \
  gs://YOUR_BUCKET/path/events.csv
```

## 5) Export results to GCS

```bash
bq --project_id="$PROJECT_ID" extract \
  --destination_format=CSV \
  "$DATASET_ID.$TABLE_ID" \
  gs://YOUR_BUCKET/exports/events-*.csv
```

## 6) Create a view (optional)

```bash
bq --project_id="$PROJECT_ID" mk --view \
"SELECT device_id, AVG(temperature) AS avg_temp_c
 FROM \`$PROJECT_ID.$DATASET_ID.$TABLE_ID\`
 GROUP BY device_id" \
"$DATASET_ID.device_avg_temp"
```

---

### (Nice upgrade) Partition & cluster for cheaper/faster scans

If you expect lots of data, consider updating your Terraform table with time-partitioning and clustering:

```hcl
resource "google_bigquery_table" "events" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  table_id   = var.table_id

  time_partitioning {
    type  = "DAY"
    field = "timestamp"
  }

  clustering = ["device_id"]

  schema = file("${path.module}/schemas/events.json") # or keep your HEREDOC
  deletion_protection = false
  depends_on = [google_bigquery_dataset.main]
}
```