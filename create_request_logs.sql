-- Create the request_logs table for tracking API requests
CREATE TABLE IF NOT EXISTS request_logs (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  method TEXT NOT NULL,
  path TEXT NOT NULL,
  status_code INTEGER NOT NULL,
  duration INTEGER NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
  request_body JSONB,
  response_body JSONB,
  ip TEXT,
  user_agent TEXT
);