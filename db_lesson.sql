Q1
 CREATE TABLE `departments`(
    -> department_id INT auto_increment PRIMARY KEY,
    -> name VARCHAR(20) NOT NULL,
    -> created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -> updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP);

Q2
 CREATE TABLE `departments`(
    -> department_id INT unsigned auto_increment PRIMARY KEY,
    -> name VARCHAR(20) NOT NULL,
    -> created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    -> updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP);

department_idを追加しました。
 ALTER TABLE people ADD department_id INT unsigned NULL AFTER email;


Q3-1
 INSERT INTO departments(name)
    -> VALUES
    -> ('営業'),
    -> ('開発'),
    -> ('経理'),
    -> ('人事'),
    -> ('情報システム');

Q3-2
  INSERT INTO people (name,department_id,age, gender)
    -> VALUES
    -> ('宮本伊織','1','13','1'),
    -> ('木曾義仲','1','35','1'),
    -> ('伊吹童子','1','20','2'),
    -> ('松永久秀','2','32','1'),
    -> ('由井正雪','2','10','1'),
    -> ('藤堂平助','2','22','1'),
    -> ('三島由紀夫','2','20','1'),
    -> ('日本武尊','3','60','1'),
    -> ('望月千代女','4','36','2'),
    -> ('小野小町','5','51','2');

Q3-3
 INSERT INTO reports (person_id,content)VALUES
    -> ('1','自由研究には向かない殺人'),
    -> ('2','世界で一番透きとおった物語'),
    -> ('3','ビブリア古書堂の事件手帖'),
    -> ('4','プロジェクト・ヘイル・メアリー'),
    -> ('11','レーエンデ国物語'),
    -> ('6','八月の銀の雪'),
    -> ('7','ハンニバル・ライジング'),
    -> ('8','羊たちの沈黙'),
    -> ('9','ギルガメシュ叙事詩'),
    -> ('10','アルジャーノンに花束を');

Q4
UPDATE people
    -> set department_id = case person_id
    -> when 1 then '1'
    -> when 2 then '1'
    -> when 3 then '1'
    -> when 4 then '2'
    -> when 6 then '2'
    -> end
    -> where person_id in (1,2,3,4,6);

Q5
 SELECT name,age
    -> from People
    -> where gender = '1'
    -> order by age desc;
+--------------------+------+
| name               | age  |
+--------------------+------+
| 日本武尊           |   60 |
| 福田だいすけ       |   42 |
| 木曽義仲           |   35 |
| 松永久秀           |   32 |
| 藤堂平助           |   22 |
| 鈴木たかし         |   20 |
| 三島由紀夫         |   20 |
| 宮本伊織           |   13 |
| 由井正雪           |   10 |
+--------------------+------+
9 rows in set (0.001 sec)

Q6
SELECT
  `name`, `email`, `age`
>テーブルから取得したいカラム（名前、メールアドレス、年齢）を指定

FROM
  `people`
>peopleテーブルからデータを取得するよう指定

WHERE
  `department_id` = 1
>必要なレコードを指定（department_idの1行目）

ORDER BY
  `created_at`;
>データを作成日時の順に並び替え

Q7
 SELECT name
    -> from People
    -> where (gender = '2' and age between 20 and 29)
    -> or (gender = '1' and age between 40 and 49);
+--------------------+
| name               |
+--------------------+
| 田中ゆうこ         |
| 福田だいすけ       |
| 伊吹童子           |
+--------------------+
3 rows in set (0.122 sec)

Q8
 SELECT *
    -> FROM people
    -> where department_id = '1'
    -> order by age asc;
+-----------+--------------------+------------------+---------------+------+--------+---------------------+---------------------+
| person_id | name               | email            | department_id | age  | gender | created_at          | updated_at          |
+-----------+--------------------+------------------+---------------+------+--------+---------------------+---------------------+
|         7 | 宮本伊織           | NULL             |             1 |   13 |      1 | 2026-05-12 19:15:47 | 2026-05-17 14:46:01 |
|         1 | 鈴木たかし         | suzuki@gizumo.jp |             1 |   20 |      1 | 2026-03-03 20:24:39 | 2026-05-17 14:46:01 |
|         9 | 伊吹童子           | NULL             |             1 |   20 |      2 | 2026-05-12 19:35:19 | 2026-05-17 14:46:01 |
|         2 | 田中ゆうこ         | tanaka@gizumo.jp |             1 |   25 |      2 | 2026-03-03 20:26:18 | 2026-05-17 14:46:01 |
|         8 | 木曽義仲           | NULL             |             1 |   35 |      1 | 2026-05-12 19:35:19 | 2026-05-17 14:46:01 |
|         3 | 福田だいすけ       | fukuda@gizumo.jp |             1 |   42 |      1 | 2026-03-03 20:26:18 | 2026-05-17 14:46:01 |
+-----------+--------------------+------------------+---------------+------+--------+---------------------+---------------------+
6 rows in set (0.001 sec)

Q9
 select avg(age) as average_age
    -> from people
    -> where gender = '2'
    -> and department_id = '2'
    -> group by department_id;
+-------------+
| average_age |
+-------------+
|     49.0000 |
+-------------+
1 row in set (0.026 sec)

Q10
 SELECT p.name, p.department_id, r.content
    -> FROM people p join reports r on p.person_id = r.person_id;
+-----------------------+---------------+-----------------------------------------------+
| name                  | department_id | content                                       |
+-----------------------+---------------+-----------------------------------------------+
| 鈴木たかし            |             1 | 日本語                                         |
| 鈴木たかし            |             1 | test                                          |
| 田中ゆうこ            |             1 | second                                        |
| 田中ゆうこ            |             1 | test                                          |
| 福田だいすけ          |             1 | sannbannme                                    |
| 福田だいすけ          |             1 | 三番目                                         |
| 豊島はなこ            |             2 | yottume                                       |
| 豊島はなこ            |             2 | 四番目                                        |
| 不思議沢みちこ        |             2 | text                                          |
| 鈴木たかし            |             1 | 自由研究には向かない殺人                        |
| 田中ゆうこ            |             1 | 世界で一番透きとおった物語                      |
| 福田だいすけ          |             1 | ビブリア古書堂の事件手帖                        |
| 豊島はなこ            |             2 | プロジェクト・ヘイル・メアリー                  |
| 由井正雪              |             2 | レーエンデ国物語                               |
| 不思議沢みちこ        |             2 | 八月の銀の雪                                   |
| 宮本伊織              |             1 | ハンニバル・ライジング                          |
| 木曽義仲              |             1 | 羊たちの沈黙                                   |
| 伊吹童子              |             1 | ギルガメシュ叙事詩                              |
| 松永久秀              |             2 | アルジャーノンに花束を                           |
+-----------------------+---------------+-----------------------------------------------+
19 rows in set (0.002 sec)

Q11
 SELECT p.name
    -> FROM people p left join reports r on p.person_id = r.person_id
    -> WEHRE r.content IS NULL;
+-----------------+
| name            |
+-----------------+
| 藤堂平助        |
| 三島由紀夫      |
| 日本武尊        |
| 望月千代女      |
| 小野小町        |
+-----------------+
5 rows in set (0.021 sec)