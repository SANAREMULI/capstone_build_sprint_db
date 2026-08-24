#!/usr/bin/env bash
set -euo pipefail
: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=capstone}"
: "${PGUSER:?Set PGUSER in the environment}"
mkdir -p backups
pg_dump -Fc -f "backups/capstone_$(date +%F).dump" capstone
sha256sum "backups/capstone_$(date +%F).dump" > "backups/capstone_$(date +%F).dump.sha256"
