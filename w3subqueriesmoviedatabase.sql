#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php

/*
Sample table: actor
act_id |      act_fname       |      act_lname       | act_gender
--------+----------------------+----------------------+------------
    101 | James                | Stewart              | M
    102 | Deborah              | Kerr                 | F
    103 | Peter                | OToole               | M
    104 | Robert               | De Niro              | M
    105 | F. Murray            | Abraham              | M
    106 | Harrison             | Ford                 | M
    107 | Nicole               | Kidman               | F
    108 | Stephen              | Baldwin              | M
    109 | Jack                 | Nicholson            | M
    110 | Mark                 | Wahlberg             | M
    111 | Woody                | Allen                | M
    112 | Claire               | Danes                | F
    113 | Tim                  | Robbins              | M
    114 | Kevin                | Spacey               | M
    115 | Kate                 | Winslet              | F
    116 | Robin                | Williams             | M
    117 | Jon                  | Voight               | M
    118 | Ewan                 | McGregor             | M
    119 | Christian            | Bale                 | M
    120 | Maggie               | Gyllenhaal           | F
    121 | Dev                  | Patel                | M
    122 | Sigourney            | Weaver               | F
    123 | David                | Aston                | M
    124 | Ali                  | Astin                | F

Sample table: movie_cast
act_id | mov_id |              role
--------+--------+--------------------------------
    101 |    901 | John Scottie Ferguson
    102 |    902 | Miss Giddens
    103 |    903 | T.E. Lawrence
    104 |    904 | Michael
    105 |    905 | Antonio Salieri
    106 |    906 | Rick Deckard
    107 |    907 | Alice Harford
    108 |    908 | McManus
    110 |    910 | Eddie Adams
    111 |    911 | Alvy Singer
    112 |    912 | San
    113 |    913 | Andy Dufresne
    114 |    914 | Lester Burnham
    115 |    915 | Rose DeWitt Bukater
    116 |    916 | Sean Maguire
    117 |    917 | Ed
    118 |    918 | Renton
    120 |    920 | Elizabeth Darko
    121 |    921 | Older Jamal
    122 |    922 | Ripley
    114 |    923 | Bobby Darin
    109 |    909 | J.J. Gittes
    119 |    919 | Alfred Borden

Sample table: movie
mov_id |                     mov_title                      | mov_year | mov_time |    mov_lang     | mov_dt_rel | mov_rel_country
--------+----------------------------------------------------+----------+----------+-----------------+------------+-----------------
    901 | Vertigo                                            |     1958 |      128 | English         | 1958-08-24 | UK
    902 | The Innocents                                      |     1961 |      100 | English         | 1962-02-19 | SW
    903 | Lawrence of Arabia                                 |     1962 |      216 | English         | 1962-12-11 | UK
    904 | The Deer Hunter                                    |     1978 |      183 | English         | 1979-03-08 | UK
    905 | Amadeus                                            |     1984 |      160 | English         | 1985-01-07 | UK
    906 | Blade Runner                                       |     1982 |      117 | English         | 1982-09-09 | UK
    907 | Eyes Wide Shut                                     |     1999 |      159 | English         |            | UK
    908 | The Usual Suspects                                 |     1995 |      106 | English         | 1995-08-25 | UK
    909 | Chinatown                                          |     1974 |      130 | English         | 1974-08-09 | UK
    910 | Boogie Nights                                      |     1997 |      155 | English         | 1998-02-16 | UK
    911 | Annie Hall                                         |     1977 |       93 | English         | 1977-04-20 | USA
    912 | Princess Mononoke                                  |     1997 |      134 | Japanese        | 2001-10-19 | UK
    913 | The Shawshank Redemption                           |     1994 |      142 | English         | 1995-02-17 | UK
    914 | American Beauty                                    |     1999 |      122 | English         |            | UK
    915 | Titanic                                            |     1997 |      194 | English         | 1998-01-23 | UK
    916 | Good Will Hunting                                  |     1997 |      126 | English         | 1998-06-03 | UK
    917 | Deliverance                                        |     1972 |      109 | English         | 1982-10-05 | UK
    918 | Trainspotting                                      |     1996 |       94 | English         | 1996-02-23 | UK
    919 | The Prestige                                       |     2006 |      130 | English         | 2006-11-10 | UK
    920 | Donnie Darko                                       |     2001 |      113 | English         |            | UK
    921 | Slumdog Millionaire                                |     2008 |      120 | English         | 2009-01-09 | UK
    922 | Aliens                                             |     1986 |      137 | English         | 1986-08-29 | UK
    923 | Beyond the Sea                                     |     2004 |      118 | English         | 2004-11-26 | UK
    924 | Avatar                                             |     2009 |      162 | English         | 2009-12-17 | UK
    926 | Seven Samurai                                      |     1954 |      207 | Japanese        | 1954-04-26 | JP
    927 | Spirited Away                                      |     2001 |      125 | Japanese        | 2003-09-12 | UK
    928 | Back to the Future                                 |     1985 |      116 | English         | 1985-12-04 | UK
    925 | Braveheart                                         |     1995 |      178 | English         | 1995-09-08 | UK
*/
#1. Write a query in SQL to list all the information of the actors who played a role in the movie 'Annie Hall'.
select *
from actor
where act_id = (
	select act_id
	from movie_cast
	where mov_id = (
		select mov_id
		from movie
		where mov_title = 'Annie Hall'));

