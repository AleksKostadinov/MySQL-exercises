# Employees with Salary Above 35000
DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
    SELECT first_name, last_name FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name, employee_id;
END $$


# Employees with Salary Above Number
DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above(target_salary DECIMAL (19, 4))
BEGIN 
	SELECT first_name, last_name FROM employees
    WHERE salary >= target_salary
    ORDER BY first_name, last_name, employee_id;
END $$

# Town Names Starting With
DELIMITER $$

CREATE PROCEDURE usp_get_towns_starting_with(starting_text VARCHAR(50))
BEGIN
	SELECT `name` FROM towns
    WHERE `name` LIKE CONCAT(starting_text, "%")
    ORDER BY `name`;
END $$

# Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(searched_town VARCHAR(50))
BEGIN
	SELECT first_name, last_name FROM employees
    JOIN addresses AS a USING (address_id)
    JOIN towns AS t USING (town_id)
    WHERE t.`name` = searched_town
    ORDER BY first_name, last_name;
END $$

# Salary Level Function v.1
DELIMITER $$

CREATE FUNCTION ufn_get_salary_level(salary_of_employee DECIMAL (19,4))
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
	DECLARE salary_level VARCHAR(20);
		IF salary_of_employee < 30000 THEN
			SET salary_level = "Low";
		ELSEIF salary_of_employee BETWEEN 30000 AND 50000 THEN
			SET salary_level = "Average";
		ELSE
			SET salary_level = "High";
		END IF;
    RETURN salary_level;

END $$

# Salary Level Function v.2

CREATE FUNCTION ufn_get_salary_level(salary_of_employee DECIMAL (19,4))
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
	DECLARE salary_level VARCHAR(20);
		SET `salary_Level` :=
            CASE
                WHEN `salary_data` < 30000 THEN 'Low'
                WHEN `salary_data` BETWEEN 30000 AND 50000 THEN 'Average'
                ELSE 'High'
			END;
    RETURN `salary_Level`;
END $$

# Employees by Salary Level v.1
DELIMITER $$

CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(50))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE ufn_get_salary_level (salary) = salary_level
	ORDER BY first_name DESC, last_name DESC;
        
END $$

# Employees by Salary Level v.2
DELIMITER $$

CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(50))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE CASE 
		WHEN salary_level = "low" THEN  salary < 30000
        WHEN salary_level = "average" THEN  salary BETWEEN 30000 AND 50000
        WHEN salary_level = "high" THEN salary > 50000
        END
	ORDER BY first_name DESC, last_name DESC;
END $$

# Define Function
DELIMITER $$

CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC

BEGIN
	RETURN word REGEXP(CONCAT("^[", set_of_letters, "]+$"));
END $$
