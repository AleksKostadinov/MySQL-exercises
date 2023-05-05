# Players
SELECT first_name, age, salary FROM players
ORDER BY salary DESC;

# Young offense players without contract
SELECT 
    p.id,
    CONCAT_WS(' ', first_name, last_name) AS 'full_name',
    p.age,
    p.position,
    p.hire_date 
FROM
    players AS p
        JOIN
    skills_data AS sd ON p.skills_data_id = sd.id
WHERE
    p.age < 23 
    AND sd.strength > 50
	AND p.hire_date IS NULL 
	AND p.position = "A"
ORDER BY salary , age;

# Detail info for all teams

SELECT 
t.name AS team_name,
t.established,
t.fan_base,
COUNT(p.id) AS players_count
FROM teams AS t
LEFT JOIN players AS p ON t.id = p.team_id
GROUP BY t.id
ORDER BY players_count DESC, fan_base DESC;

# The fastest player by towns

SELECT 
    MAX(sd.speed) AS max_speed, tw.name AS town_name
FROM
    skills_data AS sd
        RIGHT JOIN
    players AS p ON sd.id = p.skills_data_id
        RIGHT JOIN
    teams AS t ON t.id = p.team_id
        JOIN
    stadiums AS s ON s.id = t.stadium_id
        RIGHT JOIN
    towns AS tw ON tw.id = s.town_id
WHERE
    t.name != 'Devify'
GROUP BY tw.id
ORDER BY max_speed DESC, tw.name;

# Total salaries and players by country

SELECT 
c.name,
COUNT(p.id) AS total_count_of_players,
SUM(p.salary) AS total_sum_of_salaries
FROM countries AS c
LEFT JOIN towns AS tw ON c.id = tw.country_id
LEFT JOIN stadiums AS s ON s.town_id = tw.id
LEFT JOIN teams AS t ON t.stadium_id = s.id
LEFT JOIN players AS p ON p.team_id = t.id
GROUP BY c.id
ORDER BY total_count_of_players DESC, c.name;
