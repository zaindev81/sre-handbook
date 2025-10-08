# Cloud SQL

- https://cloud.google.com/sql
- https://cloud.google.com/sql/docs
- https://cloud.google.com/sql/docs/introduction


- MySQL, PostgreSQL, SQL Server, AlloyDB

```sh
sudo apt-get update
sudo apt-get install postgresql-client -y

psql -h <CLOUD_SQL_PRIVATE_IP> -U <DB_USER> -d <DB_NAME>
\dt
```

**AlloyDB for PostgreSQL** is a fully managed, PostgreSQL-compatible database service from Google Cloud, designed for your most demanding enterprise workloads. It combines the familiar open-source PostgreSQL database engine with Google's cloud-native infrastructure for superior performance, availability, and scale.

It's positioned as a premium, high-performance upgrade from standard Cloud SQL for PostgreSQL.

---

## Key Architectural and Performance Differences from PostgreSQL

AlloyDB's superior performance and enterprise-grade features stem from its cloud-native architecture, which enhances the open-source PostgreSQL core.

| Feature | AlloyDB | Standard PostgreSQL |
| :--- | :--- | :--- |
| **Performance (Transactions)** | Up to **4x faster** for transactional workloads (OLTP). | Standard PostgreSQL performance. |
| **Performance (Analytics)** | Up to **100x faster** analytical queries via a built-in columnar engine. | Standard row-based storage performance. |
| **Architecture** | **Disaggregated** compute and storage; independent scaling. Data stored in a distributed, intelligent storage system. | Traditional monolithic architecture; compute and storage are coupled. |
| **Caching** | **Multi-layered, adaptive caching** including an ultra-fast cache. | Relies on standard memory/file system cache. |
| **Availability** | Industry-leading **99.99% SLA**, inclusive of maintenance, with fast failover (under 60 seconds). | Requires manual configuration for high availability and disaster recovery. |
| **Scalability** | Independent scaling of compute and storage. Supports up to **20 read pool instances** for horizontal scaling. | Limited scalability; horizontal scaling requires read replicas and more complex setup. |
| **AI/ML** | Includes **AlloyDB AI** extensions (`vector`, `alloydb_scann`) for high-performance vector search and native integration with **Vertex AI**. | Standard PostgreSQL extensions like `pgvector` are available but without the same performance-optimized columnar engine or native AI/ML integration. |
| **Administration** | **Fully managed** by Google Cloud with "autopilot" features like automated memory management, adaptive vacuuming, backups, and patching. | Requires manual setup and ongoing operational management. |

---

## Primary Use Cases

AlloyDB is ideal for mission-critical applications that require extreme performance and reliability:

* **Demanding Transactional Workloads (OLTP):** High-throughput applications like e-commerce, gaming, and financial systems that need low-latency and fast response times.
* **Hybrid Transactional and Analytical Processing (HTAP):** Workloads that combine real-time transactional processing with fast, complex analytical queries on the same operational data without needing to move it to a separate data warehouse.
* **Next-Generation AI Applications:** Building generative AI and semantic search applications by leveraging AlloyDB AI's high-performance vector search extensions and Vertex AI integration.

The downloadable edition, **AlloyDB Omni**, allows you to run the same high-performance database engine on your laptop, data center, or other clouds for development, evaluation, and non-commercial use.

This video describes how AlloyDB enables a single platform for transactional, analytical, and generative AI workloads: [Accelerate analytics and semantic search in real-time with AlloyDB for PostgreSQL](https://www.youtube.com/watch?v=EG9nayN3c88).
http://googleusercontent.com/youtube_content/0