# sql-sandbox

SQLの学習・検証用のPostgreSQL環境と、学習メモをまとめたリポジトリ。

## 起動

```sh
cd postgres
cargo make serve
```

## 接続

```sh
sqlit "postgres://postgres:password@localhost:5555/performance_tuning?sslmode=disable"
```
