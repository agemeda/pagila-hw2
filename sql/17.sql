/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT rank, title, revenue, SUM(revenue) OVER (ORDER BY rank) AS "total revenue" 
FROM (
    SELECT RANK() OVER (ORDER BY revenue DESC) as rank, title, revenue from(
        SELECT film.title,
        COALESCE(SUM(payment.amount), 0.00) as revenue from film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
        LEFT JOIN payment USING (rental_id)
        group by film.title
    ) as subquery
) as outerquery
order by revenue desc, title;

