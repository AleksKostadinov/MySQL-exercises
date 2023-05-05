# Insert

INSERT INTO actors (first_name, last_name, birthdate, height, awards, country_id)
SELECT 
	REVERSE(first_name),
	REVERSE(last_name),
	DATE_SUB(birthdate, INTERVAL 2 DAY),
	height + 10,
	country_id,
	(SELECT id FROM countries WHERE name = "Armenia")
FROM actors AS a
WHERE a.id <= 10;

# Update

UPDATE movies_additional_info
SET runtime = runtime - 10
WHERE id BETWEEN 15 AND 25;

# Delete
DELETE countries FROM countries
	LEFT JOIN movies ON movies.country_id = countries.id
WHERE movies.id IS NULL;
