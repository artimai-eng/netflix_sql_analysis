USE netflix_db;
SELECT * FROM netflix;

-- Q1] Count the number of Movies vs TV Shows 

SELECT DISTINCT(show_type),COUNT(*) FROM netflix
GROUP BY show_type;

-- Q2] Find the most common rating for movies and TV shows

SELECT show_type,rating FROM(SELECT show_type,
rating,
COUNT(*) as rating_count,
RANK() OVER(partition by show_type ORDER by COUNT(*) DESC) as ranking
FROM netflix
GROUP BY 1,2) as t
WHERE ranking=1 ;

-- Q3] List all movies released in a specific year (e.g., 2020)

SELECT title,release_year FROM netflix
WHERE show_type="Movie" and  release_year=2020;

-- Q4]  Identify the longest movie

SELECT title,CAST(duration AS unsigned) as movie_duration FROM netflix
WHERE show_type="Movie"
ORDER BY movie_duration DESC 
LIMIT 1;

-- Q5] Find content added in the last 5 years from this year(2025)

SELECT title,rating,duration,rating,release_year FROM netflix
WHERE YEAR(NOW())-release_year<=5
ORDER BY release_year;

-- Q6] Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT show_type,title FROM netflix
WHERE director LIKE "%Rajiv Chilaka%";

 -- COUNT OF THEM

SELECT DISTINCT(show_type),COUNT(1) AS total_production FROM netflix
WHERE director LIKE "%Rajiv Chilaka%"
GROUP by show_type;

-- Q7] List all TV shows with more than 5 seasons

SELECT title , duration, release_year FROM(SELECT * FROM netflix
WHERE duration LIKE "%Seasons%") as sub_table
WHERE  CAST(duration as unsigned)>5
ORDER BY release_year ;

-- Q8]  Find each year and the average numbers of content release in India on netflix. 
--      return top 5 year with highest avg content release!

SELECT YEAR(str_to_date(date_added,'%M %d, %Y')) AS year_added ,
ROUND(CAST(COUNT(*) AS DECIMAL(10,2))/(SELECT CAST(COUNT(*) AS DECIMAL(10,2)) FROM netflix where country LIKE "%India%")*100,2) AS show_count FROM netflix
WHERE country LIKE "%India%"
GROUP BY year_added
ORDER BY show_count DESC LIMIT 5;

-- Q9] List all movies that are documentaries

SELECT title,
duration FROM netflix
WHERE show_type="Movie" and listed_in LIKE '%Documentaries%';

-- Q10]  Find all content without a director
    -- count of them as well

SELECT show_type,title FROM netflix
WHERE director IS NULL;

-- count of them 

SELECT DISTINCT(show_type),COUNT(*) as total_show FROM netflix
WHERE director IS NULL
GROUP BY show_type;

-- Q11] Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT title,duration FROM netflix
WHERE cast LIKE '%Salman Khan%'
AND 2025-release_year<=10;

-- Q12]Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--     the description field. Label content containing these keywords as 'Bad' and all other 
--     content as 'Good'. Count how many items fall into each category.

WITH table1 as(SELECT *,
	CASE
	   WHEN show_description  LIKE '%kill%' or show_description LIKE '%violence%' THEN 'Bad'
	   ELSE 'Good'
	   END AS category
	FROM netflix) 
SELECT category,COUNT(*) as total_no FROM table1
GROUP BY category;
