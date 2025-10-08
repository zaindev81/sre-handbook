# SSH

```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

ssh-keygen -t ed25519 -C "your_email@example.com"
```


```sh
[Member PC] → Generate SSH Key
      │
      ▼
[Google Account] ← Register Public Key
      │
      ▼
[Google Group] ← Add Members
      │
      ▼
[Google Cloud IAM] ← Assign compute.osAdminLogin Role
      │
      ▼
[Secure SSH Access to VM]
```