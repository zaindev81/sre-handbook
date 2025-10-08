# Cloud Load Balancer

Google Cloud Load Balancing is a fully distributed, software-defined, managed service that distributes user traffic across multiple application instances to ensure high availability, scalability, and performance. It operates globally, allowing you to manage traffic across regions with a single anycast IP address and providing automatic failover.

## Key Types of Google Cloud Load Balancers

Google Cloud Load Balancing is categorized into two main types based on the OSI model layer they operate at:

| Load Balancer Type | OSI Layer | Traffic Type | Key Characteristics |
| :--- | :--- | :--- | :--- |
| **Application Load Balancers (ALB)** | **Layer 7** (Application) | **HTTP/HTTPS** | **Content-aware** routing based on URL path, host header, etc. Provides SSL/TLS termination and integration with Cloud CDN and Cloud Armor. |
| **Network Load Balancers (NLB)** | **Layer 4** (Transport) | **TCP, UDP, SSL/TLS** (non-HTTP/HTTPS) | Operates at the network layer. Subdivided into **Proxy Network Load Balancers** (terminates TCP/SSL) and **Passthrough Network Load Balancers** (non-proxy, preserves client IP). |

***

## Deployment Modes

Both Application and Network Load Balancers can be deployed as **External** or **Internal** and can be further defined by their geographical scope:

| Deployment Mode | Description | Traffic Exposure | Geographical Scope |
| :--- | :--- | :--- | :--- |
| **External** | Handles traffic originating from the **internet**. | Public-facing via a global or regional external IP address. | **Global** (across multiple regions) or **Regional** (within a single region). |
| **Internal** | Handles traffic originating from **within your Virtual Private Cloud (VPC)** network. | Private-facing via a regional internal IP address. | **Regional** or **Cross-region**. |

***

## Core Features

Cloud Load Balancing provides several critical features for running applications at scale:

* **Global Anycast IP:** Provides a single, global IP address for your application, allowing for cross-region load balancing and simplified DNS setup.
* **Seamless Autoscaling:** Scales instantly and automatically to handle unexpected traffic spikes without the need for pre-warming.
* **High Availability and Failover:** Automatically directs traffic away from unhealthy instances or regions to healthy ones.
* **Health Checks:** Continuously monitors the health and responsiveness of backend instances to ensure traffic is only sent to working servers.
* **SSL/TLS Termination (Offload):** You can manage SSL certificates and decrypt traffic at the load balancer level, offloading the processing burden from your backend instances.
* **Security:** Offers protection from Distributed Denial of Service (DDoS) attacks and integrates with **Cloud Armor** (a web application firewall) for advanced security policies.

This video on [Cloud Load Balancing](https://www.youtube.com/watch?v=egkxWAmw4BQ) provides an overview of how the service works to manage fluctuating application traffic and ensure high performance.
http://googleusercontent.com/youtube_content/4