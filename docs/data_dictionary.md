# Data Dictionary

All IDs use `uuid`; timestamps use `timestamptz`; money uses `numeric(12,2)`.

| Table | Column | Type / constraints | Business meaning |
|---|---|---|---|
| tenants | tenant_id | uuid PK | Merchant account boundary |
| tenants | name | varchar(120) NOT NULL | Merchant display name |
| customers | customer_id | uuid PK | Shopper identity |
| customers | tenant_id | uuid FK, NOT NULL | Owning merchant |
| customers | email | citext, NOT NULL | Login/contact email, unique per tenant |
| products | product_id | uuid PK | Catalog product |
| products | tenant_id | uuid FK, NOT NULL | Owning merchant |
| products | sku | varchar(64), NOT NULL | Merchant stock keeping unit |
| products | name | varchar(200), NOT NULL | Product name |
| products | price | numeric(12,2), CHECK >= 0 | Current sale price |
| products | status | product_status, NOT NULL | active, draft, or archived |
| inventory | product_id | uuid PK/FK | One stock record per product |
| inventory | quantity_on_hand | integer CHECK >= 0 | Physical available units |
| inventory | reorder_level | integer CHECK >= 0 | Low-stock threshold |
| orders | order_id | uuid PK | Customer purchase |
| orders | tenant_id | uuid FK, NOT NULL | Owning merchant |
| orders | customer_id | uuid FK, NOT NULL | Buyer |
| orders | status | order_status | lifecycle state |
| orders | total_amount | numeric(12,2) | Transaction total |
| order_items | order_item_id | uuid PK | Line item identity |
| order_items | order_id | uuid FK, NOT NULL | Parent order |
| order_items | product_id | uuid FK, NOT NULL | Purchased product |
| order_items | quantity | integer CHECK > 0 | Units purchased |
| order_items | unit_price | numeric(12,2) CHECK >= 0 | Price captured at purchase |
| payments | payment_id | uuid PK | Payment attempt |
| payments | order_id | uuid FK, NOT NULL | Related order |
| payments | provider_reference | varchar(160) UNIQUE | External processor reference |
| payments | status | payment_status | pending, paid, failed, refunded |
| shipments | shipment_id | uuid PK | Fulfillment record |
| shipments | order_id | uuid FK UNIQUE | One shipment per order in MVP |
| shipments | status | shipment_status | pending, packed, shipped, delivered |
| audit_log | audit_id | bigint PK | Immutable change event |
| audit_log | tenant_id | uuid | Tenant context at change time |
| audit_log | table_name/action | text | Changed relation and operation |
| audit_log | old_row/new_row | jsonb | Before and after snapshots |
