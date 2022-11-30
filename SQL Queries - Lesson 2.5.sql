USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.

SELECT * 
FROM actor;

SELECT *
FROM actor WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?

SELECT *
FROM rental;

SELECT
(SELECT COUNT(*) FROM rental
WHERE DATE(return_date) >= DATE(rental_date)) AS "available",
(SELECT COUNT(*) FROM rental
WHERE return_date IS NULL) AS "rented";

-- We found out that the rows with Null values are supposed to be the rented films (183), 
-- and we assume that the films that has the return date and time are available for rent (15861). 

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT * 
FROM film;

SELECT MIN(LENGTH), MAX(LENGTH)
FROM film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?

SELECT AVG(length)
FROM film;

SELECT 
SEC_TO_TIME(ROUND(AVG(length*60),0)) AS "average" 
FROM film;

-- 5.How many distinct (different) actors' last names are there?

SELECT *
FROM actor;

SELECT 
COUNT(DISTINCT last_name) AS distinct_surnames 
FROM actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?

SELECT *
FROM rental;

SELECT 
DATEDIFF(MAX(return_date), MIN(rental_date)) AS 'operating days'
FROM rental;

-- Here I understand the operating period as the time while they were actually renting films, 
-- so I just calculate the Dif between the last day they received a rented film and the first day they rented one.  

-- 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT *,
MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS weekday 
FROM rental LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT *, MONTHNAME(rental_date) AS month, 
DAYNAME(rental_date) AS weekday,
CASE
WHEN DAYNAME(rental_date)
IN ('Saturday', 'Sunday')
THEN 'Weekend' 
ELSE 'Weekday'
END
AS day_type FROM rental;

-- 9. Get release years.

SELECT * 
FROM film;

SELECT DISTINCT release_year 
FROM film;

-- 10. Get all films with ARMAGEDDON in the title.

SELECT * 
FROM film 
WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.

SELECT * 
FROM film 
WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films.

SELECT title, length 
FROM film 
ORDER BY length 
DESC LIMIT 10;

-- 13. How many films include Behind the Scenes content?

SELECT COUNT(title) 
FROM film 
WHERE special_features 
LIKE '%Behind the Scenes%';