# Managers

SELECT d.`manager_id` AS "employee_id", 
CONCAT(e.`first_name`, " ", e.`last_name`) AS "full_name",
d.`department_id`, 
d.`name` AS "department_name"
FROM `departments` as d
JOIN `employees` as e
ON d.`manager_id` = e.`employee_id`
ORDER BY e.`employee_id`
LIMIT 5;

# Towns Addresses

SELECT t.`town_id`, t.`name` AS `town_name`, a.`address_text` 
FROM `towns` AS t
JOIN `addresses` AS a
ON a.`town_id` = t.`town_id`
WHERE t.`name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.`town_id`, a.`address_id`;

# Employees Without Managers

SELECT `employee_id`, `first_name`, `last_name`, `department_id`, `salary`
FROM `employees`
WHERE `manager_id` IS NULL;

# Higher Salary

SELECT COUNT(*) AS "count"
FROM `employees`
WHERE `salary` > (
	SELECT AVG(`salary`) 
    FROM `employees`
);
