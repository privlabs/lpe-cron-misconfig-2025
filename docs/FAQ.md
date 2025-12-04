

# FAQ – Linux Cron Job Privilege Escalation

## Q1: Is this a vulnerability in Linux itself?
No. These issues arise from common misconfigurations of cron jobs and scripts, not from flaws in the Linux kernel or cron daemon.

## Q2: Which distributions are affected?
Any Unix-like system (Linux, BSD, etc.) where cron jobs are misconfigured as described. Examples include Ubuntu, OpenSUSE, Oracle Linux, and more.

## Q3: How can I check if my system is vulnerable?
Use the provided audit script (`/tools/audit-cron.sh`) to check for insecure permissions and configurations.

## Q4: Why isn’t there a CVE for this?
Because these are configuration issues rather than software vulnerabilities. They do not meet the criteria for individual CVE assignment.

## Q5: What’s the best way to fix these issues?
Apply the recommendations in the [HARDENING.md](./HARDENING.md) guide and run regular audits.

## Q6: Can this be used for ransomware or persistence?
Yes. Any code can be executed as root, so persistence and malware are possible.

## Q7: Are cloud VMs at risk?
Yes, if they use default or legacy cron configurations.

## Q8: Can I use your scripts for pentesting?
Only in authorized environments, with explicit permission.
