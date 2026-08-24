# Backup Verification

Run the scripts from the repository root with PostgreSQL client tools installed.

```text
$ ./backups/backup_script.sh
$ ls -lh backups/capstone_2026-08-24.dump
-rw-r--r-- 1 operator operator 18K backups/capstone_2026-08-24.dump
$ sha256sum -c backups/capstone_2026-08-24.dump.sha256
backups/capstone_2026-08-24.dump: OK
$ ./backups/restore_commands.sh
 tables
--------
      9
(1 row)
```

This evidence is a reproducible lab record. Production backups should be encrypted, copied off-host, retention-controlled, and periodically restored automatically.
