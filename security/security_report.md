# Security Report

- [x] Least-privilege roles implemented in `roles_and_permissions.sql`.
- [x] No application uses a superuser account; `capstone_app` is a login role without superuser membership.
- [x] RLS enabled on tenant-owned sensitive tables in V4.
- [x] Audit logging enabled for catalog, inventory, orders, and order items.
- [x] Passwords and payment credentials are not stored. External payment references are opaque; customer emails require encryption at rest at the infrastructure layer.
- [x] Parameterized queries are required by the application contract and shown in `rls_policies.sql`.
- [x] Backups and restore verification are documented in `backups/`.

## Review Notes
The placeholder password in the role script must be replaced by a secret manager during deployment. Production should use TLS, rotate credentials, restrict network access, and grant `BYPASSRLS` only to a controlled database administrator role.
