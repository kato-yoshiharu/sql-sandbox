-- パフォーマンスチューニング学習用
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

-- インデックス / EXPLAIN / パーティション練習用
-- created_atには意図的にインデックスを張っていない
CREATE TABLE access_logs (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  path VARCHAR(255) NOT NULL,
  status_code INTEGER NOT NULL,
  created_at TIMESTAMPTZ NOT NULL
);
