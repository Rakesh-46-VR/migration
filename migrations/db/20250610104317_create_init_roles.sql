-- migrate:up
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN;
  END IF;
END
$$;

-- migrate:down
DO $$
BEGIN
  IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'service_role') THEN
    DROP ROLE service_role;
  END IF;
END
$$;