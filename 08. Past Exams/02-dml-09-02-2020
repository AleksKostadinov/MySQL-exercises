# Insert

INSERT INTO coaches (first_name, last_name, salary, coach_level)

SELECT first_name, last_name, salary, CHAR_LENGTH(first_name) AS coach_level
FROM players
WHERE age >= 45;

# Update

UPDATE coaches AS c
SET c.coach_level = c.coach_level + 1
WHERE 
	c.id IN(SELECT coach_id FROM players_coaches)
    AND first_name LIKE "A%";
    
# Delete

DELETE FROM players
WHERE age >= 45;
