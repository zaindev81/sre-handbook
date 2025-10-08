# Billing

**Using personal cards = separate billing accounts per person → reimbursements are cumbersome.**

Create **one company-wide billing account** (corporate card/invoice) ⇒ **centralize charges for all projects**, and **unify budgets, cost analysis, and alerts**.

## Practical steps (fastest path)

### 1) Create a shared billing account (this is option D)

* Console → **Billing** → **Create billing account**
* Register the company payment method (corporate card / invoicing)
* Grant admins on the billing account (**Billing Account Administrator**)

### 2) Link existing projects to the new billing account

**Console**

* For each project → **Billing** → **Account management** → **Change billing account** → select the new account

**gcloud** (handy for bulk migration)

```bash
# Billing account ID format: "XXXXXX-XXXXXX-XXXXXX"
gcloud beta billing projects link <PROJECT_ID> \
  --billing-account=<BILLING_ACCOUNT_ID>
```

**Terraform** (lock it in as IaC)

```hcl
resource "google_project_billing_info" "this" {
  project         = var.project_id
  billing_account = var.billing_account_id
}
```

### 3) Permissions (common stumbling block)

* On the new billing account: **Billing Account User** (link permission) / **Billing Account Administrator** (management)
* On the project: **Project Billing Manager** (can change the billing account)

> Without these, linking will fail with a permissions error.

---

## Finishing touches (ops best practices)

* **Budgets & alerts**: set **Budgets + Email/Slack** notifications on the billing account
* **Cost visibility**: enable **BigQuery export** and build dashboards in **Looker Studio**
* **Policy**: enforce controls (e.g., **disallow linking to personal billing accounts**) via Org Policy/IAM
* **Folder/project structure**: separate by environment (dev/stg/prod) and standardize links and roles
* **Tags/labels**: add labels like `team=xxx`, `env=prod` to simplify cost allocation