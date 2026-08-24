# 5-10 Minute Project Walkthrough

1. **Problem and goal (1 minute):** ShopSphere gives independent retailers a secure, shared commerce data platform.
2. **Relational design (2 minutes):** Show tenants at the boundary, then customers, products, inventory, orders, line items, payments, and shipments. Explain composite tenant foreign keys.
3. **Migrations (1 minute):** Run `flyway clean migrate` against a disposable database and show V1-V5 applying in sequence.
4. **NoSQL choices (1 minute):** Demonstrate a Redis cart and explain MongoDB activity events; stress that checkout commits to PostgreSQL.
5. **Optimization (2 minutes):** Run the top-products query with `EXPLAIN (ANALYZE, BUFFERS)` and compare the documented 3.842 s sequential-scan plan with the 65 ms indexed plan.
6. **Security and recovery (2 minutes):** Set a tenant context, show RLS blocking another tenant, inspect an audit event, run a custom-format backup, and restore it to `capstone_restore`.
7. **Close (30 seconds):** Summarize measurable performance, tenant isolation, and operational recovery.
