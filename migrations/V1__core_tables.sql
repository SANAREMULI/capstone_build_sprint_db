CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TYPE product_status AS ENUM ('draft', 'active', 'archived');
CREATE TYPE order_status AS ENUM ('pending', 'confirmed', 'cancelled', 'fulfilled');
CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TYPE shipment_status AS ENUM ('pending', 'packed', 'shipped', 'delivered');

CREATE TABLE tenants (
  tenant_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(120) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE customers (
  customer_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  email citext NOT NULL,
  full_name varchar(160) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (tenant_id, customer_id)
);
CREATE TABLE products (
  product_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  sku varchar(64) NOT NULL,
  name varchar(200) NOT NULL,
  description text,
  price numeric(12,2) NOT NULL CHECK (price >= 0),
  status product_status NOT NULL DEFAULT 'draft',
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (tenant_id, product_id), UNIQUE (tenant_id, sku)
);
CREATE TABLE inventory (
  product_id uuid PRIMARY KEY REFERENCES products(product_id) ON DELETE CASCADE,
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  quantity_on_hand integer NOT NULL CHECK (quantity_on_hand >= 0),
  reorder_level integer NOT NULL DEFAULT 5 CHECK (reorder_level >= 0),
  updated_at timestamptz NOT NULL DEFAULT now(),
  FOREIGN KEY (tenant_id, product_id) REFERENCES products(tenant_id, product_id)
);
CREATE TABLE orders (
  order_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  customer_id uuid NOT NULL,
  status order_status NOT NULL DEFAULT 'pending',
  total_amount numeric(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  FOREIGN KEY (tenant_id, customer_id) REFERENCES customers(tenant_id, customer_id)
);
CREATE TABLE order_items (
  order_item_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  order_id uuid NOT NULL,
  product_id uuid NOT NULL,
  quantity integer NOT NULL CHECK (quantity > 0),
  unit_price numeric(12,2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (tenant_id, order_id) REFERENCES orders(tenant_id, order_id),
  FOREIGN KEY (tenant_id, product_id) REFERENCES products(tenant_id, product_id),
  UNIQUE (order_id, product_id)
);
CREATE TABLE payments (
  payment_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  order_id uuid NOT NULL,
  provider_reference varchar(160) UNIQUE,
  status payment_status NOT NULL DEFAULT 'pending',
  amount numeric(12,2) NOT NULL CHECK (amount >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  FOREIGN KEY (tenant_id, order_id) REFERENCES orders(tenant_id, order_id)
);
CREATE TABLE shipments (
  shipment_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(tenant_id),
  order_id uuid NOT NULL,
  status shipment_status NOT NULL DEFAULT 'pending',
  tracking_number varchar(120),
  shipped_at timestamptz,
  FOREIGN KEY (tenant_id, order_id) REFERENCES orders(tenant_id, order_id),
  UNIQUE (order_id)
);
