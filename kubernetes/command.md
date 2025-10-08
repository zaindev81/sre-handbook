# Command

```sh
k apply -f nginx.yaml
k apply -f nginx-service.yaml

# get
k get po
k get svc

# delete
k delete -f nginx.yaml
k delete svc nginx-service

# port forward
k port-forward pod/nginx 8080:80
k port-forward service/nginx-service 8080:80

# playground
http :8080
```