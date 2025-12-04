# ROOTBASH_ANALYSIS.md

## Custom SUID-root Shell: `rootbash`

During the course of Linux privilege escalation research via cron job misconfigurations, a suspicious binary named `rootbash` was discovered on several test systems after successful exploitation.

### 🔍 Discovery

- `rootbash` appeared in `/tmp/` with SUID-root permissions (`-rwsr-xr-x root root`)
- The binary was not a standard system utility, nor present on a clean install

### 🧑‍💻 Static & Dynamic Analysis

**Disassembly and Reverse Engineering (Ghidra/Binwalk):**
- The binary does not contain user validation logic (no checks for UID, EUID, etc.)
- It invokes `execve("/bin/bash", ...)` directly
- On execution, it relaunches itself if it fails, making it persistent
- No external connections, no obfuscation, small static binary

**Why it matters:**
- Bypasses all normal privilege boundaries
- Once placed by an attacker, remains after cleanup if not noticed
- Used as a persistent root backdoor in real-world scenarios

### 🛡️ Detection & Mitigation

- Audit `/tmp`, `/var/tmp`, `/dev/shm` for unknown SUID-root binaries
- Remove and investigate any `rootbash` or similar files
- Monitor for SUID-root file creation with OSSEC/AIDE

**For more, see [Full LPE Research](./LPE-Cron-Research-Full.pdf) and [Detection Guide](./DETECTION.md).**

---

*This analysis is for educational purposes. No real-world production systems were harmed.*
