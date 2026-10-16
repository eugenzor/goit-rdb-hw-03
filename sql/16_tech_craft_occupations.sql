-- Які рівні високих доходів спостерігаються серед професій, у назвах яких є tech або craft?
SELECT
    occupation,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS TRUE)
          / NULLIF(COUNT(*),0), 2) AS pct_high_income
FROM hw3_adult_clean
WHERE occupation ILIKE '%tech%'
   OR occupation ILIKE '%craft%'
GROUP BY occupation
ORDER BY n_rows DESC, occupation;
