# Config Map

## basic

**basic-pod**

```sh
k apply -f k8s-yaml/config-map/basic/basic-pod.yaml

k exec -it env-demo -- sh
env

k exec -it env-demo -- printenv

k delete -f k8s-yaml/config-map/basic/basic-pod.yaml
```

**basic-deployment**

```sh
k apply -f k8s-yaml/config-map/basic/basic-deployment.yaml

kd deploy env-demo
k get po
k exec -it env-demo-84d799b95c-p9w9p -- printenv

k delete -f k8s-yaml/config-map/basic/basic-deployment.yaml
```

## config-map

**basic**

```sh
k apply -f k8s-yaml/config-map/config-map/basic.yaml

kd deploy env-demo
k get po
k exec -it env-demo-84d799b95c-p9w9p -- printenv

k get configmap
kd configmap env-demo-config

k delete -f k8s-yaml/config-map/basic/basic-deployment.yaml
```

**basic-key**

```sh
k apply -f k8s-yaml/config-map/config-map/basic-key.yaml

k get po
k exec -it cm-one-key-env -- printenv
k logs cm-one-key-env

k get configmap
kd configmap app-cfg

k delete -f k8s-yaml/config-map/config-map/basic-key.yaml
```

## pod-metadata

**basic**

```sh
k apply -f k8s-yaml/config-map/pod-metadata/basic.yaml

kd po metadata-demo
k logs metadata-demo

k delete -f k8s-yaml/config-map/pod-metadata/basic.yaml
```

**annotation**

```sh
k apply -f k8s-yaml/config-map/pod-metadata/annotation.yaml

kd po metadata-file-demo
k logs metadata-file-demo

k delete -f k8s-yaml/config-map/pod-metadata/annotation.yaml
```

## secret

**basic**

```sh
k apply -f k8s-yaml/config-map/secret/basic.yaml

kubectl get secret my-secret -o yaml
kubectl logs secret-env-demo

echo -n "admin" | base64
echo YWRtaW4= | base64 --decode

k delete -f k8s-yaml/config-map/secret/basic.yaml
``