-- Які унікальні комбінації education і education_num містяться в таблиці? Чи ці поля дублюють одну інформацію?
SELECT DISTINCT
    education,
    education_num
FROM hw3_adult_clean
ORDER BY education_num DESC, education
LIMIT 20;
