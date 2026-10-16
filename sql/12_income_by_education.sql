-- Для яких рівнів освіти частка респондентів з доходом понад 50 000
-- є найбільшою серед категорій із щонайменше 100 записами?
SELECT
    education,
    COUNT(*) AS n_rows,
    COUNT(*) FILTER (WHERE income_over_50k IS TRUE) AS n_high_income,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS TRUE)
          / NULLIF(COUNT(*),0), 2) AS pct_high_income
FROM hw3_adult_clean
GROUP BY education
HAVING COUNT(*) >= 100
ORDER BY pct_high_income DESC, n_rows DESC, education
LIMIT 10;
