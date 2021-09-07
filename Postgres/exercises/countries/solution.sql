SELECT country, COUNT(*) AS repeats 
FROM user_country GROUP BY country HAVING COUNT(*) > 2
ORDER BY country;
