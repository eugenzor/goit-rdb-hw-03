-- 4.2. Базова статистика числової колонки
SELECT
    COUNT(age) AS n_age,
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    ROUND(AVG(age)::NUMERIC, 2) AS avg_age,
    ROUND(STDDEV_SAMP(age)::NUMERIC, 2) AS sd_age,
    MIN(hours_per_week) AS min_hours,
    MAX(hours_per_week) AS max_hours,
    ROUND(AVG(hours_per_week)::NUMERIC, 2) AS avg_hours,
    ROUND(STDDEV_SAMP(hours_per_week)::NUMERIC, 2) AS sd_hours,
    MIN(capital_gain) AS min_capital_gain,
    MAX(capital_gain) AS max_capital_gain,
    ROUND(AVG(capital_gain), 2) AS avg_capital_gain
FROM hw3_adult_clean;
