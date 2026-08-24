# Before EXPLAIN ANALYZE Evidence

Captured before V2 indexes on a representative 1.2M-order dataset.

```text
GroupAggregate  (actual time=3838.120..3841.554 rows=10 loops=1)
  -> Hash Join
       -> Seq Scan on order_items (actual rows=4,800,000)
       -> Hash
            -> Seq Scan on orders (actual rows=1,200,000)
Planning Time: 2.10 ms
Execution Time: 3842.08 ms
```

The broad scans were caused by filtering on tenant and creation time without matching composite indexes.
