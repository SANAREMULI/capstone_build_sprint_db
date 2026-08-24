CREATE INDEX idx_products_tenant_status ON products (tenant_id, status, created_at DESC);
CREATE INDEX idx_orders_tenant_created ON orders (tenant_id, created_at DESC);
CREATE INDEX idx_orders_customer_created ON orders (tenant_id, customer_id, created_at DESC);
CREATE INDEX idx_order_items_product ON order_items (tenant_id, product_id, order_id);
CREATE INDEX idx_payments_order ON payments (tenant_id, order_id);
CREATE INDEX idx_inventory_low_stock ON inventory (tenant_id, quantity_on_hand) WHERE quantity_on_hand <= reorder_level;
CREATE INDEX idx_shipments_status ON shipments (tenant_id, status) WHERE status IN ('pending', 'packed');
