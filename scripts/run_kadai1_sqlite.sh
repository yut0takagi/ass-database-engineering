#!/usr/bin/env sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
DB_PATH="$ROOT_DIR/data/kadai1.sqlite3"

mkdir -p "$ROOT_DIR/data"
rm -f "$DB_PATH"

# DB作成（スキーマ→データ投入）
sqlite3 "$DB_PATH" < "$ROOT_DIR/sql/kadai1/01_schema.sql"
sqlite3 "$DB_PATH" < "$ROOT_DIR/sql/kadai1/02_seed.sql"

echo "DB created: $DB_PATH"
echo ""

# 課題SQL実行（見やすい表示設定）
sqlite3 \
  -cmd ".headers on" \
  -cmd ".mode column" \
  -cmd ".nullvalue NULL" \
  "$DB_PATH" < "$ROOT_DIR/sql/kadai1/03_queries.sql"


