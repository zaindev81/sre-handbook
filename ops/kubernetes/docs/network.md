## 🧩 Overall Flow

```
[User on Internet]
        ↓
     [Ingress]
        ↓
     [Service]
        ↓
       [Pod]
```

Ingress sends external HTTP(S) requests to a **Service**, and the Service forwards them to the **Pods**.

---

## Step 0

```sh
# Enable the NGINX Ingress controller
minikube addons enable ingress

# wait for all to be 1/1 Running
kubectl get pods -n ingress-nginx

# should list: nginx
kubectl get ingressclass
```


## 🧱 Step 1: Create a Deployment (Pods)

Let’s start with a simple NGINX Deployment.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

✅ This creates **2 Pods** labeled `app: nginx`.

---

## 🧱 Step 2: Create a Service (ClusterIP)

Now expose those Pods internally inside the cluster using a **Service**.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - port: 80         # Service port (used by Ingress)
      targetPort: 80   # Pod containerPort
  type: ClusterIP
```

✅ This allows other Kubernetes resources (like Ingress) to reach the Pods through the Service name (`nginx-service`).

---

## 🧱 Step 3: Create an Ingress Resource

Now define the **Ingress** to allow external HTTP traffic.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: example.com           # Change to your domain or use a local test domain
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
```

✅ This Ingress rule means:

> “When someone visits `http://example.com/`, send that traffic to `nginx-service` on port 80.”

---

## 🧱 Step 4: Deploy All

Save all three YAMLs (Deployment, Service, Ingress) and apply:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

Check they’re working:

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

---

## 🌐 Step 5: Access the App

### Option 1: Using Minikube (local)

If you’re running Minikube:

```bash
minikube tunnel
```

Then get the Ingress IP:

```bash
kubectl get ingress
```

You’ll see something like:

```
NAME             CLASS   HOSTS          ADDRESS        PORTS
nginx-ingress    nginx   example.com    127.0.0.1      80
```

Now add this line to your `/etc/hosts`:

```
127.0.0.1  example.com
```

Then open → **[http://example.com](http://example.com)**

---

## ⚙️ Step 6: (Optional) Add TLS (HTTPS)

Create a TLS secret:

```bash
kubectl create secret tls nginx-tls \
  --cert=cert.crt \
  --key=cert.key
```

Update Ingress:

```yaml
tls:
  - hosts:
      - example.com
    secretName: nginx-tls
```

Then you can access via **[https://example.com](https://example.com)**

---

## ✅ Summary Table

| Component      | Type                   | Purpose                | Connection                           |
| -------------- | ---------------------- | ---------------------- | ------------------------------------ |
| **Deployment** | `apps/v1`              | Run NGINX pods         | Creates Pods with label `app: nginx` |
| **Service**    | `v1`                   | Internal load balancer | Selects Pods via label `app: nginx`  |
| **Ingress**    | `networking.k8s.io/v1` | External entry point   | Routes HTTP(S) traffic to Service    |

## TLS

Great—let’s add HTTPS to your Ingress. Here are three practical ways; pick one.

# Option A (recommended for local dev): **mkcert** (trusted, no browser warnings)

1. Install mkcert (Mac):

```bash
brew install mkcert nss   # nss helps Firefox trust the cert
mkcert -install
```

2. Create a cert for your host:

```bash
mkcert example.com
# creates: example.com.pem (cert) and example.com-key.pem (key)
```

3. Create the TLS secret **in the same namespace as your Ingress** (often `default`):

```bash
kubectl create secret tls nginx-tls \
  --cert=example.com.pem \
  --key=example.com-key.pem \
  -n default
```

4. Add TLS to your Ingress (and force HTTPS redirect if you want):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - example.com
      secretName: nginx-tls
  rules:
    - host: example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
```

5. Apply and verify:

```bash
kubectl apply -f ingress.yaml
kubectl get secret nginx-tls -n default
kubectl describe ingress nginx-ingress
```

6. Test (keep `minikube tunnel` running):

```bash
curl -v https://example.com
# or to be explicit:
curl -v --resolve example.com:443:127.0.0.1 https://example.com
```

Your browser should trust the cert automatically (thanks to mkcert’s local CA).

---

# Option B: **Self-signed OpenSSL** (quick, but browser shows warning)

1. Make a self-signed cert:

```bash
openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
  -keyout example.com.key \
  -out example.com.crt \
  -subj "/CN=example.com"
```

2. Create secret and update the same Ingress YAML as above:

```bash
kubectl create secret tls nginx-tls \
  --cert=example.com.crt \
  --key=example.com.key \
  -n default
```

3. Test (ignore cert errors):

```bash
curl -vk https://example.com
```

---

# Option C (production-like): **cert-manager + Let’s Encrypt**

Use this when you have a real public domain + DNS pointing to your cluster.

* Install cert-manager
* Create ClusterIssuer (Let’s Encrypt)
* Annotate/extend your Ingress to request a cert automatically
  (We can set this up together when you’re ready.)

---

## Don’t forget

* Keep `/etc/hosts` → `127.0.0.1 example.com`
* Keep `minikube tunnel` running (binds 80/443)
* Secret **namespace must match** your Ingress namespace
* Check the controller Service exposes 443:

```bash
kubectl -n ingress-nginx get svc ingress-nginx-controller
# PORT(S) should include 443
```

If you paste your current Ingress YAML (or tell me its namespace), I’ll tailor the exact `kubectl` commands for your setup.
