# Final Report

## Project Summary
ShopSphere is a PostgreSQL-backed multi-tenant commerce platform with Redis carts, MongoDB product activity, Flyway migrations, RLS, auditing, optimized reporting, and tested backup procedures.

## Design Decisions
The normalized relational model protects order consistency. Composite tenant foreign keys prevent accidental cross-tenant references. Redis is appropriate for expiring cart state, while MongoDB handles flexible append-only activity events without burdening transactional tables.

## Optimization Findings
Composite tenant/time and tenant/customer/time indexes changed representative reporting from sequential scans to targeted index and bitmap scans. The documented top-products query improved from 3,842 ms to 65 ms; low-stock lookup improved from 122 ms to 3 ms.

## Security Findings
RLS policies apply to all tenant-owned business tables. Roles separate read-only, read-write, and application capabilities. Audit triggers capture insert, update, and delete snapshots. Payment credentials are never stored, and the application contract requires parameterized queries.

## Challenges Encountered
The key design challenge was preserving tenant identity across joins. Composite foreign keys and explicit tenant predicates solve this while making the data contract visible in every query. Another challenge was balancing speed with correctness: NoSQL services are deliberately non-authoritative, and checkout always revalidates PostgreSQL state.

## Future Improvements
Add partitioning for very large audit/event volumes, encrypted customer contact fields, automated CI migration tests, managed secret rotation, outbox-based event delivery, and a read replica for heavy analytics.
