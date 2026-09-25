-- パフォーマンスチューニング学習用
CREATE DATABASE performance_tuning;

\c performance_tuning

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL
);

CREATE TABLE tweets (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  text VARCHAR(140) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username)
SELECT 'user_' || i
FROM generate_series(1, 1000) AS i;

INSERT INTO tweets (user_id, text)
SELECT (i % 1000) + 1, 'tweet_' || i
FROM generate_series(1, 10000) AS i;

-- インデックス / EXPLAIN / パーティション練習用
-- created_atには意図的にインデックスを張っていない
CREATE TABLE access_logs (
  id SERIAL PRIMARY KEY,
