# Volume

**basic**

```sh
k apply -f volume/basic.yaml

k exec -it basic-volume-pod -- sh
ls /usr/share/busybox
cat /usr/share/busybox/hello.txt
```

**shared-volume**

```sh
k apply -f volume/shared-volume.yaml

k exec -it shared-volume-pod -c reader -- sh
cat /data/hello.txt

k logs shared-volume-pod -c reader
```