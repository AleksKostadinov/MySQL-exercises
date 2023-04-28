CREATE DATABASE `Movies`;
-- USE `Movies`;
CREATE TABLE `directors` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

INSERT INTO `directors` (`director_name`, `notes`)
VALUES 
('Ivan', 'I\'m film director.'),
('Alex', 'I\'m film director.'),
('Pesho', 'I\'m film director.'),
('Gosho', 'I\'m film director.'),
('Tsvety', 'I\'m film director.');

CREATE TABLE `genres` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `genre_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

INSERT INTO `genres` (`genre_name`, `notes`)
VALUES 
('Action', 'This is a movie genre.'),
('Thriller', 'This is a movie genre.'),
('Romantic', 'This is a movie genre.'),
('Horror', 'This is a movie genre.'),
('Comedy', 'This is a movie genre.');

CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

INSERT INTO `categories` (`category_name`, `notes`)
VALUES 
('Adults', 'This is a movie category.'),
('Kids', 'This is a movie category.'),
('Teens', 'This is a movie category.'),
('Series', 'This is a movie category.'),
('Other', 'This is a movie category.');

CREATE TABLE `movies` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(30) NOT NULL,
    `director_id` INT NOT NULL,
    `copyright_year` INT,
    `length` DOUBLE,
    `genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE,
    `notes` TEXT
);

INSERT INTO `movies` (`title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`, `rating`, `notes`)
VALUES 
('Movie 1', 1, '2022', 2.15, 1, 1, 2, 'A great movie.'),
('Movie 2', 2, '2021', 2.10, 2, 2, 3, 'A great movie.'),
('Movie 3', 3, '2022', 2.42, 3, 3, 8, 'A great movie.'),
('Movie 4', 4, '2022', 1.57, 4, 4, 8, 'A great movie.'),
('Movie 5', 5, '2001', 3.36, 5, 5, 10, 'A great movie.');
