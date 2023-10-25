SELECT first_name, 
  Ifnull(Avg(grade), 0) AS average, 
  CASE 
    WHEN Avg(grade) IS NULL THEN 'FAILING' 
    WHEN Avg(grade) >= 75 THEN 'PASSING' 
    ELSE 'FAILING' 
  END AS passing_status 
FROM students 
  LEFT JOIN papers ON students.id = papers.student_id 
GROUP BY students.id 
ORDER BY average DESC;
