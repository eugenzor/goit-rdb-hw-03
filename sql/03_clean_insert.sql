-- Переганяємо дані в "чисту" таблицю
INSERT INTO hw3_adult_clean (
    source_split, source_row, age, workclass, fnlwgt,
    education, education_num, marital_status, occupation,
    relationship, race, sex, capital_gain, capital_loss,
    hours_per_week, native_country, income_over_50k
)
SELECT
    TRIM(source_split_raw) AS source_split,
    TRIM(source_row_raw)::INTEGER AS source_row,
    TRIM(age_raw)::SMALLINT AS age,
    NULLIF(NULLIF(TRIM(workclass_raw), '?'), '') AS workclass,
    TRIM(fnlwgt_raw)::INTEGER AS fnlwgt,
    TRIM(education_raw) AS education,
    TRIM(education_num_raw)::SMALLINT AS education_num,
    TRIM(marital_status_raw) AS marital_status,
    NULLIF(NULLIF(TRIM(occupation_raw), '?'), '') AS occupation,
    TRIM(relationship_raw) AS relationship,
    TRIM(race_raw) AS race,
    TRIM(sex_raw) AS sex,
    TRIM(capital_gain_raw)::NUMERIC(12,2) AS capital_gain,
    TRIM(capital_loss_raw)::NUMERIC(12,2) AS capital_loss,
    TRIM(hours_per_week_raw)::SMALLINT AS hours_per_week,
    NULLIF(NULLIF(TRIM(native_country_raw), '?'), '') AS native_country,
    CASE TRIM(TRAILING '.' FROM TRIM(income_raw))
        WHEN '>50K' THEN TRUE
        WHEN '<=50K' THEN FALSE
        ELSE NULL
    END AS income_over_50k
FROM hw3_adult_staging;

SELECT adult_id, source_split, source_row, age, workclass,
       education, occupation, hours_per_week, income_over_50k
FROM hw3_adult_clean
ORDER BY adult_id
LIMIT 5;
