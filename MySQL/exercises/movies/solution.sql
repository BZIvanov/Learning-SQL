-- Task 1
SELECT title, rating FROM series
JOIN reviews ON series.id = reviews.series_id
LIMIT 10;

-- Task 2
SELECT 
	title, 
    round(avg(rating), 2) AS avg_rating
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY series.id ORDER BY avg_rating;

-- Task 3
SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

-- Task 4
SELECT first_name,
   last_name,
   Count(rating) AS count,
   Ifnull(Min(rating), 0) AS min,
   Ifnull(Max(rating), 0) AS max,
   Round(Ifnull(Avg(rating), 0), 2) AS avg_rating,
   IF(Count(rating) > 0, 'ACTIVE', 'INACTIVE') AS status
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

-- Task 5
SELECT
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewer
FROM reviewers
INNER JOIN reviews ON reviewers.id = reviews.reviewer_id
INNER JOIN series ON series.id = reviews.series_id
ORDER BY title LIMIT 10;
