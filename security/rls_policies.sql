-- V4 owns the production policies. This verification script confirms coverage.
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('customers', 'products', 'inventory', 'orders', 'order_items', 'payments', 'shipments')
ORDER BY tablename;

-- Application transaction pattern:
-- BEGIN;
-- SELECT set_config('app.tenant_id', $1, true);
-- ... parameterized tenant-scoped statements ...
-- COMMIT;
