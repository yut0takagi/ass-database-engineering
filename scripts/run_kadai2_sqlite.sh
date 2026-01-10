#!/usr/bin/env sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
DB_PATH="$ROOT_DIR/data/kadai2.sqlite3"

mkdir -p "$ROOT_DIR/data"
rm -f "$DB_PATH"

sqlite3 "$DB_PATH" < "$ROOT_DIR/sql/kadai2/01_schema.sql"
sqlite3 "$DB_PATH" < "$ROOT_DIR/sql/kadai2/02_seed.sql"

echo "DB created: $DB_PATH"
echo ""

sqlite3 \
  -cmd ".headers on" \
  -cmd ".mode column" \
  -cmd ".nullvalue NULL" \
  "$DB_PATH" < "$ROOT_DIR/sql/kadai2/03_queries.sql"


