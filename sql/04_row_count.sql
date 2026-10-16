-- 3.1. Контроль кількості рядків
SELECT 'staging' AS layer, COUNT(*) AS n_rows
FROM hw3_adult_staging
UNION ALL
SELECT 'clean' AS layer, COUNT(*) AS n_rows
FROM hw3_adult_clean
ORDER BY layer;
