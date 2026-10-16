-- Null-rate для 8 важливих колонок після очищення
SELECT
    COUNT(*) AS total_rows,
    ROUND(100.0 * COUNT(*) FILTER (WHERE workclass IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_workclass,
    ROUND(100.0 * COUNT(*) FILTER (WHERE occupation IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_occupation,
    ROUND(100.0 * COUNT(*) FILTER (WHERE native_country IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_native_country,
    ROUND(100.0 * COUNT(*) FILTER (WHERE age IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_age,
    ROUND(100.0 * COUNT(*) FILTER (WHERE education IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_education,
    ROUND(100.0 * COUNT(*) FILTER (WHERE hours_per_week IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_hours,
    ROUND(100.0 * COUNT(*) FILTER (WHERE capital_gain IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_capital_gain,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null_income
FROM hw3_adult_clean;
