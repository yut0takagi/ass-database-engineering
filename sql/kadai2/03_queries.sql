PRAGMA foreign_keys = ON;

SELECT '【課題その2】作問（5題）＋模範解答（SQL）' AS "info";

-- (問1) 学年ごとの学生数を求めよ。
-- 模範解答:
SELECT '問1' AS "問", "学年", COUNT(*) AS "学生数"
FROM "学生"
GROUP BY "学年"
ORDER BY "学年";

-- (問2) 各学生について、履修している科目数と平均点を表示せよ（学生名も表示すること）。
-- ※複数表参照（学生×履修）
-- 模範解答:
SELECT '問2' AS "問",
       s."学籍番号",
       s."氏名",
       COUNT(e."科目ID") AS "履修科目数",
       ROUND(AVG(e."点数"), 2) AS "平均点"
FROM "学生" s
LEFT JOIN "履修" e ON e."学籍番号" = s."学籍番号"
GROUP BY s."学籍番号", s."氏名"
ORDER BY s."学籍番号";

-- (問3) 学科ごとの平均点を求めよ（履修の点数を用いる）。
-- ※複数表参照（学生×履修×学科）
-- 模範解答:
SELECT '問3' AS "問",
       d."学科名",
       ROUND(AVG(e."点数"), 2) AS "学科平均点"
FROM "履修" e
JOIN "学生" s ON s."学籍番号" = e."学籍番号"
JOIN "学科" d ON d."学科ID" = s."学科ID"
GROUP BY d."学科ID", d."学科名"
ORDER BY d."学科ID";

-- (問4) 各科目について、「その科目の平均点以上」を取った学生の氏名・科目名・点数を表示せよ。
-- ※入れ子型質問（相関サブクエリ）＋複数表参照（学生×履修×科目）
-- 模範解答:
SELECT '問4' AS "問",
       s."氏名",
       c."科目名",
       e."点数"
FROM "履修" e
JOIN "学生" s ON s."学籍番号" = e."学籍番号"
JOIN "科目" c ON c."科目ID" = e."科目ID"
WHERE e."点数" >= (
  SELECT AVG(e2."点数")
  FROM "履修" e2
  WHERE e2."科目ID" = e."科目ID"
)
ORDER BY c."科目ID", e."点数" DESC, s."学籍番号";

-- (問5) どの科目も担当していない教員の氏名を表示せよ。
-- 模範解答（NOT EXISTS）:
SELECT '問5' AS "問",
       t."教員ID",
       t."氏名"
FROM "教員" t
WHERE NOT EXISTS (
  SELECT 1
  FROM "科目" c
  WHERE c."担当教員ID" = t."教員ID"
)
ORDER BY t."教員ID";


