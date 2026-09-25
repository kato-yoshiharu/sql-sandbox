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
-- N+1になる例: ツイートを取得してから1件ごとにユーザーを取得（10,000 + 1本）
SELECT id, user_id, text FROM tweets;
-- ↑の結果1件ずつに対して以下を発行してしまう
SELECT id, username FROM users WHERE id = :user_id;

-- 改善例: JOINでまとめて取得（1本）
SELECT t.id, t.text, u.username
FROM tweets AS t
JOIN users AS u ON u.id = t.user_id;
```

クエリの1往復にかかる、`ネットワークレイテンシ`、`コネクション確保`、`パース`、`プランニング`のオーバーヘッドがクエリの本数分積み重なる。

JOINの注意
カーディナリティ（値の分布の偏り）があるときに、オプティマイザが実際のデータ量を見誤り、非効率になる場合があるので注意。
