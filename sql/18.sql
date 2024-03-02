/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

select rank, title, revenue, "total revenue", TO_CHAR((100*"total revenue")/sum(revenue) OVER (), 'FM900.00') AS "percent revenue" from (
    select rank, title, revenue, sum(revenue) over (order by revenue desc) as "total revenue"
    from (
        select RANK () OVER (order by COALESCE("sum", 0.00) DESC) as rank, title, COALESCE("sum", 0.00) as revenue
        from (
            select film.title, sum(payment.amount) from film
            LEFT JOIN inventory USING (film_id)
            LEFT JOIN rental USING (inventory_id)
            LEFT JOIN payment USING (rental_id)
            group by title
        ) subq
       ) subq2
) subq3
order by revenue desc, title;
