# Network

## Subnets


```sh
[VPC: Your Project]
  │
  │  (Normal subnets: IPs used by VM, GKE, Cloud Run, etc.)
  │
  └───[Private Range for Google Services]
          │
          ▼
  [Service Networking] ← Network dedicated to Google-managed services
          │
          ▼
      [Cloud SQL (Private IP)]

      Cloud SQL
```

Create VPC
→ The foundation of the network.

Create Subnet
→ Reserve a private IP range for VMs and containers.

Reserve IP range for Cloud SQL
→ Dedicated for Google-managed services such as Cloud SQL.

Establish Service Networking connection
→ Enables private communication between the VPC and Google-managed services.

## Subnets

### 1. **ip_cidr_range**

**Role:**
Specifies the range of private IP addresses to be used within the subnet.

* It must be specified in **CIDR format** (e.g., `10.10.0.0/20`).

| Example        | Description                       |
| -------------- | --------------------------------- |
| `10.10.0.0/24` | 256 IP addresses (small scale)    |
| `10.10.0.0/20` | 4,096 IP addresses (medium scale) |
| `10.10.0.0/16` | 65,536 IP addresses (large scale) |

---

### **Why specify CIDR?**

You need to **reserve IP addresses** in advance for resources like VMs, Cloud Run, and GKE running inside the subnet.

If you don't allocate an appropriate size, IPs could run out when the number of resources grows in the future.

---

### **Recommended Sizes**

* **Development environment** → `/24` (about 256 IPs)
* **Production environment** → `/20` (about 4,096 IPs)


```sh
[VPC: my-vpc]  ← The overall network framework
   │
   ├─ [Subnet: dev-subnet] → IP: 10.10.0.0/20
   │         ↑
   │         │
   │    Cloud SQL, VM, GKE, etc. use IPs within this range
   │
   └─ [Subnet: prod-subnet] → IP: 10.20.0.0/20
             ↑
             │
        Production environment resources use this range
```

**`prefix_length` (Size planning is critical)**

* The **minimum** is `/24` (256 IPs).
* The **recommended** size is `/16` (65,536 IPs).
  It’s safer to allocate a larger range, considering future expansion and the possibility of using **other Google-managed services** in addition to Cloud SQL.

**Tip:**
If you're unsure, it's common practice to **allocate `/16`** and leave the extra IPs unused until you have a clearer understanding of actual demand.
