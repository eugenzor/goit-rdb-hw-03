-- Які професійні категорії найпоширеніші і що там з заробітком?
SELECT
    COALESCE(occupation, '(невідомо)') AS occupation_group,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS TRUE)
          / NULLIF(COUNT(*),0), 2) AS pct_high_income
FROM hw3_adult_clean
GROUP BY COALESCE(occupation, '(невідомо)')
ORDER BY n_rows DESC, occupation_group
LIMIT 15;
