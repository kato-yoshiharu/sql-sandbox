# Pagination, Paging

## Offset-Based

`LIMIT-OFFSET`と`OFFSET-FETCH`の書き方があるが、目的は同じ。

1件目から取得したい場合は0を指定するか、DBMSによってはOFFSET句自体を省略できる。

### input

```ts
interface Input {
  "perPage": number,
  "page": number,
}
```

### Pros

実装が簡単。

### Cons

OFFSETが大きくなるとパフォーマンスが悪くなる。
行数が変わるとページがずれる。

### LIMIT-OFFSET

```sql
SELECT <column> FROM <table>
LIMIT <取得する行数> OFFSET <スキップする行数>
```

MySQL, PostgreSQL, SQLiteでサポートされている。

```sql
SELECT *
FROM tables
LIMIT perPage
OFFSET ((page - 1) * perPage)
```

### OFFSET-FETCH

```sql
SELECT <column> FROM <table>
ORDER BY <column>
OFFSET <スキップする行数> ROWS
FETCH NEXT <取得する行数> ROWS ONLY
```

Oracle, SQL Serverでサポートされている。

## Cursor-Based

### input

<!-- TODO -->

### Pros

大量のデータに対して効果的。

### Cons

実装が複雑になりやすい。

## Offset vs Cursor-Based Pagination

- <https://medium.com/@oshiryaeva/offset-vs-cursor-based-pagination-which-is-the-right-choice-for-your-project-e46f65db062f>
- <https://medium.com/@maryam-bit/offset-vs-cursor-based-pagination-choosing-the-best-approach-2e93702a118b>

## Seek Method

前ページの最終行をキーにして問い合わせを行う。
そのため、テーブルの後の方の行でもパフォーマンスが悪くならない。

ORDER BY句にはユニークキーを含める必要がある。

### 参考

- <https://qiita.com/madilloar/items/b4e786a932ef9d4551b9>
- <https://qiita.com/madilloar/items/5625e61cf3e348d08ef8>

## With Window-Functions

SQLiteではサポートされていない。

### 例

```sql
SELECT
  *
FROM
  (
    SELECT
      *,
      ROW_NUMBER() OVER (
        ORDER BY
          <column> DESC
      ) <RN>
    FROM
      table
  ) <TMP>
WHERE
  <RN> >= <from>
  AND <RN> <= <to>
```

ROW_NUMBER関数は、OVER句の定義順に並べ替え、連番を付与する。

## 参考

- <https://use-the-index-luke.com/ja/sql/partial-results>
