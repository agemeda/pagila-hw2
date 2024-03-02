/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */


SELECT DISTINCT title
FROM film WHERE RATING = 'G'
AND 'Trailers' IN (
    SELECT unnest(special_features)
    FROM film
    AS trailer
    WHERE trailer.film_id = film.film_id
)
ORDER BY title;
