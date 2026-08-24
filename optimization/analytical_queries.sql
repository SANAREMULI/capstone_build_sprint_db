-- Set the tenant in the application transaction before each query.
-- SELECT set_config('app.tenant_id', '11111111-1111-1111-1111-111111111111', true);

-- 1. Revenue by day for the last 30 days.
SELECT date_trunc('day', o.created_at)::date AS sales_day,
       count(*) AS order_count, sum(o.total_amount) AS revenue
FROM orders o
WHERE o.tenant_id = current_tenant_id()
  AND o.status IN ('confirmed', 'fulfilled')
  AND o.created_at >= now() - interval '30 days'
GROUP BY 1 ORDER BY 1;

-- 2. Top-selling products by units and revenue.
SELECT p.product_id, p.name, sum(oi.quantity) AS units_sold,
       sum(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o ON o.tenant_id = oi.tenant_id AND o.order_id = oi.order_id
JOIN products p ON p.tenant_id = oi.tenant_id AND p.product_id = oi.product_id
WHERE oi.tenant_id = current_tenant_id()
  AND o.status IN ('confirmed', 'fulfilled')
  AND o.created_at >= now() - interval '30 days'
GROUP BY p.product_id, p.name ORDER BY revenue DESC LIMIT 10;

-- 3. Low-stock replenishment queue.
SELECT p.sku, p.name, i.quantity_on_hand, i.reorder_level
FROM inventory i JOIN products p ON p.product_id = i.product_id
WHERE i.tenant_id = current_tenant_id()
  AND i.quantity_on_hand <= i.reorder_level
ORDER BY i.quantity_on_hand ASC;

-- Aggregation 1: order-status distribution.
SELECT status, count(*) AS orders, sum(total_amount) AS gross_value
FROM orders WHERE tenant_id = current_tenant_id()
GROUP BY status ORDER BY orders DESC;

-- Aggregation 2: customer lifetime value.
SELECT c.customer_id, c.full_name, count(o.order_id) AS order_count,
       coalesce(sum(o.total_amount), 0) AS lifetime_value
FROM customers c LEFT JOIN orders o ON o.tenant_id = c.tenant_id AND o.customer_id = c.customer_id
WHERE c.tenant_id = current_tenant_id()
GROUP BY c.customer_id, c.full_name ORDER BY lifetime_value DESC;

-- Window function: rank products within each merchant by revenue.
SELECT p.name, sum(oi.quantity * oi.unit_price) AS revenue,
       dense_rank() OVER (PARTITION BY p.tenant_id ORDER BY sum(oi.quantity * oi.unit_price) DESC) AS revenue_rank
FROM products p JOIN order_items oi ON oi.product_id = p.product_id AND oi.tenant_id = p.tenant_id
JOIN orders o ON o.order_id = oi.order_id AND o.tenant_id = oi.tenant_id
WHERE p.tenant_id = current_tenant_id() AND o.status IN ('confirmed', 'fulfilled')
GROUP BY p.tenant_id, p.product_id, p.name;
