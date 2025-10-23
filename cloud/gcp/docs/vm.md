# VM

## MIG

```
gcloud compute instance-groups managed list
gcloud compute instance-groups managed describe web-mig --region asia-southeast1 \
  --format='get(targetSize, currentActions, status.isStable)'

gcloud compute forwarding-rules describe web-forwarding-rule \
  --region=us-central1 \
  --format="get(IPAddress)"

gcloud compute instance-groups managed describe web-mig --region=us-central1 | grep -A5 currentActions
```

```sh
sudo apt-get install apache2-utils
brew install apache2

# Load Testing Execution (100 Concurrent Connections, 10,000 Requests)
ab -n 10000 -c 100 http://<LOAD_BALANCER_IP>/

# Longer Duration Load Test
ab -t 300 -c 50 http://<LOAD_BALANCER_IP>/

# cpu
sudo apt install stress -y
stress --cpu 4 --timeout 120
```