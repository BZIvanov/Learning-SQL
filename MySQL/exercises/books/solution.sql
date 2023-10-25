SELECT author_fname, author_lname,
  CASE 
    WHEN COUNT(*) = 1 THEN CAST('1 book' AS CHAR(10000) CHARACTER SET utf8)
    ELSE CONCAT(COUNT(*), ' books')
  END AS 'count'
FROM books 
GROUP BY author_lname, author_fname;
