-- Чи відрізняється частка доходів понад 50 тис. у записів із ненульовим capital_gain або capital_loss
SELECT
    CASE
        WHEN capital_gain > 0 OR capital_loss > 0 THEN 'Є ненульова сума'
        ELSE 'Обидві суми нульові'
    END AS capital_group,
    COUNT(*) AS n_rows,
    ROUND(100.0 * COUNT(*) FILTER (WHERE income_over_50k IS TRUE)
          / NULLIF(COUNT(*),0), 2) AS pct_high_income
FROM hw3_adult_clean
GROUP BY capital_group
ORDER BY pct_high_income DESC;
