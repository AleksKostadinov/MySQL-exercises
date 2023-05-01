# Find Names of All Employees by First Name
SELECT `first_name`, `last_name` FROM `employees`
WHERE `first_name` LIKE "Sa%"
ORDER BY `employee_id`;

# Find Names of All Employees by Last Name
SELECT `first_name`, `last_name` FROM `employees` 
WHERE `last_name` LIKE "%ei%"
ORDER BY `employee_id`;

# Find First Names of All Employees
SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) AND YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;


# Find All Employees Except Engineers
SELECT `first_name`, `last_name` FROM `employees` 
WHERE `job_title` NOT LIKE "%engineer%"
ORDER BY `employee_id`;


# Find Towns with Name Length
SELECT `name` FROM `towns`
WHERE char_length(`name`) = 5 OR char_length(`name`) = 6
ORDER BY `name`;

SELECT `name` FROM `towns`
WHERE LENGTH(`name`) IN (5, 6)
ORDER BY `name`;

# Find Towns Starting With
SELECT * FROM `towns`
WHERE 
`name` LIKE "M%" 
OR `name` LIKE "K%" 
OR `name` LIKE "B%" 
OR `name` LIKE "E%"
ORDER BY `name`;

SELECT `town_id`, `name`
FROM `towns`
WHERE UPPER(LEFT(`name`, 1)) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

#  Find Towns Not Starting With
SELECT `town_id`, `name`
FROM `towns`
WHERE UPPER(LEFT(`name`, 1)) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

SELECT * FROM `towns`
WHERE 
`name` NOT LIKE "R%" 
AND `name` NOT LIKE "B%" 
AND `name` NOT LIKE "D%"
ORDER BY `name`;

# Create View Employees Hired After 2000 Year
CREATE VIEW v_employees_hired_after_2000 AS
SELECT `first_name`, `last_name` FROM `employees`
WHERE YEAR(`hire_date`) > 2000;
SELECT * FROM v_employees_hired_after_2000;

# Length of Last Name
SELECT `first_name`, `last_name` FROM `employees`
WHERE LENGTH(`last_name`) = 5;
