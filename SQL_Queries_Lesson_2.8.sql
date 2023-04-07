USE sakila;
-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country FROM store as s
JOIN address as a
ON s.address_id = a.address_id
JOIN city as ci
ON a.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id;
-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(p.amount) as Business from store as s
JOIN inventory as i
on s.store_id = i.store_id
JOIN rental as r
on i.inventory_id = r.inventory_id
JOIN payment as p
on r.customer_id = p.customer_id
GROUP BY store_id;
-- Which film categories are longest?
select name, sum(length) as Duration from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id
GROUP BY name
ORDER BY Duration DESC;
-- Display the most frequently rented movies in descending order.
select title, count(*) from rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id = f.film_id
WHERE return_date IS NOT NULL
GROUP BY title
ORDER BY count(*) DESC;
-- List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as 'gross revenue' from inventory as i
JOIN rental as r
ON i.inventory_id = r.inventory_id
JOIN payment as p
on r.customer_id = p.customer_id
JOIN film as f
on i.film_id = f.film_id
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
GROUP BY c.name
ORDER BY 'gross revenue' aSC
LIMIT 5;
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, store_id, COUNT(*) AS copies FROM rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
group by title;
-- Get all pairs of actors that worked together.
SELECT DISTINCT CONCAT(ac.first_name, ' ', ac.last_name) AS 'First Actor', CONCAT(ac2.first_name, ' ', ac2.last_name) AS 'Second Actor' FROM actor AS ac
JOIN film_actor AS fa1 
ON ac.actor_id = fa1.actor_id
JOIN film_actor AS fa2 
ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
JOIN actor AS ac2 ON ac2.actor_id = fa2.actor_id
ORDER BY 'First Actor', 'Second Actor';
