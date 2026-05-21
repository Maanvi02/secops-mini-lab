# 🚨 Production Alert

You are the SecOps engineer on duty.

Production triggered a suspicious access alert.

## Objectives

1. Find the attacker IP.
2. Find suspicious web activity.
3. Find persistence.

## Useful Commands

```bash
grep Accepted /var/log/auth.log

cat /var/log/nginx/access.log

cat /etc/crontab
```

## Flags

Submit:

FLAG1{attacker_ip}

FLAG2{suspicious_path}

FLAG3{persistence_method}