/*
Sample table: director
dir_id |      dir_fname       |      dir_lname
--------+----------------------+----------------------
    201 | Alfred               | Hitchcock
    202 | Jack                 | Clayton
    203 | David                | Lean
    204 | Michael              | Cimino
    205 | Milos                | Forman
    206 | Ridley               | Scott
    207 | Stanley              | Kubrick
    208 | Bryan                | Singer
    209 | Roman                | Polanski
    210 | Paul                 | Thomas Anderson
    211 | Woody                | Allen
    212 | Hayao                | Miyazaki
    213 | Frank                | Darabont
    214 | Sam                  | Mendes
    215 | James                | Cameron
    216 | Gus                  | Van Sant
    217 | John                 | Boorman
    218 | Danny                | Boyle
    219 | Christopher          | Nolan
    220 | Richard              | Kelly
    221 | Kevin                | Spacey
    222 | Andrei               | Tarkovsky
    223 | Peter                | Jackson

Sample table: movie_direction
dir_id | mov_id
--------+--------
    201 |    901
    202 |    902
    203 |    903
    204 |    904
    205 |    905
    206 |    906
    207 |    907
    208 |    908
    209 |    909
    210 |    910
    211 |    911
    212 |    912
    213 |    913
    214 |    914
    215 |    915
    216 |    916
    217 |    917
    218 |    918
    219 |    919
    220 |    920
    218 |    921
    215 |    922
    221 |    923
*/
#2. Write a query in SQL to find the name of the director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. (using subquery)
select *
from director
where dir_id = (
	select dir_id
	from movie_direction
	where mov_id = 
		select mov_id
		from movie
		where mov_title = 'Eyes Wide Shut'));
#RM:  don't need movie_cast table
#official solution
select dir_fname, dir_lname
from  director
where dir_id in (
	select dir_id 
	from movie_direction
	where mov_id in (
	select mov_id 
		from movie_cast where role = any (
		select role 
		from movie_cast 
		where mov_id in (
			select  mov_id 
			from movie 
			where mov_title = 'Eyes Wide Shut'))));

#3. Write a query in SQL to list all the movies which released in the country other than UK.
select *
from movie
where mov_rel_country <> 'UK';

