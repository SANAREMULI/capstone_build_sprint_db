# Redis Design: Cart and Cache

## Stored Data
- Cart hash: `cart:{tenantId}:{customerId}` with `productId -> quantity` fields.
- Cart expiry: 7 days using `EXPIRE`.
- Product cache: `product:{tenantId}:{productId}` containing serialized public catalog data, TTL 10 minutes.
- Idempotency key: `checkout:{tenantId}:{requestId}` with a short TTL to prevent duplicate checkout requests.

## Why Redis
Carts need low-latency reads and writes, expire naturally, and do not need a relational join on every request. Redis hashes model line items directly; atomic commands and short-lived idempotency keys protect checkout from duplicate submissions.

PostgreSQL remains the source of truth. Checkout re-reads prices and stock in a transaction before creating an order. Cache misses and Redis outages degrade to PostgreSQL rather than losing committed orders.
