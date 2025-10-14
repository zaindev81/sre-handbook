# Storage

Perfect 👍 — here’s how to **load that `rows.json` file from Google Cloud Storage (GCS)** into your BigQuery table.

---

## ☁️ 1. Upload the file to Cloud Storage

If you haven’t uploaded it yet, use this command:

```bash
gsutil cp rows.json gs://YOUR_BUCKET/path/events.json
```

Example:

```bash
gsutil cp rows.json gs://my-sample-bucket/data/events.json
```

---

## 🧩 2. Load into BigQuery (JSON format)

```bash
bq --project_id="$PROJECT_ID" load \
  --source_format=NEWLINE_DELIMITED_JSON \
  "$DATASET_ID.$TABLE_ID" \
  gs://YOUR_BUCKET/path/events.json
```

✅ **Example (fully expanded):**

```bash
bq --project_id="my-gcp-project" load \
  --source_format=NEWLINE_DELIMITED_JSON \
  "example_dataset.events" \
  gs://my-sample-bucket/data/events.json
```

---

## ⚙️ Optional: if you want to overwrite existing data

Add `--replace` to truncate and reload:

```bash
bq --project_id="$PROJECT_ID" load \
  --replace \
  --source_format=NEWLINE_DELIMITED_JSON \
  "$DATASET_ID.$TABLE_ID" \
  gs://YOUR_BUCKET/path/events.json
```

---

## 🔍 3. Verify

After loading, confirm that rows exist:

```bash
bq --project_id="$PROJECT_ID" query --use_legacy_sql=false \
"SELECT * FROM \`$PROJECT_ID.$DATASET_ID.$TABLE_ID\` LIMIT 10"
```

---

Would you like me to show the version for **loading multiple JSON files** (e.g., `events-*.json`)?
