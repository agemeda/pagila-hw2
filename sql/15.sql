/*
 * Compute the total revenue for each film.
 */

select title, COALESCE(sum(payment.amount), 0.00) as revenue from film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
group by 1
order by 2 desc;
