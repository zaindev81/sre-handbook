# Volume

## basic

**basic-volume**

```sh
k apply -f k8s-yaml/volume/basic/basic-volume.yaml

k exec -it basic-volume-pod -- sh
ls /usr/share/busybox
cat /usr/share/busybox/hello.txt

k exec -it basic-volume-pod -- /bin/sh -c "cat /usr/share/busybox/hello.txt"

k delete -f k8s-yaml/volume/basic/basic-volume.yaml
```

**shared-volume**

```sh
k apply -f k8s-yaml/volume/basic/shared-volume.yaml

k exec -it shared-volume-pod -c reader -- sh
cat /data/hello.txt

k exec -it shared-volume-pod -- /bin/sh -c "cat /data/hello.txt"

k logs shared-volume-pod -c reader
k logs shared-volume-pod -c writer

k delete -f k8s-yaml/volume/basic/shared-volume.yaml
```

**memory-volume**

```sh
k apply -f k8s-yaml/volume/basic/memory-volume.yaml

k exec -it memory-volume-pod -c reader -- sh
cat /data/hello.txt

k exec -it memory-volume-pod -- /bin/sh -c "cat /data/hello.txt"

k logs memory-volume-pod -c reader
k logs memory-volume-pod -c writer

k delete -f k8s-yaml/volume/basic/memory-volume.yaml
```