CREATE ROLE capstone_readonly NOLOGIN;
CREATE ROLE capstone_readwrite NOLOGIN;
CREATE ROLE capstone_app LOGIN PASSWORD 'CHANGE_ME_FROM_SECRET_MANAGER';
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO capstone_readonly, capstone_readwrite, capstone_app;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO capstone_readonly;
GRANT SELECT, INSERT, UPDATE ON customers, products, inventory, orders, order_items, payments, shipments TO capstone_readwrite;
GRANT capstone_readwrite TO capstone_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO capstone_readonly;
-- Replace the placeholder password through a secret manager before deployment.