/*
Sample table: reviewer
rev_id |            rev_name
--------+--------------------------------
   9001 | Righty Sock
   9002 | Jack Malvern
   9003 | Flagrant Baronessa
   9004 | Alec Shaw
   9005 |
   9006 | Victor Woeltjen
   9007 | Simon Wright
   9008 | Neal Wruck
   9009 | Paul Monks
   9010 | Mike Salvati
   9011 |
   9012 | Wesley S. Walker
   9013 | Sasha Goldshtein
   9014 | Josh Cates
   9015 | Krug Stillo
   9016 | Scott LeBrun
   9017 | Hannah Steele
   9018 | Vincent Cadena
   9019 | Brandt Sponseller
   9020 | Richard Adams

Sample table: rating
 mov_id | rev_id | rev_stars | num_o_ratings
--------+--------+-----------+---------------
    901 |   9001 |      8.40 |        263575
    902 |   9002 |      7.90 |         20207
    903 |   9003 |      8.30 |        202778
    906 |   9005 |      8.20 |        484746
    924 |   9006 |      7.30 |
    908 |   9007 |      8.60 |        779489
    909 |   9008 |           |        227235
    910 |   9009 |      3.00 |        195961
    911 |   9010 |      8.10 |        203875
    912 |   9011 |      8.40 |
    914 |   9013 |      7.00 |        862618
    915 |   9001 |      7.70 |        830095
    916 |   9014 |      4.00 |        642132
    925 |   9015 |      7.70 |         81328
    918 |   9016 |           |        580301
    920 |   9017 |      8.10 |        609451
    921 |   9018 |      8.00 |        667758
    922 |   9019 |      8.40 |        511613
    923 |   9020 |      6.70 |         13091
*/
#4. Write a query in SQL to find the movie title, year, date of release, director and actor for those movies which reviewer is unknown.
#RM:  write query reviewer is known and is unknown breakdown
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, director.dir_fname, director.dir_lname, actor.act_fname, actor.act_lname
from movie, actor, director, movie_direction, movie_cast
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and movie.mov_id = movie_cast.act_id
and movie_cast.act_id = actor.act_id;  #RM:  incorrect.  error: and movie.mov_id = movie_cast.act_id. 
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, director.dir_fname, director.dir_lname, actor.act_fname, actor.act_lname
from movie, actor, director, movie_direction, movie_cast
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and movie.mov_id = movie_cast.mov_id
and movie_cast.act_id = actor.act_id;  #RM:  correct.  fix error: and movie.mov_id = movie_cast.mov_id
#RM:  my solution reviewer is unknown
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, director.dir_fname, director.dir_lname, actor.act_fname, actor.act_lname
from movie, actor, director, movie_direction, movie_cast, rating, reviewer
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and movie.mov_id = movie_cast.mov_id
and movie_cast.act_id = actor.act_id
and movie.mov_id = rating.mov_id
and rating.rev_id = reviewer.rev_id
and movie.mov_id in (
	select rating.mov_id
	from rating
	where rating.rev_id in (
		select reviewer.rev_id
		from reviewer
		where reviewer.rev_name is null));
#RM:  write query reviewer is known and is unknown breakdown
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, director.dir_fname, director.dir_lname
from movie, director, movie_direction
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id;
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, actor.act_fname, actor.act_lname
from movie, actor, movie_cast
where movie.mov_id = movie_cast.mov_id
and movie_cast.act_id = actor.act_id;
#official solution.  RM:  yes, reviewer table rev_name is null or rev_name is missing
select mov_title, mov_year, mov_dt_rel, dir_fname, dir_lname, act_fname, act_lname
from movie a, movie_direction b, director c, rating d, reviewer e, actor f, movie_cast g
where a.mov_id=b.mov_id
and b.dir_id=c.dir_id
and a.mov_id=d.mov_id
and d.rev_id=e.rev_id
and a.mov_id=g.mov_id
and g.act_id=f.act_id
and e.rev_name is null;

#5. Write a query in SQL to find the titles of all movies directed by the director whose first and last name are Woddy Allen.
select *
from movie
where mov_id in (
	select mov_id
	from movie_direction
	where dir_id = (
		select dir_id
		from director
		where dir_fname = 'Woody' and dir_lname = 'Allen'));
#also
select movie.*
from movie, movie_direction, director
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and director.dir_fname = 'Woody' and dir_lname = 'Allen';

#6. Write a query in SQL to find all the years which produced at least one movie and that received a rating of more than 3 stars. Show the results in increasing order.
select distinct mov_year  #no duplicates
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_stars > 3.00)
order by mov_year;

