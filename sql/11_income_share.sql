-- Яка частка респондентів має річний дохід строго понад 50 000 USD,
-- а яка — не перевищує цей поріг?
SELECT
    income_over_50k,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_rows
FROM hw3_adult_clean
GROUP BY income_over_50k
ORDER BY income_over_50k DESC;
