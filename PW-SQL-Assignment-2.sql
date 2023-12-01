use mavenmovies;
-- Basic Aggregate Functions: 
-- Question 1: 
-- Retrieve the total number of rentals made in the Sakila database. 

select count(rental_id) as total_num_of_rentals from rental;

-- Question 2: 
-- Find the average rental duration (in days) of movies rented from the Sakila database.

select avg(datediff(return_date, rental_date)) as avg_rental_duration from rental;

-- String Functions: 
-- Question 3: 
-- Display the first name and last name of customers in uppercase. 

select upper(first_name), upper(last_name) from customer;

-- Question 4: 
-- Extract the month from the rental date and display it alongside the rental ID. 

select month(rental_date), rental_id from rental;

-- GROUP BY:
-- Question 5: 
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 

select customer_id, count(rental_id) as count_of_rentals from rental group by customer_id;

-- Question 6: 
-- Find the total revenue generated by each store. 

select store_id, sum(amount) as total_revenue 
from 
	payment
join  
	staff on payment.staff_id = staff.staff_id 
group by 
	store_id;

-- Joins:
-- Question 7:
-- Display the title of the movie, customer s first name, and last name who rented it. 

select title, first_name, last_name
from 
		film  
join 
		inventory on film.film_id = inventory.film_id 
join 
		rental on inventory.inventory_id = rental.inventory_id 
join 
    customer on rental.customer_id = customer.customer_id;

-- Question 8: 
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 

select first_name , last_name
from 
	actor 
join 
	film_actor on actor.actor_id = film_actor.actor_id 
join
	film on film_actor.film_id = film.film_id 
where 
	title = 'gone with the wind';

-- GROUP BY:
-- Question 1: 
-- Determine the total number of rentals for each category of movies. 

select 
	category_id, count(rental_id) as num_of_rentals 
from 
	rental 
join 
	inventory on rental.inventory_id = inventory.inventory_id 
join 
	film_category on inventory.film_id = film_category.film_id 
group by 
	category_id;
    
-- Question 2: 
-- Find the average rental rate of movies in each language. 

select avg(rental_rate), name 
from 
	language  
join 
	film  on language.language_id = film.language_id 
group by 
	name; 

-- Joins:
-- Question 3: 
-- Retrieve the customer names along with the total amount they've spent on rentals. 

select c.first_name, c.last_name, SUM(p.amount) AS total_amount
from 
	customer c
join 
	payment p on c.customer_id = p.customer_id
join 
	rental r on c.customer_id = r.customer_id
group by 
	c.customer_id;

-- Question 4: 
-- List the titles of movies rented by each customer in a particular city (e.g., 'London'). 

select f.title
from 
	film f 
join 
	inventory i on f.film_id = i.film_id 
join 
	rental r on i.inventory_id = r.inventory_id
join 
	customer c on r.customer_id = c.customer_id 
join 
	address a on c.address_id = a.address_id 
join 
	city t on a.city_id = t.city_id 
where 
	city = 'London'
group by
	f.film_id; 

-- Advanced Joins and GROUP BY: 
-- Question 5: 
-- Display the top 5 rented movies along with the number of times they've been rented. 

select f.title, count(rental_id) as num_of_times_rented
from 
	film f 
join 
	inventory i on f.film_id = i.film_id 
join 
	rental r on i.inventory_id = r.inventory_id 
group by 
	f.film_id
order by 
	num_of_times_rented desc
limit 5;

-- Question 6: 
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 

select c.first_name, c.last_name, c.customer_id
from 
	customer c
join 
	rental r on c.customer_id = r.customer_id
join 
	inventory i on r.inventory_id = i.inventory_id
where 
	c.store_id in (1,2)
group by 
	c.customer_id;
