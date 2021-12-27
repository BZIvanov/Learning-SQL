SELECT * 
FROM (
	SELECT 
		c.*,
		rank() OVER(PARTITION BY department ORDER BY salary DESC) as ranking
	FROM company AS c
) AS r
WHERE r.ranking <= 2;
