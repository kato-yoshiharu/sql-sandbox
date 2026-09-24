# DBパフォーマンスチューニング

DBが遅い原因は、「クエリの本数が多いか、クエリ自体が遅いか」のよう。

```sh
# 起動
cd postgres && cargo make serve
# 接続
lazysql "postgres://postgres:password@localhost:5555/performance_tuning?sslmode=disable"
```

