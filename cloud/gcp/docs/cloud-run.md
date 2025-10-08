# Cloud Run

Cloud Run is a **fully managed serverless platform** offered by Google Cloud that allows you to run **containerized applications** without having to manage the underlying infrastructure, like servers, clusters, or operating systems. It combines the flexibility of containers with the simplicity and automated scaling of a serverless environment.

---

## Key Features and How It Works

Cloud Run is built on **Knative**, an open-source platform extending Kubernetes to provide serverless workloads.

* **Serverless and Fully Managed:** You don't need to provision or manage virtual machines (VMs) or Kubernetes clusters. Google handles all the infrastructure management.
* **Container-Based:** You package your application, dependencies, and runtime into a Docker or OCI-compatible container image. This means you can use **any programming language or framework** (Go, Python, Java, Node.js, etc.).
* **Automatic Scaling (Scales to Zero):** Cloud Run automatically scales your containers horizontally based on incoming traffic, adjusting capacity to meet demand. Crucially, it can scale **down to zero** when there is no traffic, meaning you only pay when your code is running.
* **Pay-as-you-Go Pricing:** The cost model is highly efficient; you're only billed for the exact CPU and memory resources consumed during your application's execution time, often metered to the nearest 100 milliseconds.
* **Concurrency Control:** A single container instance can handle multiple incoming requests simultaneously, which improves performance and resource utilization.
* **Deployment Options:** Cloud Run supports two main resource types:
    * **Cloud Run Services:** Used for continuously running workloads that respond to web requests (HTTP/HTTPS, WebSockets, gRPC).
    * **Cloud Run Jobs:** Used for batch processing or run-to-completion tasks that do not respond to HTTP requests (e.g., scheduled scripts, data migrations).

---

## Common Use Cases

Cloud Run is versatile and suitable for a wide range of applications, offering a balance between the simplicity of functions and the power of full containers.

| Category | Example Use Cases |
| :--- | :--- |
| **Web & API** | Building and hosting **websites** and **web applications**. Deploying **RESTful or GraphQL APIs** and microservices. |
| **Data Processing**| Running batch jobs, cron jobs via **Cloud Scheduler**, and long-running data transformation tasks (**ETL/ELT**). |
| **Event-Driven** | Processing messages from **Cloud Pub/Sub** or events from other Google Cloud services via **Eventarc** (e.g., processing a file upload to Cloud Storage). |
| **AI/ML** | Hosting **Machine Learning models** for real-time inference via an API endpoint, with optional **GPU support**. |

You can learn more about its functionality by watching this quick introduction to the service: [Cloud Run in a minute](https://www.youtube.com/watch?v=AL2rAmWFZjM).
http://googleusercontent.com/youtube_content/1


Cloud Run Job is a serverless platform feature on Google Cloud for running **containerized tasks that execute to completion** and then exit. Unlike a Cloud Run *Service*, which continuously listens for and serves web requests, a job is designed for batch processing, scripting, and other non-request-driven workloads.

# Cloud Run Job

## Core Differences: Job vs. Service

The fundamental distinction lies in their purpose and lifecycle:

| Feature | Cloud Run Job | Cloud Run Service |
| :--- | :--- | :--- |
| **Primary Use Case** | Run-to-completion, batch, or scheduled tasks. | Continually running web applications, APIs, and microservices. |
| **Request Handling** | **Does not** listen for or serve HTTP requests. | **Listens for and serves** HTTP requests to an endpoint (URL). |
| **Lifecycle** | Runs its tasks and **exits when finished**. | Runs **indefinitely** (scales to zero when idle, but is always available to receive traffic). |
| **Execution Trigger** | Manually executed, on a schedule (via Cloud Scheduler), or as part of a workflow. | Triggered by an incoming **HTTP request** or an event. |
| **Parallelism** | Designed for **parallel execution** of identical tasks (up to 10,000 tasks). | Achieves parallelism through **concurrency** (handling multiple requests per container instance). |
| **Timeout** | Tasks can run for up to **24 hours**. | Requests have a maximum timeout of up to 60 minutes. |

***

## Key Features of Cloud Run Jobs

1.  **Run-to-Completion:** Jobs are task-oriented. Once the containerized application finishes its work and exits (returns a zero exit code), the task is considered successful, and the resources are released.
2.  **Parallel Execution:** A single job can be configured to run as multiple, independent **tasks** concurrently (up to 10,000 tasks). This is ideal for dividing a large workload into smaller, manageable chunks, which is known as an **Array Job**.
3.  **Task Awareness:** Each parallel task is aware of its role through environment variables:
    * `CLOUD_RUN_TASK_INDEX`: The unique index of the current task (starts at 0).
    * `CLOUD_RUN_TASK_COUNT`: The total number of tasks in the job execution.
    * Your code uses these variables to determine which slice of the overall work it is responsible for.
4.  **Scheduled or On-Demand Execution:** You can execute a job immediately, schedule it to run at a specific time (like a cron job) using **Cloud Scheduler**, or trigger it as part of a more complex **GCP Workflow**.
5.  **Fault Tolerance:** You can configure the number of **retries** for a failed task. If a task fails beyond the maximum retries, the overall job execution is marked as failed.
6.  **GPU Support:** Cloud Run jobs support attaching **GPUs** for accelerating compute-intensive tasks, such as machine learning batch inference.

***

## Common Use Cases

Cloud Run Jobs are a suitable serverless option for any containerized workload that does not require a public-facing web endpoint:

* **Batch Data Processing** 🗃️: Processing large datasets, such as nightly ETL (Extract, Transform, Load) operations, or aggregating data for reporting.
* **Media Processing** 🖼️: Converting video files to different formats, resizing images, or watermarking a batch of photos.
* **Scheduled Tasks (Cron Jobs)** ⏰: Running daily database backups, sending out scheduled reports, or performing system maintenance.
* **Machine Learning Batch Inference** 🧠: Running a trained model against a large file or database of records to generate predictions.
* **General Scripting** 🛠️: Running any custom script or utility written in any language that you can package in a container, such as scraping a website or updating external systems.

This video explores how to create and execute jobs using Google Cloud Run, a key use case being non-continuous tasks like data processing. [Create and schedule Job Using Google Cloud Run](https://www.youtube.com/watch?v=6nFY_PFJqE4)
http://googleusercontent.com/youtube_content/2