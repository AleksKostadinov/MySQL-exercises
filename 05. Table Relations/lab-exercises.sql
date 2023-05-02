# Mountains and Peaks
CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);

# Trip Organization
SELECT 
    `driver_id`,
    `vehicle_type`,
    CONCAT(`first_name`, ' ', `last_name`) AS `driver_name`
FROM
    `vehicles`
        JOIN
    `campers` ON `vehicles`.`driver_id` = `campers`.`id`;

# SoftUni Hiking
SELECT 
    `starting_point` AS `route_starting_point`,
    `end_point` AS `route_ending_point`,
    leader_id,
    CONCAT_WS(' ', `first_name`, `last_name`) AS `leader_name`
FROM
    `routes`
        JOIN
    `campers` ON `routes`.`leader_id` = `campers`.`id`;

# Delete Mountains
CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45)
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45),
    `mountain_id` INT,
    CONSTRAINT `fk_p_m` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
        ON DELETE CASCADE
);

# Project Management DB
CREATE TABLE `clients` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `client_name` VARCHAR(100)
);

CREATE TABLE `projects` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `client_id` INT(11),
    `project_leader_id` INT(11)
);

CREATE TABLE `employees` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30),
    `project_id` INT(11)
);

ALTER TABLE `projects`
ADD CONSTRAINT `fk_projects_clients`
FOREIGN KEY (`client_id`)
REFERENCES `clients`(`id`),
ADD CONSTRAINT `fk_projects_employees`
FOREIGN KEY (`project_leader_id`)
REFERENCES `employees`(`id`);

ALTER TABLE `employees`
ADD CONSTRAINT `fk_employees_projects`
FOREIGN KEY (`project_id`)
REFERENCES `projects`(`id`);
