/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT last_name, first_name
FROM actor
LEFT JOIN customer using (first_name, last_name) 
WHERE customer.last_name IS NULL AND customer.first_NAME is NULL
ORDER BY last_name, first_name;

