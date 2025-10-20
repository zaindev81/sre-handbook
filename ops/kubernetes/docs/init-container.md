# Init Container

**basic**

```sh
k apply -f k8s-yaml/init-container/basic/basic.yaml

k logs init-demo -c init-myservice

k logs init-demo -c app -f
```

**basic-db**

```sh
k apply -f k8s-yaml/init-container/basic-db/basic.yaml
```