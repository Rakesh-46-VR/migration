-- migrate:up
CREATE ROLE IF NOT EXISTS anon NOLOGIN;

-- migrate:down
DROP ROLE IF EXISTS anon;