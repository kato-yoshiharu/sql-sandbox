# SELECT

## DISTINCT

重複行を除外する。

```sql
SELECT DISTINCT column FROM tables
```

### Use case

値の一覧を取得したい場合。

## ORDER BY

```sql
SELECT <column> FROM <tables>
  ORDER BY <column> <ASC | DESC>
```

デフォルトは`ASC`。

指定した列が文字列の場合は、DBMSに設定された照合順序(文字コード順やアルファベット順)を基準に並べ替えられる。

複数の列を指定することができ、同じ値の場合は次の列によって並べ替えられる。

ORDER BYを指定しない場合、DBMSはどのような順序で行を返すかを保証していない。

### 列番号を指定した並べ替え

列番号とは、選択列リストの1からの順番。

```sql
SELECT column1, column2 FROM tables
  ORDER BY 2, 1
```

集合演算子を使う場合は、単純な列名指定を行えないという制約があるため、列番号での指定を用いることもある。

### Use case

- ランキング
- 検索時の並べ替え
