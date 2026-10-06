# JOIN

```sql
SELECT <column1>, <column2>, ...
FROM <table1>
JOIN <table2>
ON <結合条件>
```

DBMSがどのように結合処理を行うかをイメージすることが大事。
FROM句で指定したテーブルを左表(Left Table)やPrimary Table、JOIN句で指定したテーブルを右表(Right Table)やJoined Tableという。

DBMSは、左表の各行に対して、以下のSQLを繰り返し実行している。

```sql
SELECT * FROM table2 WHERE <結合条件>
```

結合先が複数の場合、その行数に合わせて結合元の行を複製して結合する。
結合先が存在しない場合、結果には表示されなくなる。

## INNER JOIN

JOIN = INNER JOIN

## OUTER JOIN

### LEFT JOIN

左外部結合(left outer join)
LEFT JOIN = LEFT OUTER JOIN

左表に対して、結合先が存在しなくても出力するような結合のこと。
結合先が存在しない場合、結果表に表示される右表の列はすべてNULLになる。

### RIGHT JOIN

LEFT JOINの右表版。

### FULL JOIN

左表と右表に対して、結合先が存在しなくても出力するような結合のこと。

MySQLやMariaDBなど、FULL JOINを利用できないDBMSでは、UNIONを使って同等の処理を実現できる。

## CROSS JOIN
