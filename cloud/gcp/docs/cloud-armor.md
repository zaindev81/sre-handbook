# Cloud Armor

Google Cloud Armor is a **global security service** from Google Cloud that provides protection for your web applications and services against a variety of threats from the internet. It acts as a **Web Application Firewall (WAF)** and a Distributed Denial-of-Service (DDoS) defense service.

It's enforced at the **edge of Google's network** and integrates seamlessly with Google Cloud's external Load Balancers.

***

## Key Features and Benefits

| Feature | Description | Benefit |
| :--- | :--- | :--- |
| **DDoS Protection** | Provides **always-on defense** against volumetric and protocol-based DDoS attacks (Layer 3, 4, and 7). | Ensures your applications remain **available** and **performant** even under large-scale attack. |
| **Web Application Firewall (WAF)** | Uses **pre-configured WAF rules** (based on OWASP Top 10) and allows for custom rules to inspect and filter application layer (Layer 7) traffic. | Mitigates common web application vulnerabilities like **SQL Injection** (SQLi) and **Cross-Site Scripting** (XSS). |
| **Adaptive Protection** | A machine learning-based system that **automatically detects** and alerts you to high-volume Layer 7 DDoS attacks, and even suggests WAF rules to mitigate them. | Provides intelligent, real-time defense against sophisticated application-layer attacks with minimal manual effort. |
| **Access Control** | Allows you to **allowlist** (allow) or **denylist** (block) traffic based on IP addresses, CIDR ranges, and geographic location (geo-blocking). | Helps you control access to your applications for security or compliance purposes. |
| **Rate Limiting** | Allows you to set limits on the number of incoming requests from a client or IP range over a given time period. | Protects your backends from being overwhelmed by traffic spikes or brute-force/bot attacks. |
| **Hybrid & Multi-Cloud Support** | Can be used to protect applications and services deployed on Google Cloud, **on-premises**, or in **other public clouds**. | Provides a consistent security policy across your entire application ecosystem. |

***

## Service Tiers

Google Cloud Armor is generally offered in two tiers:

1.  **Cloud Armor Standard:**
    * **Pay-as-you-go** pricing model.
    * Includes **always-on DDoS protection** and access to **WAF rules** (pre-configured and custom).

2.  **Cloud Armor Enterprise:**
    * A subscription-based service (Annual or Paygo) with a more predictable monthly price.
    * Includes **full Adaptive Protection** (including alerts and suggested rules), DDoS bill protection, and access to **DDoS response team** services (for Annual subscribers).

***

## Common Use Cases

* **DDoS Attack Mitigation:** Its primary use is to defend against both network-layer (L3/L4) and application-layer (L7) Distributed Denial-of-Service attacks.
* **OWASP Top 10 Protection:** Applying pre-configured WAF rules to protect applications against the most critical web application security risks (e.g., SQLi, XSS, Remote Code Execution).
* **Geo-restriction:** Enforcing compliance or reducing the attack surface by blocking traffic from specific countries or regions.
* **Bot Management:** Using rate-limiting and integration with reCAPTCHA Enterprise to manage and block malicious automated traffic.
* **Restricting Access:** Creating an **allowlist** for specific IP ranges (like your corporate network) and blocking all other incoming traffic for highly sensitive applications.