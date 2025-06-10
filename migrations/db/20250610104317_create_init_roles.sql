-- migrate:up
CREATE ROLE IF NOT EXISTS anon NOLOGIN;
CREATE ROLE IF NOT EXISTS authenticated NOLOGIN;
CREATE ROLE IF NOT EXISTS service_role NOLOGIN;
CREATE ROLE IF NOT EXISTS supabase_auth_admin LOGIN PASSWORD 'SuperSecureAdminPassword';

-- migrate:down
DROP ROLE IF EXISTS service_role;
DROP ROLE IF EXISTS authenticated;
DROP ROLE IF EXISTS anon;
DROP ROLE IF EXISTS supabase_auth_admin;