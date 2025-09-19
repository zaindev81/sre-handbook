# IAM

## Flow

```
[1] Create Service Account
        ↓
[2] Assign roles using IAM
        ↓
[3] If necessary, generate a key and provide it to external systems
```

---

## Key Points

* A **Service Account** is an account for **programs or Terraform** to operate and manage GCP resources.
* In **IAM**, it is essential as the **unit for access control and permissions management**.
* In practice, the typical process is:
  **"Create Service Account" → "Assign Roles" → "Generate Key"**.


```sh
gcloud iam roles copy
```
