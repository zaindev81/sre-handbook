# IAM

## Flow

In Google Cloud Platform (GCP), a service account name usually refers to the email address of the service account.
It uniquely identifies the service account in your GCP project.
terraform-admin@<your-project-id>.iam.gserviceaccount.com


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

- Workload Identify
- Group