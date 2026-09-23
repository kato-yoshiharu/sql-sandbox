-- パフォーマンスチューニング学習用
CREATE DATABASE performance_tuning;

\c performance_tuning

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL
);

CREATE TABLE tweets (
  id SERIAL PRIMARY KEY,
