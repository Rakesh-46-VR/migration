-- migrate:up
CREATE TABLE IF NOT EXISTS auth.sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  ip VARCHAR(255) NULL,
  user_agent TEXT NULL,
  refresh_token TEXT UNIQUE NOT NULL,
  refresh_token_expires_at timestamptz NOT NULL DEFAULT now() + interval '30 days',
  access_token_expires_at timestamptz NOT NULL DEFAULT now() + interval '15 minutes',
  updated_at timestamptz NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON auth.sessions
FOR EACH ROW
EXECUTE FUNCTION auth.update_timestamp();

-- migrate:down

DROP TRIGGER IF EXISTS set_updated_at ON auth.sessions;

DROP TABLE IF EXISTS auth.sessions;