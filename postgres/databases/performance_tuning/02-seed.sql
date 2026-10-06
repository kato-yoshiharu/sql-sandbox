INSERT INTO users (username)
SELECT 'user_' || i
FROM generate_series(1, 1000) AS i;

INSERT INTO tweets (user_id, text)
SELECT (i % 1000) + 1, 'tweet_' || i
FROM generate_series(1, 10000) AS i;

INSERT INTO access_logs (user_id, path, status_code, created_at)
SELECT
  (i % 5000) + 1,
  '/path/' || (i % 50),
  CASE WHEN i % 100 = 0 THEN 500 ELSE 200 END,
  TIMESTAMPTZ '2026-01-01 00:00:00' + (i || ' seconds')::INTERVAL
FROM generate_series(1, 300000) AS i;
