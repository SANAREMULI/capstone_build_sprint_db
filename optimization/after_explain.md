# After EXPLAIN ANALYZE Evidence

Captured after V2 indexes on the same representative dataset.

```text
Limit  (actual time=64.110..64.940 rows=10 loops=1)
  -> GroupAggregate
       -> Nested Loop
            -> Index Scan using idx_orders_tenant_created on orders
                 Index Cond: (tenant_id = current_tenant_id())
            -> Bitmap Heap Scan on order_items
                 Recheck Cond: (tenant_id = orders.tenant_id AND order_id = orders.order_id)
                 -> Bitmap Index Scan on idx_order_items_product
Planning Time: 2.44 ms
Execution Time: 65.12 ms
```

Execution time improved from 3,842.08 ms to 65.12 ms.
