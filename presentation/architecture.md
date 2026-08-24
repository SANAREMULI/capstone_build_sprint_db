# Architecture

## System Architecture
Users access the application through a web/API layer. The application authenticates the user, sets `app.tenant_id` for each PostgreSQL transaction, and uses parameterized SQL. PostgreSQL owns tenants, catalog, inventory, orders, payments, shipments, and audit history.

## Database Architecture
Flyway applies V1 through V5 in order. V2 supports reporting and operational lookups. V3 records row changes. V4 applies tenant RLS. A least-privilege application role has no superuser or `BYPASSRLS` capability.

## NoSQL Integration
Redis handles expiring carts and catalog cache entries. MongoDB receives append-only product activity events for flexible analytics. Both are tenant-keyed and non-authoritative; PostgreSQL remains the source of truth for checkout.

## Security Design
TLS and secret-manager credentials are required in deployment. RLS is enforced on tenant-owned tables, audit rows are append-only for application roles, sensitive payment data stays with the external processor, and backups are restored into disposable databases for verification.
