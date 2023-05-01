SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = "The";

SELECT `title` FROM `books`
WHERE LOCATE("The", `title`) = 1;

SELECT REPLACE(`title`, "The", "***") AS `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = "The";

SELECT ROUND(SUM(`cost`), 2) FROM `books`;

SELECT CONCAT_WS(" ", `first_name`, `last_name`) AS "Full Name",
TIMESTAMPDIFF(DAY, `born`, `died`) AS  "Days Lived" FROM `authors`;

SELECT `title` FROM `books` WHERE `title` LIKE "Harry Potter%";

SELECT `title` FROM `books` WHERE REGEXP_LIKE(`title`, "Harry Potter") = 1;
