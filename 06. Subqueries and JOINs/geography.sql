# Highest Peaks in Bulgaria

SELECT 
    c.`country_code`,
    m.`mountain_range`,
    p.`peak_name`,
    p.`elevation`
FROM
    `peaks` AS p
        JOIN
    `mountains` AS m ON p.`mountain_id` = m.`id`
        JOIN
    `mountains_countries` AS c ON m.`id` = c.`mountain_id`
WHERE
    c.`country_code` = 'BG'
        AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

# Count Mountain Ranges

SELECT c.`country_code`, COUNT(m.`mountain_range`) AS `mountain_range`
FROM `mountains` AS m
JOIN `mountains_countries` AS c ON m.`id` = c.`mountain_id`
WHERE c.`country_code` IN ('BG' , 'RU', 'US')
GROUP BY c.`country_code`
ORDER BY `mountain_range` DESC;

# Countries with Rivers
SELECT c.`country_name`, r.`river_name`
FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON r.`id` = cr.`river_id`
WHERE c.`continent_code` = 'AF'
ORDER BY c.`country_name`
LIMIT 5;

# Continents and Currencies

SELECT c.continent_code, c.currency_code, COUNT(*) AS 'currency_usage'
FROM countries AS c
GROUP BY c.continent_code, c.currency_code
HAVING currency_usage > 1 AND currency_usage = (
	SELECT COUNT(*) AS cn
	FROM countries AS c2
	WHERE c2.continent_code = c.continent_code
	GROUP BY c2.currency_code
	ORDER BY cn DESC
	LIMIT 1
)
ORDER BY c.continent_code , c.continent_code;

# Countries Without Any Mountains

SELECT COUNT(c.`country_code`) AS "country_count"
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE m.`id` IS NULL;

# Highest Peak and Longest River by Country

SELECT c.`country_name`, 
MAX(p.`elevation`) AS 'highest_peak_elevation',
MAX(r.`length`) AS 'longest_river_length'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `peaks` AS p ON mc.`mountain_id` = p.`mountain_id`
LEFT JOIN `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON cr.`river_id` = r.`id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;
