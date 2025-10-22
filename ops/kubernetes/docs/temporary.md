# Temporary

```sh
# wget
kubectl run -it --rm load --image=busybox -- /bin/sh \
  -c 'wget -q -O- https://example.com'

kubectl run -it --rm load --image=busybox -- /bin/sh \
  -c 'while true; do wget -q -O- http://cpu-svc.default.svc.cluster.local > /dev/null; done'

# curl
kubectl run -it --rm curl --image=curlimages/curl:latest -- /bin/sh \
  -c 'curl -s https://example.com'

kubectl run curl --image=curlimages/curl:latest --restart=Never -n default -- sleep 3600

kubectl exec -n default -it curl -- sh -lc 'nslookup demo-nginx.default.svc.cluster.local || getent hosts demo-nginx.default.svc.cluster.local || echo "dns failed"'
```