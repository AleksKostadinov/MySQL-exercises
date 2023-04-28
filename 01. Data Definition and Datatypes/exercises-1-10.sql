CREATE DATABASE `minions`;

USE `minions`;

CREATE TABLE `minions` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    age INT
);

CREATE TABLE `towns` (
	 town_id INT PRIMARY KEY AUTO_INCREMENT,
     name VARCHAR(255) NOT NULL
);

ALTER TABLE `minions`
ADD COLUMN `town_id` INT NOT NULL,
ADD CONSTRAINT fk_minions_towns  -- reference to PK / it's not necessary  
FOREIGN KEY (`town_id`)
REFERENCES `towns` (`id`);

INSERT INTO `minions` (`id`, `name`, `age`, `town_id`)
VALUES (1, "Kevin", 22, 1), (2, "Bob", 15, 3), (3, "Steward", NULL, 2);

INSERT INTO `towns` (`id`, `name`)
VALUES (1, "Sofia"), (2, "Plovdiv"), (3, "Varna");

TRUNCATE TABLE `minions`;

DROP TABLE `minions`;
DROP TABLE `towns`;

DROP DATABASE `minions`;

CREATE DATABASE `exercise`;

USE `exercise`;

CREATE TABLE `people` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DOUBLE,
    `weight` DOUBLE,
    `gender` CHAR(1) NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);

INSERT INTO `people` (`name`, `gender`, `birthdate`)
VALUES
	("Boris", "m", DATE(NOW())),
    ("Ivan", "m", DATE(NOW())),
    ("Alex", "m", DATE(NOW())),
    ("Pesho", "m", DATE(NOW())),
    ("Tsvety", "f", DATE(NOW()));

CREATE TABLE `users` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` TIME,
    `is_deleted` BOOLEAN
);

INSERT INTO `users` (`username`, `password`)
VALUES 
	("oris", "m1"),
    ("van", "m2"),
    ("lex", "1m"),
    ("esho", "2m"),
    ("svety", "1m1");
    
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD PRIMARY KEY pk_users (`id`, `username`);

ALTER TABLE `users`
MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW();

INSERT INTO `users` (`username`, `password`)
VALUES 
	("Moris", "momo");

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY `users` (`id`),
MODIFY COLUMN `username` VARCHAR(30) UNIQUE;
