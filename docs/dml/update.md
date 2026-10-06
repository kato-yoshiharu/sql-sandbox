# UPDATE

## 基本の構文

```sql
UPDATE <table name>
SET <column name> = <value>, ...
```

例:

```sql
UPDATE users
SET name = 'new name', updated_at = NOW()
WHERE id = 1
```

## 値がNULLの場合は更新しないようにする方法

COALESCE関数を使う。

```sql
UPDATE users SET name = COALESCE($2, name) WHERE id = $1
```
