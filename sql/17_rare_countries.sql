-- Які країни походження мають не більше 100 записів у датасеті?
SELECT
    native_country,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM hw3_adult_clean), 3) AS pct_all
FROM hw3_adult_clean
WHERE native_country IS NOT NULL
GROUP BY native_country
HAVING COUNT(*) <= 100
ORDER BY n_rows ASC, native_country
LIMIT 15;
