# DBパフォーマンスチューニング

DBが遅い原因は、「クエリの本数が多いか、クエリ自体が遅いか」のよう。

```sh
# 起動
cd postgres && cargo make serve
# 接続
lazysql "postgres://postgres:password@localhost:5555/performance_tuning?sslmode=disable"
```

## クエリの本数が多い場合

まずは、クエリの本数が多い場合。
SELECTが遅い場合とINSERTが遅い場合に分かれる。
両方に共通しているのは、データの件数分クエリを発行しているということ。

### SELECTが遅い場合

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

N+1の何が問題かというと、
クエリの1往復にかかる、`ネットワークレイテンシ`、`コネクション確保`、`パース`、`プランニング`のオーバーヘッドがクエリの本数分積み重なる。

JOINの注意
結果セットの肥大化に伴うオーバーヘッド
カーディナリティ（値の分布の偏り）があるときに、オプティマイザが実際のデータ量を見誤り、非効率になる場合があるので注意。

EXPLAIN ANALYZEで行数と実行時間を確認できる。

Eager Loadingとは
Eager LoadingとLazy Loadingがあるらしい。
LazyLoadingはデフォルトの挙動。
ループの度にクエリを発行する。
Eager Loadingは、関連データをJOINや一括クエリで取得しておくアプローチ。

### 書き込み（INSERT/UPDATE/UPSERT/DELETE）が遅い場合

バッチ処理とバルク処理の違い
バッチ処理は、一定量・一定時間にまとめて処理をする実行方式全般。DBに限らない。
バルク処理は、1回の操作でまとめて処理すること。主にDB。

大量の書き込みには、複数レコードを1本のSQLにまとめるバルク処理が有効。

```sql
-- 遅い例: 1件ずつINSERT（10,000本）
INSERT INTO tweets (user_id, text) VALUES (1, 'tweet_1');
INSERT INTO tweets (user_id, text) VALUES (2, 'tweet_2');
-- ...

-- 改善例: バルクインサート（1本）
INSERT INTO tweets (user_id, text)
SELECT (i % 1000) + 1, 'tweet_' || i
FROM generate_series(1, 10000) AS i;
```
