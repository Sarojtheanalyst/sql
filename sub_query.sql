use sipalaya;
-- sub query 
select * from movies limit 10;

 -- depoendent subquery 
-- 1 ) find the detail of the movie with the highest score 
select * from movies where score=(select max(score) from movies);

-- independent subquery (scalar subquery) -- return the one values 

-- 2) find the movies with the highest profit 
select * from movies where (gross-budget)=(select max(gross-budget)
                  from movies);
                  
-- Alternatives (faster ) 
select * from movies order by (gross-budget) desc limit 1;


/* 3) find how kany movies have a reting greater than the averager of all movies 
 ratings (find the count of the above average movies )  */
 select count(*) as 'No_of_mov' from movies where score>
        (select avg(score) from  movies);

-- see the details of the movies 
select *  from movies where score>
        (select avg(score) from  movies) order by score desc;

/* 4 )find the highest rated movies in 2000  */

select * from movies where year=2000 and score=(select max(score)
       from movies where year=2000);

/* 5) find the highest rated movie among all movies whose number of votes
   are greater than the datasets avgt votes */
   
select * from movies where score=(select max(score) from movies
      where votes>(select avg(votes) from movies));


-- Independent Subquery 
-- find the all users who never orderes 

/* 2) find all the movies made by top 3 directors (in terms of total gross income)*/

-- this will provide the top 3 director with the most gross 
select director,sum(gross) as 'gross' from movies group by director order by sum(gross) desc limit 3;

-- not supported by the sql 
select * from movies where director in (
    select director,sum(gross) as 'gross' from movies group by director order by sum(gross) desc limit 3);

-- supported query 
with top_directors as (select director from movies
 group by director order by sum(gross) desc limit 3)

select * from movies where director in(select * from top_directors);

-- count the number of the movies made by the top 3 directors
with top_directors as (select director from movies
 group by director order by sum(gross) desc limit 3)
select count(*) as 'No of Movies' from movies 
            where director in(select * from top_directors);
-- we have to select the temporary table 

-- layered subquery 
/* find all the movies of all those actors whose filmography avg ratrings >8.5
     (take 25000 vote as cut off ) */
     

select star, avg(score) as 'avgs' from movies where votes>25000 group by star  having avgs > 8.5 order by avgs desc ;

-- main query -- this is more complexirty query 
select * from movies where star in (select star  from movies where votes>25000 group by 
        star  having avg(score) > 8.5 );


select * from movies limit 10;  -- director , star , writer , director 

-- aldternative query 
SELECT m1.* 
FROM movies m1
JOIN (
    SELECT star
    FROM movies
    WHERE votes > 25000
    GROUP BY star
    HAVING AVG(score) > 8.5
) AS filtered_stars ON m1.star = filtered_stars.star;

-- roberto benigini , eljah wood , daveigh chase
 
-- find the distinct of the actors  to verfiy the datas 
select distinct(star) from 
( SELECT m1.* 
FROM movies m1
JOIN (
    SELECT star
    FROM movies
    WHERE votes > 25000
    GROUP BY star
    HAVING AVG(score) > 8.5
) AS filtered_stars ON m1.star = filtered_stars.star) as mov;

-- independent subquery -> table subquery (mukti colm and multi rows )

-- 1) find the most profitable movie of each years 

select * from movies where (year, gross-budget) in (
  select year, max(gross-budget) from movies group by year) order by year desc;

-- same query between 1980 to 2000 and order by the ratings 
select * from movies where year between 1990 and 1995 and  (year, gross-budget) in (
  select year, max(gross-budget) from movies group by year) order by score desc;
  
/* find the highest rated movies of each genre votes cot off 25000 */ -- complexity
select * from movies where (genre,score) in (
select genre,max(score) from movies where votes>25000 group by genre)
and votes>25000;

select genre,max(score) from movies where votes>25000 group by genre;
    
-- alternate codes 
SELECT m1.* 
FROM movies m1
JOIN (
    SELECT genre, MAX(score) AS max_score
    FROM movies 
    WHERE votes > 25000 
    GROUP BY genre
) AS subquery ON m1.genre = subquery.genre AND m1.score = subquery.max_score
WHERE m1.votes > 25000;

/* find the highest grossing movies of top 5 actor/director combo in terms of total
  gross income */
select star, director , max(gross) as 'max',sum(gross) as 'sums' from movies
    group by star,director order by sum(gross) desc limit 5;

with top_duos as (
select star, director , max(gross) as 'max' from movies
    group by star,director order by sum(gross) desc limit 5)
select * from movies where (star,director,gross) in(select * from top_duos);

-- alternate 
select star, director , sum(gross) , max(gross) from movies 
  group by star, director  order by sum(gross) desc limit 5;


-- correlated subquery 
/* find the movie that have a rating higher than the average rating of movies
  in the same genre */
-- more complexity !!!!!!!!!!!!!!!!!!!!!!!!!
select * from movies m1 where score>(select avg(score) from movies 
   m2 where m2.genre=m1.genre);

select avg(score) from movies  where genre='Action';
select avg(score) from movies  where genre='Comedy';

-- usage of select in the select 
/* get the percentage of the votes for each movie compared to the total number of the votes*/

select name,(votes/(select sum(votes) from movies)*100) as 'votes' from movies;
-- find the top 5 movies of highest votes in all the datasets 
select name,(votes/(select sum(votes) from movies)*100) as 'votes' from movies order by votes desc;

-- find the contribution from each generes

select name,genre,(votes/(select sum(votes) from movies)*100) as 'votes' from movies 
 where genre='Drama' order by votes desc ;
 
-- demonstrates 
select * from movies where score=(select max(score) from movies);

-- display all movies , genre, score and avg(score) of the genre 
select name, genre, score, (select avg(score) from movies) from movies;

-- display all the genre average scores
select name, genre,score ,(select avg(score) from movies m1 where m1.genre=m2.genre)
 from movies m2;

-- verify the query 
select name, genre,score ,(select avg(score) from movies m1 where m1.genre=m2.genre)
 from movies m2 where m2.genre='Action';

-- subquery in the having query 
/* find the genres having average(score)> avg(score) of all the movies */

select genre, avg(score) from movies group by genre having avg(score)
   > (select avg(score) from movies);


select * from movies limit 10;
