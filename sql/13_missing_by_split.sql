-- Чи однакова частка відсутніх workclass і occupation в оригінальних піднаборах train і test?
SELECT
    source_split,
    COUNT(*) AS n_rows,
    COUNT(*) FILTER (WHERE workclass IS NULL) AS n_null_workclass,
    ROUND(100.0 * COUNT(*) FILTER (WHERE workclass IS NULL)
          / NULLIF(COUNT(*),0), 2) AS pct_null_workclass,
    COUNT(*) FILTER (WHERE occupation IS NULL) AS n_null_occupation,
    ROUND(100.0 * COUNT(*) FILTER (WHERE occupation IS NULL)
          / NULLIF(COUNT(*),0), 2) AS pct_null_occupation
FROM hw3_adult_clean
GROUP BY source_split
ORDER BY source_split;
