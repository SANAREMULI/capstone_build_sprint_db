# Exact Demo Script

1. `cd database-capstone-project`
2. “This is ShopSphere, a multi-tenant commerce database for independent retailers.”
3. `flyway clean migrate`
4. “Five migrations build the schema, indexes, audit triggers, RLS, and fictional demo data.”
5. `psql capstone -c "SELECT name FROM tenants;"`
6. `psql capstone -c "SELECT set_config('app.tenant_id', '11111111-1111-1111-1111-111111111111', true); SELECT sku, name, quantity_on_hand FROM products JOIN inventory USING (product_id);"`
7. “This connection sees Northstar inventory because RLS reads the tenant context.”
8. `psql capstone -f optimization/analytical_queries.sql`
9. “The indexed report ranks revenue while preserving tenant isolation.”
10. `redis-cli HSET cart:11111111-1111-1111-1111-111111111111:aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa 10000000-0000-0000-0000-000000000002 2`
11. “Redis makes the cart fast and expiring; checkout revalidates against PostgreSQL.”
12. `./backups/backup_script.sh; ./backups/restore_commands.sh`
13. “The restore test proves the custom dump is usable without touching production.”
14. “The result is a documented, optimized, tenant-secured database foundation.”
