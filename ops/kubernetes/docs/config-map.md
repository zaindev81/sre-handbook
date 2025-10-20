# Config Map

## basic

**basic-pod**

```sh
k apply -f config-map/basic/basic-pod.yaml

k exec -it env-demo -- sh
env

k exec -it env-demo -- printenv
```

**basic-deployment**

```sh
k apply -f config-map/basic/basic-deployment.yaml

kd deploy env-demo
k exec -it env-demo-84d799b95c-gw9x7 -- printenv
```

## configmap

## pod-metadata

## secret
