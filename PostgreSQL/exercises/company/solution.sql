-- OVER is a window function, if we provide parameters to it, it will create windows depending on the parameters, otherwise we will get global window for all rows
SELECT c.*, max(salary) OVER(PARTITION BY department) as max_salary
FROM company AS c;
