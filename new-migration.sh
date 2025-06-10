#!/bin/bash

# Usage: ./new_migration.sh create_users_table
NAME="$1"

if [ -z "$NAME" ]; then
  echo "Usage: $0 migration_name"
  exit 1
fi

TIMESTAMP=$(date -u +"%Y%m%d%H%M%S")
FILENAME="${TIMESTAMP}_${NAME}.sql"
touch "migrations/db/${FILENAME}"

echo "-- migrate:up

-- migrate:down" > "migrations/db/${FILENAME}"

echo "Created migrations/db/${FILENAME}"