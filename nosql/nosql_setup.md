# NoSQL Setup

## Technologies
- MongoDB 7+ for product activity events.
- Redis 7+ for carts, catalog caching, and checkout idempotency.
- PostgreSQL 15+ remains the transactional system of record.

## Commands Executed
```bash
docker network create shopsphere-net
docker run -d --name shopsphere-mongo --network shopsphere-net -p 27017:27017 mongo:7
docker run -d --name shopsphere-redis --network shopsphere-net -p 6379:6379 redis:7-alpine
mongosh "mongodb://localhost:27017/shopsphere_activity" --eval 'db.events.createIndex({tenantId:1, occurredAt:-1})'
redis-cli SET product:health ok EX 60
```

## Configuration
Connection strings are injected as `MONGODB_URI` and `REDIS_URL`. Services run on a private network in production, require authentication and TLS, and use tenant IDs in every key or document. No secrets are committed to this repository.
