# Cloud SQL

## Docs

- https://cloud.google.com/sql
- https://cloud.google.com/sql/docs
- https://cloud.google.com/sql/docs/introduction

## Overview

- MySQL, PostgreSQL, SQL Server, AlloyDB

```sh
sudo apt-get update
sudo apt-get install postgresql-client -y

psql -h <CLOUD_SQL_PRIVATE_IP> -U <DB_USER> -d <DB_NAME>
\dt
```

## **When Should I Use AlloyDB?**

You should use **AlloyDB for PostgreSQL** for **mission-critical enterprise workloads** that require **high performance, high availability, and real-time analytics**. It's the best choice when standard PostgreSQL or Cloud SQL is insufficient to meet your demands for speed and reliability.

---

### Key Scenarios for Choosing AlloyDB

AlloyDB is the optimal choice when your application meets the following three requirements:

### 1. You Need Top-Tier Transactional Performance and Availability (OLTP)
* **Use Cases:** E-commerce transaction processing, financial trading systems, or backends for large-scale SaaS applications—any service with a **high write frequency and zero tolerance for downtime**.
* **AlloyDB's Advantages:**
    * **Up to 4x faster** transactional processing than standard PostgreSQL.
    * An industry-leading **99.99% SLA**, which includes maintenance time.
    * **Near-zero downtime maintenance** and fast automatic failover (under 60 seconds).

### 2. You Need to Combine Real-Time Analytics and Transactional Processing (HTAP)
* **Use Cases:** You want to perform rapid aggregation and analysis of operational data **in place** (without moving it to a separate data warehouse) for real-time recommendations or decision-making.
* **AlloyDB's Advantages:**
    * The built-in **Columnar Engine** makes analytical queries **up to 100x faster** than standard PostgreSQL.
    * It eliminates the need for complex ETL (Extract, Transform, Load) pipelines, ensuring your analysis is always based on the freshest data.

### 3. You Need to Integrate AI/ML Directly with Your Database
* **Use Cases:** Building advanced features like vector search for semantic queries, product similarity searches, or integrating with generative AI models.
* **AlloyDB's Advantages:**
    * **AlloyDB AI** provides highly optimized **vector search** capabilities.
    * Easy integration with Google's AI platform, **Vertex AI**.

---

### Deciding Between AlloyDB and Cloud SQL

| Feature | Cloud SQL | AlloyDB for PostgreSQL |
| :--- | :--- | :--- |
| **Best For** | Small to medium-sized general workloads, basic web apps, or simple cloud migrations. | **Mission-critical** enterprise workloads, HTAP, and high-load services. |
| **Performance** | Standard PostgreSQL performance. | **Ultra-fast** (4x transactions, 100x analytics). |
| **Availability (SLA)** | 99.95% (including maintenance). | **99.99%** (including maintenance). |
| **Architecture** | Traditional model (compute and storage linked). | **Decoupled** compute and storage for better performance and scale. |
| **Pricing** | **Lower cost** for starting small. | Higher price point, but offers **better price-performance** for demanding loads. |

**In short, start with Cloud SQL, and only move to AlloyDB when your performance, availability, or HTAP requirements become critical and require the absolute best Google Cloud offers for PostgreSQL.**