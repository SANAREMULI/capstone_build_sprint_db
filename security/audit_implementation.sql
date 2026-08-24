-- Audit implementation is installed by V3. These checks document the operational contract.
SELECT table_name, action, count(*) AS event_count
FROM audit_log
GROUP BY table_name, action
ORDER BY table_name, action;

-- Audit rows are append-only for application roles.
REVOKE UPDATE, DELETE ON audit_log FROM capstone_app, capstone_readwrite;
GRANT SELECT ON audit_log TO capstone_readonly;
