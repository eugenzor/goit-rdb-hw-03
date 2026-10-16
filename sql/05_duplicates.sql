-- 3.2. Перевірка дублікатів
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (
        age, workclass, fnlwgt, education, education_num,
        marital_status, occupation, relationship, race, sex,
        capital_gain, capital_loss, hours_per_week, native_country,
        income_over_50k
    )) AS distinct_business_keys,
    COUNT(*) - COUNT(DISTINCT (
        age, workclass, fnlwgt, education, education_num,
        marital_status, occupation, relationship, race, sex,
        capital_gain, capital_loss, hours_per_week, native_country,
        income_over_50k
    )) AS duplicate_rows
FROM hw3_adult_clean;
