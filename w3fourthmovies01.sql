#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/movie-database-exercise/basic-exercises-on-movie-database.php
#https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php

#https://www.w3resource.com/sql-exercises/movie-database-exercise/basic-exercises-on-movie-database.php
#1. Write a query in SQL to find the name and year of the movies.
select mov_title, mov_year
from movie;

#2. Write a query in SQL to find the year when the movie American Beauty released.
select mov_year
from movie
where mov_title = 'American Beauty';

#3. Write a query in SQL to find the movie which was released in the year 1999.
select *
from movie
where mov_year = 1999;

#4. Write a query in SQL to find the movies which was released before 1998.
select *
from movie
where mov_year < 1998;

#5. Write a query in SQL to return the name of all reviewers and name of movies together in a single list.
#official solution
select reviewer.rev_name
from reviewer
union
(select movie.mov_title
from movie);

#6. Write a query in SQL to find the name of all reviewers who have rated 7 or more stars to their rating.
select reviewer.rev_name
from reviewer, rating
where reviewer.rev_id = rating.rev_id
and rating.rev_stars >= 7;

#7. Write a query in SQL to find the titles of all movies that have no ratings.
select *
from movie
where mov_id not in (
	select mov_id
	from rating);

#8. Write a query in SQL to find the titles of the movies with ID 905, 907, 917.
select *
from movie
where mov_id in (905,907,917);

#9. Write a query in SQL to find the list of all those movies with year which include the words Boogie Nights.
select *
from movie
where year = (
	select year
	from movie
	where mov_title = 'Boogie Nights');

#10. Write a query in SQL to find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'.
select *
from actor
where act_fname = 'Woody'
and act_lname = 'Allen';

#https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php
#1. Write a query in SQL to list all the information of the actors who played a role in the movie 'Annie Hall'. 
select actor.*
from actor, movie_cast, movie
where actor.act_id = movie_cast.act_id
and movie_cast.mov_id = movie.mov_id
and movie.mov_title = 'Annie Hall';
#also
select *
from actor
where act_id in (
	select act_id
	from movie_cast
	where mov_id in (
		select mov_id
		from movie
		where mov_title = 'Annie Hall'));

#2. Write a query in SQL to find the name of the director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. (using subquery)
select *
from director
where dir_id in (
	select dir_id
	from movie_direction
	where mov_id in (
		select mov_id
		from movie
		where mov_title = 'Eyes Wide Shut'));

#3. Write a query in SQL to list all the movies which released in the country other than UK.
select *
from movie
where mov_rel_country <> 'mov_rel_country';

#4. Write a query in SQL to find the movie title, year, date of release, director and actor for those movies which reviewer is unknown.
select *
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_id in (
		select rev_id
		from reviewer
		where rev_name is null));

#5. Write a query in SQL to find the titles of all movies directed by the director whose first and last name are Woddy Allen.
select *
from movie
where mov_id in (	
	select mov_id
	from movie_direction
	where dir_id in (
		select dir_id
		from director
		where dir_fname = 'Woody'
		and dir_lname = 'Allen'));

#6. Write a query in SQL to find all the years which produced at least one movie and that received a rating of more than 3 stars. Show the results in increasing order.
select distinct mov_year
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_stars > 3)
order by mov_year;

#7. Write a query in SQL to find the titles of all movies that have no ratings.
select *
from movie
where mov_id not in (
	select mov_id
	from rating);

#8. Write a query in SQL to find the names of all reviewers who have ratings with a NULL value.
select *
from reviewer
where rev_id in (
	select rev_id
	from rating)
	where rev_stars is null);

#9. Write a query in SQL to return the reviewer name, movie title, and stars for those movies which reviewed by a reviewer and must be rated. Sort the result by reviewer name, movie title, and number of stars.
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer join rating
on reviewer.rev_id = rating.rev_id
join movie
on movie.mov_id = rating.mov_id
where movie.mov_id in (
	select mov_id
	from rating
	where rev_stars is not null
	and rev_id in (
		select rev_id
		from reviewer
		where rev_name is not null))
order by reviewer.rev_name, movie.mov_title, rating.rev_stars;
#official solution
select rev_name, mov_title, rev_stars 
from reviewer, rating, movie 
where reviewer.rev_id=rating.rev_id 
and movie.mov_id=rating.mov_id 
and reviewer.rev_name is not null 
and rating.rev_stars is not null
order by rev_name, mov_title, rev_stars;

#10. Write a query in SQL to find the reviewer's name and the title of the movie for those reviewers who rated more than one movies.
select reviewer.rev_name, movie.mov_title
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and reviewer.rev_name is not null
and rating.rev_id in (
	select rev_id
	from rating	
	group by rev_id
	having count(*) >= 2);

#11. Write a query in SQL to find the movie title, and the highest number of stars that movie received and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.  RM:  Post the movie title and it's highest rating.  It's not return the movie and its highest rating star separately.  Two tables joined using group by in one table.
select mov_title, max(rev_stars)
from movie, rating
where movie.mov_id = rating.mov_id
and rating.rev_stars is not null
group by movie.mov_title
order by mov_title;

#12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty.
select *
from reviewer
where rev_id in (
	select rev_id
	from rating
	where mov_id in (
		select mov_id
		from movie
		where mov_title = 'American Beauty'));

#13. Write a query in SQL to find the titles of all movies which have been reviewed by anybody except by Paul Monks.
select *
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_id not in (
		select rev_id
		from reviewer
		where rev_name = 'Paul Monks'));

#14. Write a query in SQL to return the reviewer name, movie title, and number of stars for those movies which rating is the lowest one.
select reviewer.rev_name, movie.mov_title, min(rating.rev_stars)
from reviewer join rating
on reviewer.rev_id = rating.rev_id
join movie
on rating.mov_id = movie.mov_id
and rating.rev_stars is not null
and reviewer.rev_name is not null
group by reviewer.rev_name, movie.mov_title;
#RM:  actually find the movie which has the lowest rating.  It's not list the revieweres, movies, and movie's lowest rating.  Confusing.
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer join rating
on reviewer.rev_id = rating.rev_id
join movie
on rating.mov_id = movie.mov_id
where movie.mov_id in (
	select mov_id
	from rating
	where rev_stars in (
		select min(rev_stars)
		from rating));

#15. Write a query in SQL to find the titles of all movies directed by James Cameron.
select *
from movie
where mov_id in (
	select mov_id
	from movie_direction
	where dir_id in (
		select dir_id
		from director
		where dir_fname = 'James'
		and dir_lname = 'Cameron'));

#16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies.
select *
from movie
where mov_id in (
	select mov_id
	from movie_cast
	where act_id in (
		select act_id
		from movie_cast
		group by act_id
		having count(act_id) >= 2));