-- Створюємо таблицю з очищеними даними
DROP TABLE IF EXISTS hw3_adult_clean CASCADE;
CREATE TABLE hw3_adult_clean (
    adult_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_split      TEXT NOT NULL CHECK (source_split IN ('train', 'test')),
    source_row        INTEGER NOT NULL CHECK (source_row > 0),
    age               SMALLINT NOT NULL CHECK (age BETWEEN 17 AND 120),
    workclass         TEXT,
    fnlwgt            INTEGER NOT NULL CHECK (fnlwgt > 0),
    education         TEXT NOT NULL,
    education_num     SMALLINT NOT NULL CHECK (education_num BETWEEN 1 AND 16),
    marital_status    TEXT NOT NULL,
    occupation        TEXT,
    relationship      TEXT NOT NULL,
    race              TEXT NOT NULL,
    sex               TEXT NOT NULL CHECK (sex IN ('Female', 'Male')),
    capital_gain      NUMERIC(12, 2) NOT NULL CHECK (capital_gain >= 0),
    capital_loss      NUMERIC(12, 2) NOT NULL CHECK (capital_loss >= 0),
    hours_per_week    SMALLINT NOT NULL CHECK (hours_per_week BETWEEN 1 AND 99),
    native_country    TEXT,
    income_over_50k   BOOLEAN NOT NULL,
    UNIQUE (source_split, source_row)
);
