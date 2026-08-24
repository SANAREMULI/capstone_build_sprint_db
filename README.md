# ShopSphere Database Capstone

ShopSphere is a portfolio-ready, secure multi-tenant commerce database for independent retailers. It demonstrates relational modeling, Flyway migrations, PostgreSQL RLS and audit triggers, Redis carts, MongoDB activity events, query optimization, and backup recovery.

## Objectives
- Keep orders and inventory consistent in PostgreSQL.
- Isolate tenant data with composite keys and RLS.
- Use NoSQL where low latency or flexible event shape helps.
- Prove reporting performance with explain-plan evidence.
- Document security, backup, restore, and presentation workflows.

## Repository Structure
- `requirements/` requirements and ER diagram
- `migrations/` V1-V5 Flyway migrations
- `nosql/` MongoDB, Redis, and setup design
- `optimization/` queries, plans, and performance report
- `security/` roles, RLS, audit, and review checklist
- `backups/` backup, restore, and verification runbooks
- `presentation/` architecture, walkthrough, and demo script
- `docs/` dictionary, diagrams, lessons, and final report

## Technologies
PostgreSQL 15+, Flyway, Redis 7+, MongoDB 7+, Bash, `psql`, `pg_dump`, and `pg_restore`.

## Setup
1. Install PostgreSQL, Flyway, Docker, Redis CLI, and MongoDB Shell.
2. Create a database named `capstone` and configure Flyway's URL, user, and password through environment variables.
3. Start optional NoSQL services using `nosql/nosql_setup.md`.
4. Run migrations from an empty database:
   ```bash
   flyway -url=jdbc:postgresql://localhost:5432/capstone -user="$PGUSER" -password="$PGPASSWORD" clean migrate
   ```
5. Set a tenant for application transactions with `SELECT set_config('app.tenant_id', '<tenant uuid>', true);`.

## Run the Project
Run the queries in `optimization/analytical_queries.sql` through `psql` after setting the tenant context. Use `presentation/demo_script.md` for the complete demonstration sequence.

## Backups and Restore
```bash
./backups/backup_script.sh
./backups/restore_commands.sh
```
The restore script uses a disposable `capstone_restore` database. Read `backups/backup_verification.md` before running it in a shared environment.

## Verification
A real `flyway clean migrate` and `EXPLAIN ANALYZE` require a running PostgreSQL instance and are intentionally documented as executable lab steps. The repository includes representative explain output and restore evidence; no real credentials or payment data are included.
