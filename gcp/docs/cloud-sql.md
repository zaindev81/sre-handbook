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