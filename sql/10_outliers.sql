-- 4.3. Один outlier-check
WITH stats AS (
    SELECT AVG(hours_per_week) AS avg_h, STDDEV_SAMP(hours_per_week) AS sd_h
    FROM hw3_adult_clean
)
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE s.sd_h > 0 AND ABS(t.hours_per_week - s.avg_h) > 3 * s.sd_h
    ) AS n_outliers,
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE s.sd_h > 0 AND ABS(t.hours_per_week - s.avg_h) > 3 * s.sd_h
    ) / NULLIF(COUNT(*),0), 2) AS pct_outliers
FROM hw3_adult_clean AS t
CROSS JOIN stats AS s;

WITH stats AS (
    SELECT AVG(hours_per_week) AS avg_h, STDDEV_SAMP(hours_per_week) AS sd_h
    FROM hw3_adult_clean
)
SELECT
    t.adult_id, t.age, t.occupation, t.hours_per_week,
    ROUND(((t.hours_per_week - s.avg_h) / NULLIF(s.sd_h,0))::NUMERIC, 2) AS z_score
FROM hw3_adult_clean AS t
CROSS JOIN stats AS s
WHERE s.sd_h > 0
  AND ABS(t.hours_per_week - s.avg_h) > 3 * s.sd_h
ORDER BY ABS(t.hours_per_week - s.avg_h) DESC, t.adult_id
LIMIT 10;
