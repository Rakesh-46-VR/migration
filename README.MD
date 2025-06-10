# Database Migrations

This repository contains database migrations managed by [dbmate](https://github.com/amacneil/dbmate). These migrations are used to manage database schema changes in a consistent and version-controlled manner.

## Prerequisites

- [dbmate](https://github.com/amacneil/dbmate) installed on your system
- Docker (for local development)

## Creating New Migrations

You can create new migrations using either the PowerShell or Bash script provided:

### Using PowerShell (Windows)
```powershell
.\new-migration.ps1 <migration_name>
```

### Using Bash (Unix/Linux/MacOS)
```bash
./new-migration.sh <migration_name>
```

For example, to create a migration for a users table:
```bash
./new-migration.sh create_users_table
```

This will create a new migration file in the `migrations/db` directory with the current timestamp and your specified name.

## Migration File Structure

Each migration file contains two sections:
```sql
-- migrate:up
-- Your migration code goes here

-- migrate:down
-- Your rollback code goes here
```

- The `migrate:up` section contains the SQL commands to apply the migration
- The `migrate:down` section contains the SQL commands to rollback the migration

## Running Migrations

### Local Development
For local development, you'll need to:
1. Start the database service using Docker (docker-compose file will be provided separately)
2. Run migrations using dbmate

### Service Integration
This repository is designed to be pulled by services that need to run database migrations. The service should:
1. Pull this repository
2. Use dbmate to run any pending migrations

## Best Practices

1. Always include both `up` and `down` migrations
2. Test migrations locally before committing
3. Make migrations idempotent when possible
4. Use descriptive names for migration files
5. Keep migrations small and focused on a single change

## Directory Structure

```
migrations/
└── db/           # Contains all migration files
    └── *.sql     # Migration files with timestamp prefix
```

## Note
The docker-compose file for local development will be added separately. This will allow you to spin up a local database instance for testing migrations.
