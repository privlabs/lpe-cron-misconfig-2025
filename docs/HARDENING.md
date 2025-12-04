🔐 Linux Cron Job Hardening Guide

This document provides practical, production‑grade recommendations to secure cron job configurations and prevent privilege escalation vulnerabilities in enterprise Linux environments.

🧩 1. Principle of Least Privilege

Run cron jobs with the minimum privileges required.

Avoid running scripts as root unless strictly necessary.

Prefer systemd timers when advanced privilege separation or sandboxing is needed.

📁 2. Secure File and Directory Permissions
Recommended Permissions
Item	Owner	Permissions
Cron directories	root:root	755
Cron scripts	root:root	644
Executable scripts	root:root	755
User cron entries	<user>:<user>	600
Key rules

Never leave cron script directories world-writable (777).

Remove unnecessary write permissions for groups and users.

Ensure no user other than root can modify scripts executed by system cron.

🛣️ 3. Use Absolute Paths

Cron loads a minimal environment, which differs across distributions.

To avoid PATH hijacking:

Use full paths in every cron entry:

/usr/bin/rsync
/usr/local/sbin/backup.sh


Never rely on the default PATH or relative paths like:

backup.sh
./script.sh

🧪 4. Input Validation

Cron scripts must treat all inputs as untrusted:

Validate every parameter and environment variable.

Disable features relying on user-controlled variables.

Use strict whitelisting (e.g., allowed commands, file locations).

🗃️ 5. Secure Temporary Files

Temporary files are one of the most common attack vectors.

Best Practices

Always create temp files with mktemp:

TMPFILE=$(mktemp /tmp/backup.XXXXXX)


Restrict access with chmod 600 "$TMPFILE".

Avoid predictable filenames (e.g., /tmp/data.tmp).

Delete temp files securely after use.

🛡️ 6. File Integrity Monitoring (FIM)

Monitor all cron-related directories and scripts:

/etc/crontab

/etc/cron.*

/var/spool/cron/

Any custom script path executed by cron

Recommended tools:

AIDE for enterprise FIM

Custom FIM script included in this project:
/tools/monitor-cron-changes.sh

Use FIM to detect:

Unauthorized file changes

Permission modifications

Suspicious newly created cron scripts

🤖 7. Automated Auditing

Run scheduled audits using:

/tools/audit-cron.sh (included in the repository)

System audit frameworks (auditd, osquery, etc.)

Audit frequency:
Daily on production systems
Hourly on sensitive infrastructure

Investigate every:

World-writable script

Relative path in cron

Unexpected file ownership

Suspicious environment variable usage

📚 References

MITRE ATT&CK — Scheduled Task/Job (T1053):
https://attack.mitre.org/techniques/T1053/

Linux Audit Daemon (auditd):
https://linux.die.net/man/8/auditd

FHS — Linux File Hierarchy Security Guidelines
