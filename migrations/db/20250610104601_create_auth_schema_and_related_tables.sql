-- migrate:up
CREATE SCHEMA IF NOT EXISTS auth;

-- Create the users table
CREATE TABLE IF NOT EXISTS auth.users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL UNIQUE CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
  password_hash TEXT NOT NULL,
  avatar_url TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  role TEXT NOT NULL DEFAULT 'authenticated',
  email_confirmed BOOLEAN DEFAULT FALSE,
  last_password_change TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  created_at TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC'),
  updated_at TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'UTC')
);

-- Ensure only the admin role can modify the schema
REVOKE ALL ON SCHEMA auth FROM PUBLIC;
GRANT USAGE ON SCHEMA auth TO supabase_auth_admin;

-- Lock down table permissions
REVOKE ALL ON auth.users FROM PUBLIC;

GRANT SELECT, INSERT, UPDATE, DELETE ON auth.users TO supabase_auth_admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA auth
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO supabase_auth_admin;

-- Track updates
CREATE OR REPLACE FUNCTION auth.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW() AT TIME ZONE 'UTC';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON auth.users
FOR EACH ROW
EXECUTE FUNCTION auth.update_timestamp();


-- migrate:down

-- Drop the trigger
DROP TRIGGER IF EXISTS set_updated_at ON auth.users;

-- Drop the function
DROP FUNCTION IF EXISTS auth.update_timestamp();

-- Revoke table privileges granted
REVOKE SELECT, INSERT, UPDATE, DELETE ON auth.users FROM supabase_auth_admin;

-- Drop the users table
DROP TABLE IF EXISTS auth.users;

-- Revoke usage on auth schema
REVOKE USAGE ON SCHEMA auth FROM supabase_auth_admin;

-- Drop the auth schema (only if empty)
DROP SCHEMA IF EXISTS auth;