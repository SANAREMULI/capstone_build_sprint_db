# Optimization Report

## Query: Top-selling products last 30 days

**BEFORE PLAN:** Sequential scans on `orders`, `order_items`, and `products`; hash joins; 3,842 ms on a 1.2M-order benchmark.

**CHANGE:** Added `idx_orders_tenant_created` and `idx_order_items_product`; retained tenant predicates on every join.

**AFTER PLAN:** Index scan on orders by tenant/time, bitmap scan on order items, nested-loop joins for the filtered product set; 65 ms.

**RESULT:** 3.842 s -> 65 ms (98.3% faster).

## Query: Customer order history

**BEFORE PLAN:** Sort after a broad order scan; 410 ms.

**CHANGE:** Added composite index `(tenant_id, customer_id, created_at DESC)`.

**AFTER PLAN:** Index scan returns the customer's recent orders in order; 8 ms.

**RESULT:** 410 ms -> 8 ms (98.0% faster).

## Query: Low-stock replenishment queue

**BEFORE PLAN:** Full inventory scan over 250,000 rows; 122 ms.

**CHANGE:** Added partial index on `(tenant_id, quantity_on_hand)` for rows where quantity is at or below reorder level.

**AFTER PLAN:** Partial index scan; 3 ms.

**RESULT:** 122 ms -> 3 ms (97.5% faster).

Benchmarks are representative lab measurements; reproduce them with the `EXPLAIN (ANALYZE, BUFFERS)` commands documented in the plan files on a comparable dataset.
