# MongoDB Design: Product Activity Events

## Stored Data
The `shopsphere_activity.events` collection stores append-only product interaction events: `tenantId`, `customerId`, `productId`, `eventType`, `sessionId`, `occurredAt`, and a small `metadata` document. Example event types are `product_viewed`, `search_performed`, and `recommendation_clicked`.

## Why MongoDB
Activity events have evolving metadata, high write volume, and are primarily read by time range and product. MongoDB's document model avoids adding nullable columns for every new event attribute and supports horizontal scaling for an append-heavy workload.

Recommended indexes: `{ tenantId: 1, occurredAt: -1 }` and `{ tenantId: 1, productId: 1, occurredAt: -1 }`. Apply a TTL index only if product policy permits deleting events after the retention period.

## Relational Alternative
A PostgreSQL `product_activity_events` table with `jsonb metadata` and monthly partitions would provide stronger joins and one backup system. MongoDB is preferred here because activity is analytics input, not transactional truth, and its schema flexibility keeps event producers decoupled from the order schema.
