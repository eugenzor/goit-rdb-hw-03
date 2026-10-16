-- Як змінюється частка доходу понад 50 тис. USD між чотирма діапазонами робочих годин на тиждень?
WITH binned AS (
    SELECT
        CASE
            WHEN hours_per_week BETWEEN 1 AND 20 THEN '01–20'
            WHEN hours_per_week BETWEEN 21 AND 40 THEN '21–40'
            WHEN hours_per_week BETWEEN 41 AND 60 THEN '41–60'
            ELSE '61–99'
        END AS hours_group,
        income_over_50k
    FROM hw3_adult_clean
)
SELECT
    hours_group,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS TRUE)
          / NULLIF(COUNT(*),0), 2) AS pct_high_income
FROM binned
GROUP BY hours_group
ORDER BY hours_group;
