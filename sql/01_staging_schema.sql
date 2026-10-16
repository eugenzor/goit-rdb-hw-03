-- Створюємо таблицю staging
DROP TABLE IF EXISTS hw3_adult_staging CASCADE;

CREATE TABLE hw3_adult_staging (
    source_split_raw   TEXT,
    source_row_raw     TEXT,
    age_raw            TEXT,
    workclass_raw      TEXT,
    fnlwgt_raw         TEXT,
    education_raw      TEXT,
    education_num_raw  TEXT,
    marital_status_raw TEXT,
    occupation_raw     TEXT,
    relationship_raw   TEXT,
    race_raw           TEXT,
    sex_raw            TEXT,
    capital_gain_raw   TEXT,
    capital_loss_raw   TEXT,
    hours_per_week_raw TEXT,
    native_country_raw TEXT,
    income_raw         TEXT
);
