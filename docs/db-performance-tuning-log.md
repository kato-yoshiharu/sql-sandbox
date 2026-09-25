# DBパフォーマンスチューニング

DBが遅い原因は、「クエリの本数が多いか、クエリ自体が遅いか」のよう。

```sh
# 起動
cd postgres && cargo make serve
# 接続
lazysql "postgres://postgres:password@localhost:5555/performance_tuning?sslmode=disable"
```

まずは、クエリの本数が多い場合。
SELECTが遅い場合とINSERTが遅い場合に分ける。

SELECTが遅いケースを見る。
N+1問題が主な原因なので、まず見ていく。
JOINとEager Loadingで発行クエリ数を減らす。
Eager Loadingは初めて聞いた。

まずはJOIN。

```sql
