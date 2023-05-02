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