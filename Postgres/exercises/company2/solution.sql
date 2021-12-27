SELECT 
	c.*,
	row_number() OVER() as global_row,
	row_number() OVER(PARTITION BY department ORDER BY employee) as department_row
FROM company AS c;
