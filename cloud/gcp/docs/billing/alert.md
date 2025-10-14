# Billing Alert

Here’s how you can **set up a Billing Alert in Google Cloud (GCP)** — so you get notified before your spending exceeds your limit.

---

## ⚙️ Step-by-Step Guide: Setting Up a Billing Alert

### **1️⃣ Select Your Billing Account**

1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Open the navigation menu → **Billing** → choose your **Billing Account**.

---

### **2️⃣ Create a Budget**

1. In the left menu, select **“Budgets & alerts.”**
2. Click **“Create budget.”**
3. Configure:

   * **Name:** e.g. `monthly-budget`
   * **Project:** all projects or a specific one
   * **Service:** e.g. Compute Engine, BigQuery (optional)
   * **Time period:** monthly (or custom)
   * **Budget amount:** e.g. `100 USD`

---

### **3️⃣ Set Alert Thresholds**

1. Under “Alert threshold rules,” add the points when you want to receive notifications.
   Example:

   * 50% (when spending reaches $50)
   * 90% (when spending reaches $90)
   * 100% (when reaching the full budget)
2. Choose how you want to get alerts — via **email** or **Pub/Sub** for automation.

---

### **4️⃣ Configure Notification Method**

#### ✅ **Option A: Email Notifications**

1. Open **Cloud Monitoring** (formerly Stackdriver).
2. Go to **Alerts → Create alert policy.**
3. Add a **Billing metric** as the condition.
4. Choose a **notification channel** (Email, Slack, etc.).

#### ✅ **Option B: Pub/Sub + Automation**

1. Create a **Pub/Sub topic**.
2. Subscribe to it with **Cloud Functions** or **Cloud Run** to trigger actions automatically (e.g., send Slack messages or stop instances).

---

## 💻 Example (CLI)

You can also set up a budget using `gcloud`:

```bash
gcloud beta billing budgets create \
  --billing-account=XXXXXX-XXXXXX-XXXXXX \
  --display-name="monthly-budget" \
  --budget-amount=100USD \
  --threshold-rules="threshold-percent=0.5" \
  --threshold-rules="threshold-percent=0.9" \
  --threshold-rules="threshold-percent=1.0"
```

---

## 🧩 Example Setup

| Environment | Budget      | Notification      | Notes                 |
| ----------- | ----------- | ----------------- | --------------------- |
| Test        | $50/month   | Email             | Alerts at 50% and 90% |
| Production  | $1000/month | Slack via Pub/Sub | Automated handling    |

---

Would you like me to show you **how to automate Slack alerts** or **how to do this with Terraform** next?
