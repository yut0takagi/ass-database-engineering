PRAGMA foreign_keys = ON;

-- 見やすさのためのラベル
SELECT '【課題その1】SQL実行結果' AS "info";

-- 1. 運動強度が「小」のメニューを表示せよ。
SELECT '1' AS "問", "メニュー"
FROM "運動強度"
WHERE "強度" = '小';

-- 2. 性別ごとの会員数を求めよ。
SELECT '2' AS "問", "性別", COUNT(*) AS "会員数"
FROM "会員"
GROUP BY "性別"
ORDER BY "性別";

-- 3. 全女性会員の平均身長(cm)と平均体重(kg)を求めよ。
SELECT '3' AS "問",
       AVG(m."身長") AS "平均身長(cm)",
       AVG(m."体重") AS "平均体重(kg)"
FROM "会員" k
JOIN "身体計測" m ON m."会員番号" = k."会員番号"
WHERE k."性別" = '女';

-- 4. 「ジョギング」を選択している会員の会員名と身長(cm)と体重(kg)を表示せよ。
SELECT '4' AS "問",
       k."氏名",
       m."身長" AS "身長(cm)",
       m."体重" AS "体重(kg)"
FROM "選択" s
JOIN "会員" k ON k."会員番号" = s."会員番号"
JOIN "身体計測" m ON m."会員番号" = k."会員番号"
WHERE s."メニュー" = 'ジョギング';

-- 5. 運動強度が「中」のメニューを選択している会員の会員番号と性別と年齢を表示せよ。
SELECT '5' AS "問",
       k."会員番号",
       k."性別",
       k."年齢"
FROM "選択" s
JOIN "会員" k ON k."会員番号" = s."会員番号"
JOIN "運動強度" u ON u."メニュー" = s."メニュー"
WHERE u."強度" = '中'
ORDER BY k."会員番号";

-- 6. BMI が 25 以上の会員の会員番号、氏名、性別、年齢、身長(cm)、体重(kg)を選択し、
--    ビュー「肥満会員」を定義せよ。
--    BMI = 体重[kg] ÷ (身長[m])²
DROP VIEW IF EXISTS "肥満会員";
CREATE VIEW "肥満会員" AS
SELECT k."会員番号",
       k."氏名",
       k."性別",
       k."年齢",
       m."身長" AS "身長(cm)",
       m."体重" AS "体重(kg)"
FROM "会員" k
JOIN "身体計測" m ON m."会員番号" = k."会員番号"
WHERE (m."体重" * 10000.0) / (m."身長" * m."身長") >= 25.0;

-- ビュー内容の確認
SELECT '6' AS "問", *
FROM "肥満会員"
ORDER BY "会員番号";

-- 7. 運動強度が「大」のメニューを選択している会員の会員番号と BMI を表示せよ。
SELECT '7' AS "問",
       k."会員番号",
       ROUND((m."体重" * 10000.0) / (m."身長" * m."身長"), 2) AS "BMI"
FROM "選択" s
JOIN "会員" k ON k."会員番号" = s."会員番号"
JOIN "身体計測" m ON m."会員番号" = k."会員番号"
JOIN "運動強度" u ON u."メニュー" = s."メニュー"
WHERE u."強度" = '大'
ORDER BY k."会員番号";


