# Vertical Pod Autoscaler(VPA)

**prerequisite**

```sh
minikube addons enable metrics-server
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-rbac.yaml


k get crd


git clone https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler
./hack/vpa-up.sh


kubectl get pods -n kube-system | grep vpa
```

**basic**

```sh
k apply -f k8s-yaml/vpa/basic/basic.yaml
kubectl get vpa

kubectl describe vpa vpa-demo
kubectl describe vpa vpa-demo | grep -A10 Recommendation

kubectl run -it --rm load --image=busybox -- /bin/sh -c 'while true; do wget -q -O- http://vpa-demo-svc.default.svc.cluster.local > /dev/null; done'

k get deploy -o wide -w
```

**debug**

```sh
  Recommendation:
    Container Recommendations:
      Container Name:  hpa-example
      Lower Bound:
        Cpu:     267m
        Memory:  250Mi
      Target:
        Cpu:     587m
        Memory:  250Mi
      Uncapped Target:
        Cpu:     587m
        Memory:  250Mi
      Upper Bound:
        Cpu:     1
        Memory:  512Mi
```


**Others**

```sh
k top pod
k top node
```