#7. Write a query in SQL to find the titles of all movies that have no ratings.  #RM:  also include movies not in rating table.
select *
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_stars is null)
and mov_id not in (
	select mov_id
	from rating);  #incorrect.  returned no results  error is and.
select *
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_stars is null)
or mov_id not in (
	select mov_id
	from rating);  #correct.  returned results.  correction is or.
#movies not in rating table
select *
from movie
where mov_id not in (
	select mov_id
	from rating);
#movies rating is null in rating table
select *
from movie
where mov_id in (
	select mov_id
	from rating
	where rev_stars is null);

#official solution is movies not in rating table only.  Exclude movies in rating table with null rating.
select distinct mov_title 
from movie 
where mov_id in (
	select mov_id 
	from movie 
	where mov_id not in (
		select mov_id
		from rating));

#8. Write a query in SQL to find the names of all reviewers who have ratings with a NULL value.
select rev_name
from reviewer
where rev_id in (
	select rev_id
	from rating
	where rev_stars is null);

#9. Write a query in SQL to return the reviewer name, movie title, and stars for those movies which reviewed by a reviewer and must be rated. Sort the result by reviewer name, movie title, and number of stars.
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and reviewer.rev_name is not null
and rating.rev_stars is not null
order by reviewer.rev_name, movie.mov_title, rating.rev_stars;
#also
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer inner join rating
on reviewer.rev_id = rating.rev_id
inner join movie
on rating.mov_id = movie.mov_id
where reviewer.rev_name is not null
and rating.rev_stars is not null
order by reviewer.rev_name, movie.mov_title, rating.rev_stars;

#10. Write a query in SQL to find the reviewer's name and the title of the movie for those reviewers who rated more than one movies.
#find rev_id's the count more than one in rating table
select reviewer.rev_name, movie.mov_title
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and rating.rev_id in (
    select rating.rev_id
    from rating
    group by rating.rev_id
    having count(rating.rev_id) > 1);
#official solution
select rev_name, mov_title 
from reviewer, movie, rating, rating r2
where rating.mov_id=movie.mov_id 
and reviewer.rev_id=rating.rev_id 
and rating.rev_id = r2.rev_id 
group by rev_name, mov_title having count(*) > 1;

#11. Write a query in SQL to find the movie title, and the highest number of stars that movie received and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.
select mov_id, count(rev_stars)
from rating
group by mov_id; #RM:  stupid question because all mov_id count is 1 or 0.
#pretend movies have many stars.  Use max()
select movie.mov_title, MAX(rating.rev_stars)
from movie, rating
where movie.mov_id = rating.mov_id
and rating.rev_stars is not null
group by movie.mov_title
order by movie.mov_title;

#12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty.
select rev_name
from reviewer
where rev_id in (
    select rev_id
    from rating
    where mov_id in (
        select mov_id
        from movie
        where mov_title = 'American Beauty'));
#also and official solution
select rev_name
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and movie.mov_title = 'American Beauty';

#13. Write a query in SQL to find the titles of all movies which have been reviewed by anybody except by Paul Monks.  #RM:  something to think about.  First query returns all movies with a reviewer.  Second query official query returns all movies in reviewer table rev_name null or not null.
select mov_title
from movie, rating, reviewer
where movie.mov_id = rating.mov_id
and rating.rev_id = reviewer.rev_id
and rev_name <> 'Paul Monks';
#official solution subquery includes movies where rev_name in rating table is null
select movie.mov_title
from movie 
where movie.mov_id in(
    select mov_id 
    from rating 
    where rev_id not in (
        select rev_id 
        from reviewer 
        where rev_name='Paul Monks'));

#14. Write a query in SQL to return the reviewer name, movie title, and number of stars for those movies which rating is the lowest one.
#find rev_id and mov_id with lowest stars
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer, movie, rating
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and movie.mov_id = (
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
        where dir_fname = 'James' and dir_lname = 'Cameron'));

#16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. #114
select act_id
from movie_cast
group by act_id
having count(act_id) >=2; #find actors acted two or more movies
select *
from movie
where mov_id in (
    select mov_id
    from movie_cast    
    where act_id in (
        select act_id
        from movie_cast
        group by act_id
        having count(act_id) >=2));