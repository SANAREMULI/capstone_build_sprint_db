# ShopSphere Database Capstone

## Project Title
ShopSphere: Secure Multi-Tenant Commerce Database

## Problem Statement
Independent retailers need a reliable commerce data platform that keeps customer, order, payment, and inventory data consistent while supporting tenant isolation, fast reporting, and operational recovery.

## Business Requirements
- Support multiple merchant tenants in one managed PostgreSQL database.
- Track customers, products, inventory, orders, payments, and fulfillment.
- Provide daily sales and inventory insights for merchant operators.
- Preserve an auditable history of sensitive data changes.
- Keep carts and high-volume product activity responsive with NoSQL services.

## Functional Requirements
1. An operator can create a tenant, products, and inventory records.
2. A customer can browse active products and place an order.
3. The system validates stock before confirming order items.
4. Operators can view order status, payment status, and shipment details.
5. Reports can aggregate revenue, product performance, and low-stock items.
6. Each request sets `app.tenant_id`; RLS prevents cross-tenant access.
7. Security staff can inspect audit events without changing business data.

## Non-Functional Requirements
- PostgreSQL 15+ with Flyway-compatible, repeatable migrations.
- ACID transactions for order placement and stock changes.
- RLS enforcement for tenant-owned tables.
- Indexed queries should support a 30-day sales report under 100 ms on demo-scale data.
- Daily custom-format backups and a documented restore test.
- Secrets supplied through environment variables, never committed.

## User Roles
- **Customer:** browses products, manages a cart, and places orders.
- **Merchant operator:** manages catalog, inventory, fulfillment, and reports for one tenant.
- **Security auditor:** reads audit records and security evidence.
- **Application service:** performs parameterized, tenant-scoped operations.
- **Database administrator:** owns migrations, backup, and role provisioning.

## Assumptions and Constraints
- PostgreSQL is the system of record for transactional data.
- A tenant is identified by a UUID and supplied through a trusted connection setting.
- Payment processing is external; only provider references and statuses are stored.
- MongoDB and Redis are optional runtime dependencies documented separately.
- Demo data is fictional and contains no real payment credentials.
- Flyway is available in the deployment environment; CI can run migrations against a disposable PostgreSQL instance.
