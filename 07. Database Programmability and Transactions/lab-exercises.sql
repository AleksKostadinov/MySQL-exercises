# Count Employees by Town

SELECT COUNT(*) AS "count" FROM `employees` AS e
JOIN `addresses` AS a ON a.`address_id` = e.`address_id`
JOIN `towns` AS t ON t.`town_id` = a.`town_id`
WHERE t.`name` = "Sofia";

# Count Employees by Town (a solution to Judge system)

CREATE FUNCTION `ufn_count_employees_by_town`(`town_name` VARCHAR(50))
	RETURNS INT
	DETERMINISTIC
BEGIN
	DECLARE `employee_count` INT;
    
    SET `employee_count` := (SELECT COUNT(`employee_id`)
    FROM `employees` AS e
    JOIN `addresses` AS a USING (`address_id`)
    JOIN `towns` AS t USING (`town_id`)
    WHERE t.`name` = `town_name`);
    
    RETURN `employee_count`;

END;

# Count Employees by Town (a second solution to Judge system)

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
	RETURNS INT 
	DETERMINISTIC

BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(employee_id) 
		FROM employees AS e
		JOIN addresses AS a ON a.address_id = e.address_id
		JOIN towns AS t ON t.town_id = a.town_id
		WHERE t.name = town_name);
	RETURN e_count;
END;

# Count Employees by Town

DELIMITER $$
CREATE FUNCTION `ufn_count_employees_by_town` (`town_name` VARCHAR(20))
	RETURNS INT
	DETERMINISTIC

BEGIN
	RETURN (SELECT COUNT(*) 
		FROM `employees` AS e
        JOIN `addresses` AS a USING (`address_id`)
        JOIN `towns` AS t USING (`town_id`)
        WHERE t.`name` = `town_name`);
END $$
DELIMITER ;

SELECT ufn_count_employees_by_town('Sofia');


# Employees Promotion

SELECT * from employees as a
join departments as d on a.department_id = d.department_id
where d.`name` = "Finance"; 

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))

BEGIN
	UPDATE employees
		JOIN departments USING(department_id)
        SET salary = salary * 1.05
        WHERE `name` = department_name; 
END $$
DELIMITER ;

CALL usp_raise_salaries('Finance');

DROP PROCEDURE usp_raise_salaries;


# Employees Promotion by ID (1st solution)

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
 
BEGIN
	IF((SELECT COUNT(*) FROM employees WHERE employee_id = id) > 0)
		THEN
			UPDATE employees
			SET salary = salary * 1.05
			WHERE employee_id = id;
	END IF;

END $$
DELIMITER ;


# Employees Promotion by ID (2nd solution)

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
 
BEGIN

	START TRANSACTION;
	IF((SELECT COUNT(*) FROM employees WHERE employee_id = id) <> 1)
		THEN ROLLBACK;
	ELSE
		UPDATE employees
		SET salary = salary * 1.05
		WHERE employee_id = id;
	END IF;
    
END $$
DELIMITER ;


# Triggered
CREATE TABLE deleted_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE
);

DELIMITER $$

CREATE TRIGGER tr_deleted_employees
	AFTER DELETE
	ON employees
	FOR EACH ROW

BEGIN
	INSERT INTO deleted_employees(first_name, last_name, middle_name, 
    job_title, department_id, salary)
    VALUES (OLD.first_name,OLD.last_name,OLD.middle_name,
		    OLD.job_title,OLD.department_id,OLD.salary);
END $$

DELIMITER ;

DELETE FROM employees WHERE employee_id IN (1);
