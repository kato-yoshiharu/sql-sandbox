#!/bin/bash
# databases/ 直下のディレクトリ名と同名のDBを作成する。
# そのディレクトリ内の *.sql を、ファイル名順に実行する。
set -euo pipefail

for dir in /databases/*/; do
  db_name=$(basename "$dir")

  psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres \
    -c "CREATE DATABASE \"${db_name}\""

  for sql_file in "$dir"*.sql; do
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$db_name" -f "$sql_file"
  done
done
