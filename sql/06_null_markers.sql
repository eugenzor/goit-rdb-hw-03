-- 3.3. Null-rate і спеціальні маркери
SELECT
    COUNT(*) AS n_rows,
    COUNT(*) FILTER (
        WHERE workclass_raw IS NULL OR TRIM(workclass_raw) IN ('', '?')
    ) AS missing_workclass_raw,
    COUNT(*) FILTER (
        WHERE education_raw IS NULL OR TRIM(education_raw) IN ('', '?')
    ) AS missing_education_raw,
    COUNT(*) FILTER (
        WHERE occupation_raw IS NULL OR TRIM(occupation_raw) IN ('', '?')
    ) AS missing_occupation_raw,
    COUNT(*) FILTER (
        WHERE native_country_raw IS NULL OR TRIM(native_country_raw) IN ('', '?')
    ) AS missing_country_raw,
    COUNT(*) FILTER (
        WHERE TRIM(income_raw) LIKE '%.'
    ) AS income_with_trailing_dot
FROM hw3_adult_staging;
