-- migrate:up
CREATE TABLE IF NOT EXISTS demo_check ( id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL );
-- migrate:down
DROP TABLE IF EXISTS demo_check;
