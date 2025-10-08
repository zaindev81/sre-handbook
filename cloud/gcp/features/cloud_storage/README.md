# Cloud Storage

```sh
export YOUR_PROJECT_ID=
export YOUR_BUCKET_NAME=
export YOUR_LOG_BUCKET_NAME=
gcloud storage buckets list --project $YOUR_PROJECT_ID
```

Upload a file

```sh
# Create a small test file
echo "Hello from Terraform bucket test" > test.txt

# Upload to your bucket
gcloud storage cp test.txt gs://$YOUR_BUCKET_NAME/
```

List objects in the bucket

```sh
gcloud storage ls gs://$YOUR_BUCKET_NAME/
```

Download the file

```sh
gcloud storage cp gs://$YOUR_BUCKET_NAME/test.txt ./downloaded.txt
cat downloaded.txt
```

Delete the file

```sh
gcloud storage rm gs://$YOUR_BUCKET_NAME/test.txt
```

View bucket details

```sh
gcloud storage buckets describe gs://$YOUR_BUCKET_NAME
```

Optional: Check logs bucket

```sh
gcloud storage buckets list --project $YOUR_PROJECT_ID
gcloud storage ls gs://$YOUR_BUCKET_NAME/
```
