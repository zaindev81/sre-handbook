# Cloud Spanner

## Docs

- https://cloud.google.com/spanner
- https://cloud.google.com/spanner/docs
- https://cloud.google.com/spanner/docs/getting-started/set-up

## Overview

**Google Cloud Spanner** is a fully managed, globally distributed, and strongly consistent database service offered by Google Cloud Platform (GCP).

It is unique because it combines the best features of:

* **Traditional Relational Databases (RDBMS):** It supports a relational schema, SQL (GoogleSQL and PostgreSQL dialects), indexes, and **ACID transactions** (Atomicity, Consistency, Isolation, Durability).
* **Cloud-native NoSQL Databases:** It provides **horizontal scalability** to virtually unlimited scale and **high availability** across regions, a feature typically associated with NoSQL databases.

In essence, Cloud Spanner is a **Distributed SQL** database that provides a relational experience while operating at a global, planet-scale, which makes it suitable for mission-critical applications.

### Key Features

* **Global Strong Consistency:** It guarantees strong consistency (specifically, **external consistency** which is a stronger form of serializability) across its entire distributed architecture, even across continents. This is achieved using an innovative time synchronization technology called **TrueTime**, which uses atomic clocks and GPS.
* **Unlimited Horizontal Scaling:** It automatically shards (partitions) and distributes data across multiple nodes and regions, allowing you to scale your database capacity linearly without manual sharding or re-architecture.
* **High Availability:** It offers a leading Service Level Agreement (SLA) of up to **99.999% availability** for multi-region instances, ensuring virtually no downtime for your applications.
* **Fully Managed:** Google Cloud manages all aspects of the database, including replication, sharding, backup, and failover, simplifying operations.
* **Multi-Model Support:** It supports relational, key-value, graph, and vector search workloads within a single database.

### Common Use Cases

Cloud Spanner is designed for demanding, transactional workloads that require both high throughput and strong consistency at a global scale. Examples include:

* **Financial Trading and Banking Systems:** For critical, high-load transactions that must be instantly and globally consistent.
* **Gaming:** To support massive numbers of concurrent global users with low-latency access and a consistent experience.
* **E-commerce and Retail:** For real-time global inventory and order management, especially during peak traffic events like flash sales.
* **Supply Chain and Logistics:** For managing complex, globally distributed event-sourced systems.
* **High-Scale Applications:** It powers critical Google services like Google Ads, Gmail, and Google Photos.

### Command

```sh
export PROJECT_ID=
export INSTANCE=
export DATABASE=

gcloud spanner databases execute-sql ${DATABASE} \
    --instance=${INSTANCE} \
    --sql="INSERT INTO Users (UserId, Name, Email) VALUES ('user-101', 'Carl Johnson', 'carl.j@example.com')" \
    --project=${PROJECT_ID}

gcloud spanner databases execute-sql ${DATABASE} \
    --instance=${INSTANCE} \
    --sql="SELECT UserId, Name, Email, Created FROM Users" \
    --project=${PROJECT_ID}

gcloud spanner databases shell ${DATABASE} \
    --instance=${INSTANCE} \
    --project=${PROJECT_ID}
```

## Difference
The differences between Cloud Spanner, Cloud SQL, and Cloud Bigtable primarily come down to their **data model**, **scalability**, and **consistency guarantees**.

These three are Google Cloud's main managed transactional database services, each designed for distinct use cases.

| Feature | Cloud Spanner | Cloud SQL | Cloud Bigtable |
| :--- | :--- | :--- | :--- |
| **Database Type** | **NewSQL** (Relational with NoSQL scalability) | **Relational (SQL)** | **NoSQL** (Wide-Column) |
| **Data Model** | Structured (Tables, Rows, Columns, Schemas) | Structured (Tables, Rows, Columns, Schemas) | Semi-structured (Massive key/value/timestamp map) |
| **Query Language** | **SQL** | **SQL** (MySQL, PostgreSQL, SQL Server) | API calls (HBase API), not standard SQL |
| **Scalability** | **Horizontal (unlimited)**: Scales reads/writes across nodes globally. | **Vertical** (increase machine size) and **Read Replicas** (horizontal for reads only). | **Horizontal (massive)**: Scales reads/writes to petabytes of data. |
| **Consistency** | **Strongly Consistent** (Globally ACID compliant) | **Strongly Consistent** (ACID compliant) | **Strong consistency within a single row**; eventual consistency across clusters. |
| **Use Cases** | Global mission-critical OLTP (Online Transaction Processing), large-scale financial, gaming, or inventory systems. | General-purpose OLTP for web frameworks, CRM, user credentials, and applications needing up to a few terabytes. | High-throughput, low-latency, massive data (IoT, time-series, analytics, operational data, ad tech, machine learning feature stores). |

***

### 1. Cloud Spanner

Cloud Spanner is designed to solve the problem of scaling a traditional SQL database to a **global scale** without sacrificing transactional consistency.

* **What it is:** A globally-distributed, strongly consistent relational database service (often called a NewSQL database).
* **Key Strength:** It combines the **relational structure and SQL capabilities** of a traditional database with the **unlimited horizontal scalability** of a NoSQL database. It is the only service that provides **global, synchronous, strong consistency** for multi-row, multi-table transactions across regions and continents.
* **Use Case:** If your application needs the structure and transactional guarantees of SQL but must handle petabytes of data and serve users globally with no downtime.

***

### 2. Cloud SQL

Cloud SQL is the easiest and most familiar starting point. It's a fully managed service for traditional relational databases.

* **What it is:** A managed service for MySQL, PostgreSQL, and SQL Server.
* **Key Strength:** It's great for applications that require **full ACID compliance** (Atomicity, Consistency, Isolation, Durability) and traditional relational features like joins and foreign keys, but only need to scale vertically (or horizontally for reads using replicas) up to a few terabytes.
* **Limitation:** It is generally regional and has limits on how much data it can handle before sharding becomes a necessary, application-level concern.

***

### 3. Cloud Bigtable

Cloud Bigtable is a classic NoSQL database designed for extreme throughput and latency for massive operational and analytical workloads.

* **What it is:** A fully managed, **wide-column NoSQL database**. It is the same technology that powers many core Google services, like Search and Gmail.
* **Key Strength:** It excels at **high read/write throughput** and **low latency** for applications dealing with massive datasets (petabytes). Its structure is optimized for querying by a single key (the row key).
* **Limitation:** It is not a relational database, does **not support joins**, and does not use standard SQL. Transactions are only guaranteed to be atomic **within a single row**.

### **When to Choose Cloud Spanner**

Cloud Spanner is selected when you have extremely large-scale requirements that Cloud SQL cannot handle.

* **When Limitless Scalability is Necessary:**
    * Choose Spanner if you anticipate a massive dataset exceeding **terabytes** and requiring exceptionally high transactional throughput.
* **When Global Availability is Required:**
    * It is mandatory for distributed environments spanning **multiple regions or continents** that require consistent data (**strong global consistency**) and an extremely high availability SLA of **99.999%**.
    * For most small to medium-sized applications, the regional availability of Cloud SQL (**99.95% or 99.99%**) is sufficient.