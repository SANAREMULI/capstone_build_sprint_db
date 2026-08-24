#!/usr/bin/env bash
set -euo pipefail
# Restore into a disposable database; never overwrite production directly.
createdb capstone_restore
pg_restore --clean --if-exists --no-owner --dbname=capstone_restore "backups/capstone_$(date +%F).dump"
psql --dbname=capstone_restore --command="SELECT count(*) AS tables FROM information_schema.tables WHERE table_schema = 'public';"
# After verification: dropdb capstone_restore
