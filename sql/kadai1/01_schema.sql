PRAGMA foreign_keys = ON;

-- 課題その1（2024年度データベース工学レポート課題(その1)）の4つのリレーション
-- 会員（会員番号, 氏名, 性別, 年齢）
-- 身体計測（会員番号, 身長, 体重）
-- 選択（会員番号, メニュー）
-- 運動強度（メニュー, 強度）

DROP TABLE IF EXISTS "選択";
DROP TABLE IF EXISTS "身体計測";
DROP TABLE IF EXISTS "運動強度";
DROP TABLE IF EXISTS "会員";

CREATE TABLE "会員" (
  "会員番号" INTEGER PRIMARY KEY,
  "氏名"     TEXT NOT NULL,
  "性別"     TEXT NOT NULL CHECK ("性別" IN ('男', '女')),
  "年齢"     INTEGER NOT NULL CHECK ("年齢" >= 0)
);

CREATE TABLE "身体計測" (
  "会員番号" INTEGER PRIMARY KEY,
  "身長"     REAL NOT NULL CHECK ("身長" > 0), -- cm
  "体重"     REAL NOT NULL CHECK ("体重" > 0), -- kg
  FOREIGN KEY ("会員番号") REFERENCES "会員" ("会員番号")
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "運動強度" (
  "メニュー" TEXT PRIMARY KEY,
  "強度"     TEXT NOT NULL CHECK ("強度" IN ('小', '中', '大'))
);

CREATE TABLE "選択" (
  "会員番号" INTEGER PRIMARY KEY,
  "メニュー" TEXT NOT NULL,
  FOREIGN KEY ("会員番号") REFERENCES "会員" ("会員番号")
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("メニュー") REFERENCES "運動強度" ("メニュー")
    ON UPDATE CASCADE ON DELETE RESTRICT
);


