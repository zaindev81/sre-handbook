# VM

## basic

```sh
gcloud auth login
gcloud auth application-default login
gcloud services enable compute.googleapis.com
gcloud compute ssh basic-vm --zone=us-central1-a

gcloud compute instances list
curl http://<EXTERNAL_IP>
```
##