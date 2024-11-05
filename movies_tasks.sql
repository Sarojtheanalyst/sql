-- subquery
use sipalaya;

select * from movies limit 10;

select COUNT(*) from movies;

-- distinct keyword  find the distinct genre of the movies

select DISTINCT(genre) as 'generes' from movies;
-- find the total nuymber of the different genre
select COUNT(DISTINCT(GENRE)) as 'no of genre' from movies;

-- subquery (find all the movies that have the rating greater than the average
select name,genre,year,score from movies where score>(select avg(score) from movies) order by score desc;

-- find the movies release between 2000 and 2014
select name ,genre, year , score from movies where year between 2001 and 2005;

-- list out the movies name start with Au
SELECT * FROM movies
WHERE name LIKE 'Au%';

-- window function rank(), row number() and dense rank()
SELECT name,score,genre,
    RANK() OVER (ORDER BY score DESC) AS movie_rank,
    dense_rank() over(ORDER BY score DESC) AS movies_dense_rank,
    row_number() over (order by score desc) as movies_rank FROM movies;



select avg(score) from movies;
