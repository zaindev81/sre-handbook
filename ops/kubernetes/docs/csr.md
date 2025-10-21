# CSR

```sh

openssl genrsa -out user.key 2048
openssl req -new -key user.key -subj "/CN=demo/O=developers" -out user.csr

cat user.csr | base64 | tr -d '\n'

kubectl get csr
k apply -f k8s-yaml/csr/basic/basic.yaml


kubectl certificate approve demo-csr
# or
kubectl certificate deny demo-csr

kubectl get csr demo-csr -o jsonpath='{.status.certificate}' | base64 --decode > demo.crt

kubectl get csr | grep system:node

# ~/.kube/config
users:
- name: demo
  user:
    client-certificate: /path/to/demo.crt
    client-key: /path/to/demo.key

kubectl config set-context demo-context \
  --cluster=minikube \
  --user=demo
kubectl config use-context demo-context

k delete csr
```