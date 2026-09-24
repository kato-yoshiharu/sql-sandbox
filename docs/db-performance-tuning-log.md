# DBパフォーマンスチューニング

DBが遅い原因は、「クエリの本数が多いか、クエリ自体が遅いか」のよう。

```sh
lazysql "postgres://postgres:password@localhost:5555/performance_tuning?sslmode=disable"
```

