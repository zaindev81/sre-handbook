#!/bin/bash
apt update -y
apt install -y nginx ufw

# Enable firewall inside the VM
ufw allow 'Nginx Full'
ufw allow OpenSSH
ufw --force enable

# Create custom index page
cat <<EOF > /var/www/html/index.html
<html>
  <head><title>Welcome to Terraform VM</title></head>
  <body>
    <h1>Hello from Terraform-managed VM with Nginx!</h1>
    <p>Instance created on $(date)</p>
  </body>
</html>
EOF

systemctl enable nginx
systemctl start nginx