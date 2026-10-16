-- 4.1. Розподіл категоріальної колонки
SELECT
    COALESCE(workclass, '(невідомо)') AS workclass_group,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_rows
FROM hw3_adult_clean
GROUP BY workclass
ORDER BY n_rows DESC, workclass_group
LIMIT 10;
