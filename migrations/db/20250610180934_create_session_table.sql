-- migrate:up
CREATE TABLE IF NOT EXISTS auth.sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id),
  refresh_token TEXT UNIQUE NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION auth.insert_session(
    p_user_id UUID,
    p_refresh_token TEXT,
    p_expires_at TIMESTAMPTZ
)
RETURNS void AS $$
BEGIN
  -- Delete existing sessions for this user
  DELETE FROM auth.sessions
  WHERE user_id = p_user_id;

  -- Insert the new session
  INSERT INTO auth.sessions (user_id, refresh_token, expires_at)
  VALUES (p_user_id, p_refresh_token, p_expires_at);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- migrate:down
DROP TABLE IF EXISTS auth.sessions;
DROP FUNCTION IF EXISTS auth.insert_session(UUID, TEXT, TIMESTAMPTZ);