# History movies
DELIMITER $$

CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
	RETURNS INT
    DETERMINISTIC
    
BEGIN
	DECLARE history_movies INT;
    SET history_movies := (
		SELECT COUNT(m.id) AS history_movies
        FROM actors AS a
			JOIN movies_actors AS ma ON a.id = ma.actor_id
			JOIN movies AS m ON ma.movie_id = m.id
			JOIN genres_movies AS gm ON m.id = gm.movie_id
			JOIN genres AS g ON gm.genre_id = g.id
			WHERE g.name = "History"
            AND CONCAT(first_name, " ", last_name) = full_name);
    
    RETURN history_movies;
END $$

DELIMITER ;

SELECT udf_actor_history_movies_count('Stephan Lundberg')  AS 'history_movies';

# Movie awards
DELIMITER $$

CREATE PROCEDURE udp_award_movie(movie_title VARCHAR(50))

BEGIN
	UPDATE actors
		JOIN movies_actors AS ma ON ma.actor_id = actors.id
		JOIN movies ON movies.id = ma.movie_id
    SET awards = awards + 1;
	-- WHERE title = movie_title;
END $$

DELIMITER ;

CALL udp_award_movie('Tea For Two');
