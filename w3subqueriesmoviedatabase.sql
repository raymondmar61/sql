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
#RM:  reviewer is unknown
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
