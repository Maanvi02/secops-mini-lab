#!/bin/bash

echo "Setting up SecOps Mini Lab..."

sudo mkdir -p /var/log/nginx

sudo tee /var/log/auth.log > /dev/null << EOF
May 20 Failed password for admin from 192.168.1.20
May 20 Accepted password for admin from 203.0.113.12
EOF

sudo tee /var/log/nginx/access.log > /dev/null << EOF
GET /
POST /admin/upload.php
EOF

sudo tee /etc/crontab > /dev/null << EOF
@reboot root /tmp/update.sh
EOF

echo "Lab ready."