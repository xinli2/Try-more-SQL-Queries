--1) List the movieid value of movie Titanic.

select MOVIEID from MOVIE where TITLE ='Titanic';

--2) List the actorid value of actor Kevin Bacon.
select ACTORID from ACTOR where name = 'Kevin Bacon';


--3) List the average movie score in the movie database
select avg(score) from movie ;

--4) List the title of movies that have scores greater than the average score in the movie database
select title from movie where score > (select avg(score) from movie);

--5) List the names of actors who were cast in movie with movieid = 4
select name from actor where actorid in (select actorid from casting where movieid = 4);


-- 6) List the titles of movies that cast the actor Kevin Bacon.
select title from movie where movieid in (
  select movieid from casting where actorid = (
    select actorid from actor where name = 'Kevin Bacon'
  )
);
-- 7) List the actorid values of actors that were cast in any movie that has votes between 3000 and 4000.
select actorid from casting where movieid in (
  select movieid from movie where votes between 3000 and 4000
);
-- 8) List the names of actors, if any, that were cast in any movie that has votes between 3000 and 4000.
select name from actor where actorid in (
  select actorid from casting where movieid in (
    select movieid from movie where votes between 3000 and 4000
  )
);

-- 9) List the titles of movies that have a higher score than some movie in the database. (Don’t hardcode “some” movie as any specific movie such as “Titanic”. )
select title from movie where score > (select avg(score) from movie);


--10)  List the highest score of movies in the database
select max(score) from movie;

--11) List the titles of movies that have the highest score in the database.
select title from movie where score = (select max(score) from movie);

--12) Find the IDs of actors who were cast in more than one movie.
select actorid from (
  select actorid,count(movieid) as n from casting group by actorid
) where n > 1;

--13) List the titles of movies that have a cast of more than 5 actors.
select title from movie  where movieid in ( 
  select movieid from (
    select movieid, count(actorid) as n from casting group by movieid
  ) where n > 5
);
--14) For each year, list the best score held by the movies made in that year.
select year,max(score) from movie group by year;

--15) For each year, list the title of the movie with the most votes.
select year,max(votes) from movie group by year;

--16) List the titles of both the movie with the highest score and the movie with the second highest score.
select title from movie where movieid in (
  select movieid from (
      select movieid , max(score) as s from movie   group by movieid order by s desc 
    ) where ROWNUM <= 2
);

--17 Arnold Schwarzenegger was cast in many movies. In some years he was cast in two or more movies. For each year in which he was cast in at least two different movies, list the year and the number of movies in which he was a cast member.

select year, count(movieid) from movie where movieid in (
    select movieid from casting where actorid  = (select actorid from actor where name = 'Arnold Schwarzenegger')
) group by year;

--18) List the names of actors, if any, that were cast in all the movies that have votes between 3000 and 4000.
select name from actor where actorid in (
  select actorid from casting where movieid in (
    select movieid from movie where votes between 3000 and 4000
  )
);

-- 19) List the names of actors that have appeared in more than ten movies.
select name from actor where actorid in (
  select actorid from (
      select ACTORID, count(movieid) as n from casting group by ACTORID
    ) where n > 10
);
--20) From among the actors that have appeared in more than ten movies, list their name and the average score of all the movies they were cast in.
select b.actorid,avg(score) from movie a,
(
    select actorid,movieid  from casting where actorid in (
        select actorid from (
              select ACTORID, count(movieid) as n from casting group by ACTORID
            ) where n > 10
        )
) b where b.movieid = a.movieid group by actorid ;