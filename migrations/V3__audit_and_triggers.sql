CREATE TABLE audit_log (
  audit_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tenant_id uuid,
  actor text NOT NULL DEFAULT current_user,
  table_name text NOT NULL,
  action text NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
  row_id uuid,
  old_row jsonb,
  new_row jsonb,
  changed_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX idx_audit_tenant_time ON audit_log (tenant_id, changed_at DESC);

CREATE OR REPLACE FUNCTION record_row_change() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO audit_log (tenant_id, table_name, action, row_id, old_row, new_row)
  VALUES (COALESCE((to_jsonb(NEW)->>'tenant_id')::uuid, (to_jsonb(OLD)->>'tenant_id')::uuid),
          TG_TABLE_NAME, TG_OP,
          COALESCE((to_jsonb(NEW)->>'order_id')::uuid, (to_jsonb(NEW)->>'product_id')::uuid,
                   (to_jsonb(NEW)->>'customer_id')::uuid, (to_jsonb(OLD)->>'order_id')::uuid,
                   (to_jsonb(OLD)->>'product_id')::uuid, (to_jsonb(OLD)->>'customer_id')::uuid),
          to_jsonb(OLD), to_jsonb(NEW));
  RETURN COALESCE(NEW, OLD);
END; $$;

CREATE TRIGGER products_audit AFTER INSERT OR UPDATE OR DELETE ON products FOR EACH ROW EXECUTE FUNCTION record_row_change();
CREATE TRIGGER inventory_audit AFTER INSERT OR UPDATE OR DELETE ON inventory FOR EACH ROW EXECUTE FUNCTION record_row_change();
CREATE TRIGGER orders_audit AFTER INSERT OR UPDATE OR DELETE ON orders FOR EACH ROW EXECUTE FUNCTION record_row_change();
CREATE TRIGGER order_items_audit AFTER INSERT OR UPDATE OR DELETE ON order_items FOR EACH ROW EXECUTE FUNCTION record_row_change();
