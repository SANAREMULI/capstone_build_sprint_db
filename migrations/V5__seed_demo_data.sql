INSERT INTO tenants (tenant_id, name) VALUES
('11111111-1111-1111-1111-111111111111', 'Northstar Outfitters'),
('22222222-2222-2222-2222-222222222222', 'Cedar & Coil');
INSERT INTO customers (tenant_id, customer_id, email, full_name) VALUES
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'maya@example.test', 'Maya Chen'),
('11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'jon@example.test', 'Jon Bell'),
('22222222-2222-2222-2222-222222222222', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'riley@example.test', 'Riley Singh');
INSERT INTO products (tenant_id, product_id, sku, name, price, status) VALUES
('11111111-1111-1111-1111-111111111111', '10000000-0000-0000-0000-000000000001', 'JKT-001', 'Field Jacket', 129.00, 'active'),
('11111111-1111-1111-1111-111111111111', '10000000-0000-0000-0000-000000000002', 'BOT-002', 'Trail Bottle', 24.00, 'active'),
('22222222-2222-2222-2222-222222222222', '20000000-0000-0000-0000-000000000001', 'LMP-001', 'Desk Lamp', 89.00, 'active');
INSERT INTO inventory (tenant_id, product_id, quantity_on_hand, reorder_level) VALUES
('11111111-1111-1111-1111-111111111111', '10000000-0000-0000-0000-000000000001', 18, 5),
('11111111-1111-1111-1111-111111111111', '10000000-0000-0000-0000-000000000002', 3, 8),
('22222222-2222-2222-2222-222222222222', '20000000-0000-0000-0000-000000000001', 12, 4);
INSERT INTO orders (tenant_id, order_id, customer_id, status, total_amount, created_at) VALUES
('11111111-1111-1111-1111-111111111111', '30000000-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'fulfilled', 153.00, now() - interval '8 days'),
('11111111-1111-1111-1111-111111111111', '30000000-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'confirmed', 24.00, now() - interval '2 days');
INSERT INTO order_items (tenant_id, order_id, product_id, quantity, unit_price) VALUES
('11111111-1111-1111-1111-111111111111', '30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 1, 129.00),
('11111111-1111-1111-1111-111111111111', '30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002', 1, 24.00),
('11111111-1111-1111-1111-111111111111', '30000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', 1, 24.00);
