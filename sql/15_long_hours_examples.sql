-- Які 10 прикладів респондентів віком 25–45 років із вищою освітою
-- або керівною роботою мають найбільше робочих годин серед тих, хто працює не менше ніж 40 годин?
-- Але ще прибрав 99 як нерелевантну
SELECT
    adult_id, age, education, occupation, hours_per_week, income_over_50k
FROM hw3_adult_clean
WHERE age BETWEEN 25 AND 45
  AND (education IN ('Bachelors', 'Masters') OR occupation = 'Exec-managerial')
  AND NOT (hours_per_week < 40) AND hours_per_week < 99
ORDER BY hours_per_week DESC, adult_id
LIMIT 10;
