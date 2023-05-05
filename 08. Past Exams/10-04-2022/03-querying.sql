# Countries

SELECT * FROM countries
ORDER BY currency DESC, id;

# Old movies

SELECT m.id, m.title, runtime, budget, release_date FROM movies_additional_info AS ma
JOIN movies AS m ON m.movie_info_id = ma.id
WHERE YEAR(release_date) BETWEEN 1996 AND 1999
ORDER BY runtime, ma.id
LIMIT 20;

# Movie casting

SELECT 
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    CONCAT(REVERSE(last_name),
            CHAR_LENGTH(last_name),
            '@cast.com') AS email,
            2022 - YEAR(birthdate) AS age,
            height
FROM actors AS a
LEFT JOIN movies_actors AS ma ON ma.actor_id = a.id
WHERE ma.movie_id IS NULL
ORDER BY height;

# International festival

SELECT 
    c.name, COUNT(m.country_id) AS movies_count
FROM
    countries AS c
        JOIN
    movies AS m ON m.country_id = c.id
GROUP BY c.id
HAVING movies_count >= 7
ORDER BY c.name DESC;

# Rating system

SELECT 
m.title, 
	(CASE
		WHEN ma.rating <= 4 THEN "poor"
		WHEN ma.rating <= 7 THEN "good"
		WHEN ma.rating > 7 THEN "excellent"
    END) AS rating, 
IF (has_subtitles, "english", "-") AS subtitles, 
budget 
FROM movies_additional_info AS ma
JOIN movies AS m ON m.movie_info_id = ma.id
ORDER BY budget DESC;
