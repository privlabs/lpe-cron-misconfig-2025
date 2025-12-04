# Detection and Monitoring

## Audit for Vulnerable Cron Jobs

- Look for scripts in `/etc/cron.*` using relative paths or world-writable directories.
- Monitor `/tmp`, `/var/tmp` for new SUID-root binaries.
- Use `/tools/audit-cron.sh` for automated checks.

## File Integrity Monitoring

- Recommended: OSSEC, AIDE, Wazuh.
- Alert on any changes in cron directories.

## Log Analysis

- Check logs for unexpected execution of binaries in user-writable paths.

---

## SIEM Example

- Alert: “New SUID-root file created in /tmp”
- Rule: File creation in /tmp AND permissions SUID-root
