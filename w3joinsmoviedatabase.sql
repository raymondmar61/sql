#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/movie-database-exercise/joins-exercises-on-movie-database.php

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
#1. Write a query in SQL to find the name of all reviewers who have rated their ratings with a NULL value.
select re.rev_name
from reviewer re right outer join rating ra
on re.rev_id = ra.rev_id
where ra.rev_stars is null;
#RM:  if left outer join, then Westley S. Walker 9012 and Alec Shaw 9004 are returned because they don't have any rating
#official solution
select rev_name
from reviewer
inner join rating using(rev_id)
where rev_stars is null;

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
#2. Write a query in SQL to list the first and last names of all the actors who were cast in the movie 'Annie Hall', and the roles they played in that production.
select a.act_fname, a.act_lname, mc.role
from actor a right outer join movie_cast mc
on a.act_id = mc.act_id
left outer join movie m
on mc.mov_id = m.mov_id
where m.mov_title = 'Annie Hall';

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
#3. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'.  #RM:  I read the solution.  It found the director for Eyes Wide Shut.
select movie.mov_title, director.dir_fname, director.dir_lname
from director right outer join movie_direction
on director.dir_id = movie_direction.dir_id
inner join movie
on movie_direction.mov_id = movie.mov_id
where movie.mov_title = 'Eyes Wide Shut';

#4. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role as Sean Maguire.
select movie.mov_title, director.dir_fname, director.dir_lname
from director right outer join movie_direction
on director.dir_id = movie_direction.dir_id
inner join movie
on movie_direction.mov_id = movie.mov_id
right outer join movie_cast
on movie.mov_id = movie_cast.mov_id
where movie_cast.role = 'Sean Maguire';

#5. Write a query in SQL to list all the actors who acted in a movie before 1990 and also in a movie after 2000.
select a.act_fname, a.act_lname
from actor a inner join movie_cast mc
on a.act_id = mc.act_id
left outer join movie m
on mc.mov_id = m.mov_id
where mov_year < 1990 or mov_year > 2000;

/*
Sample table: genres
gen_id |      gen_title
--------+----------------------
   1001 | Action
   1002 | Adventure
   1003 | Animation
   1004 | Biography
   1005 | Comedy
   1006 | Crime
   1007 | Drama
   1008 | Horror
   1009 | Music
   1010 | Mystery
   1011 | Romance
   1012 | Thriller
   1013 | War

Sample table: movie_genres
mov_id | gen_id
--------+--------
    922 |   1001
    917 |   1002
    903 |   1002
    912 |   1003
    911 |   1005
    908 |   1006
    913 |   1006
    926 |   1007
    928 |   1007
    918 |   1007
    921 |   1007
    902 |   1008
    923 |   1009
    907 |   1010
    927 |   1010
    901 |   1010
    914 |   1011
    906 |   1012
    904 |   1013
*/
#6. Write a query in SQL to list first and last name of all the directors with number of genres movies the directed with genres name, and arranged the result alphabetically with the first and last name of the director.
select d.dir_fname, d.dir_lname, g.gen_title, count(g.gen_title)
from director d left outer join movie_direction md
on d.dir_id = md.dir_id
inner join movie_genres mg
on md.mov_id = mg.mov_id
inner join genres g
on mg.gen_id = g.gen_id
group by 1, 2, 3
order by d.dir_fname, d.dir_lname;
#official solution
select dir_fname, dir_lname, gen_title, count(gen_title)
from director
natural join movie_direction
natural join movie_genres
natural join genres
group by dir_fname, dir_lname,gen_title
order by dir_fname,dir_lname;

#7. Write a query in SQL to list all the movies with year and genres.
select movie.mov_title, movie.mov_year, genres.gen_title
from movie, genres, movie_genres
where movie.mov_id = movie_genres.mov_id
and movie_genres.gen_id = genres.gen_id;
#also
select mov_title, mov_year, gen_title
from movie
natural join genres
natural join movie_genres;

#8. Write a query in SQL to list all the movies with year, genres, and name of the director.
select movie.mov_title, movie.mov_year, genres.gen_title, director.dir_fname, director.dir_lname
from movie, genres, movie_genres, director, movie_direction
where movie.mov_id = movie_genres.mov_id
and movie_genres.gen_id = genres.gen_id
and movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id;
#also
select mov_title, mov_year, gen_title, dir_fname, dir_lname
from movie
natural join genres
natural join movie_genres
natural join movie_direction
natural join director;

#9. Write a query in SQL to list all the movies with title, year, date of release, movie duration, and first and last name of the director which released before 1st january 1989, and sort the result set according to release date from highest date to lowest.
select m.mov_title, m.mov_year, m.mov_dt_rel, m.mov_time, d.dir_fname, d.dir_lname
from movie m inner join movie_direction md
on m.mov_id = md.mov_id
inner join director d
on md.dir_id = d.dir_id
where m.mov_dt_rel < '1989-01-01'
order by m.mov_dt_rel desc;
#also
select mov_title, mov_year, mov_dt_rel, mov_time, dir_fname, dir_lname
from movie
natural join movie_direction
natural join director
where mov_dt_rel < '1989-01-01'
order by mov_dt_rel desc;

#10. Write a query in SQL to compute a report which contain the genres of those movies with their average time and number of movies for each genres.
select g.gen_title, count(g.gen_title), avg(m.mov_time)
from movie m inner join movie_genres mg
on m.mov_id = mg.mov_id
inner join genres g
on mg.gen_id = g.gen_id
group by g.gen_title;
#also
select g.gen_title, count(g.gen_title), avg(m.mov_time)
from movie m
natural join movie_genres mg
natural join genres g
group by g.gen_title;

#11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production.
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
from movie
natural join actor
natural join director
natural join movie_direction
natural join movie_cast
where mov_time = (
	select min(mov_time)
	from movie);

#12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order.  #RM:  dumb question.  There are two movies with a rating 3 or 4.  Same year which is 1997.
select distinct mov_year
from movie
natural join rating
where rev_stars in (3, 4)
order by mov_year;

#13. Write a query in SQL to return the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
#RM:  FYI, rev_id 9001 Righty Sock reviewed two movies 901 Vertigo and 915 Titanic.  Also, I included null rev_name.
select re.rev_name, m.mov_title, ra.rev_stars
from movie m right outer join rating ra
on m.mov_id = ra.mov_id
left outer join reviewer re
on ra.rev_id = re.rev_id
order by re.rev_name, m.mov_title, ra.rev_stars;
#official solution
select rev_name, mov_title, rev_stars
from movie 
natural join rating 
natural join reviewer
order by rev_name, mov_title, rev_stars;
#another official solution
select rev_name, mov_title, rev_stars
from movie
inner join rating using (mov_id)
inner join reviewer using (rev_id)
order by rev_name, mov_title, rev_stars;

#14. Write a query in SQL to find movie title and number of stars for each movie that has at least one rating and find the highest number of stars that movie received and sort the result by movie title.
select mov_title, rev_stars
from movie
natural join rating
where num_o_ratings > 1
order by mov_title;
#official solution  RM:  doesn't make sense.
select mov_title, max(rev_stars)
from movie
inner join rating using(mov_id)
group by mov_title 
having max(rev_stars)>0
order by mov_title;

#15. Write a query in SQL to find the director's first and last name together with the title of the movie(s) they directed and received the rating.
select dir_fname, dir_lname, mov_title, rev_stars
from movie
natural join rating
natural join movie_direction
natural join director
where rev_stars is not null;
#official solution
select dir_fname, dir_lname, mov_title, rev_stars
from movie
inner join movie_direction using (mov_id)
inner join director using (dir_id) #RM:  no common field between movie and director.  dir_id not common bewteen movie and director
left outer join rating using (mov_id) #RM:  no common field between director and rating  mov_id is not common between director and rating
where rev_stars is not null;

#16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
select movie.mov_title, actor.act_fname, actor.act_lname, movie_cast.role
from movie
natural join movie_cast
natural join actor
where movie_cast.act_id in (
    select act_id
    from movie_cast
    group by act_id
    having count(act_id) >=2);  #RM:  Kevin Spacey Lester Burnham American Beauty and Bobby Darin Beyond the Sea
#official solution
select mov_title, act_fname, act_lname, role
from movie join movie_cast 
on movie_cast.mov_id=movie.mov_id 
join actor 
on movie_cast.act_id=actor.act_id
where actor.act_id in (
    select act_id 
    from movie_cast 
    group by act_id having count(*)>=2);

#17. Write a query in SQL to find the first and last name of a director and the movie he or she directed, and the actress appeared which first name was Claire and last name was Danes along with her role in that movie.
select dir.dir_fname, dir.dir_lname, m.mov_title
from movie m inner join movie_direction md
on m.mov_id = md.mov_id
inner join director dir
on md.dir_id = dir.dir_id; #RM:  find director's first name, director's last name, and movie directed

select dir.dir_fname, dir.dir_lname, m.mov_title, mc.role
from movie m inner join movie_direction md
on m.mov_id = md.mov_id
inner join director dir
on md.dir_id = dir.dir_id
inner join movie_cast mc
on m.mov_id = mc.mov_id
inner join actor a
on mc.act_id = a.act_id
where a.act_fname = 'Claire' and a.act_lname = 'Danes';

#18. Write a query in SQL to find the first and last name of an actor with their role in the movie which was also directed by themselve.
select actor.act_fname, actor.act_lname, movie.mov_title, movie_cast.role
from movie inner join movie_cast
on movie.mov_id = movie_cast.mov_id
inner join actor
on movie_cast.act_id = actor.act_id
inner join movie_direction
on movie.mov_id = movie_direction.mov_id
inner join director
on movie_direction.dir_id = director.dir_id
where actor.act_fname=director.dir_fname
and actor.act_lname=director.dir_lname;

#19. Write a query in SQL to find the cast list for the movie Chinatown.
select mc.role, a.act_fname, a.act_lname
from movie m inner join movie_cast mc
on m.mov_id = mc.mov_id
inner join actor a
on mc.act_id = a.act_id
where m.mov_title = 'Chinatown';

#20. Write a query in SQL to find the movie in which the actor appeared whose first and last name are 'Harrison' and 'Ford'.
select m.mov_title
from movie m inner join movie_cast mc
on m.mov_id = mc.mov_id
inner join actor a
on mc.act_id = a.act_id
where a.act_fname = 'Harrison'
and a.act_lname = 'Ford';

#21. Write a query in SQL to find the highest-rated movie, and report its title, year, rating, and releasing country.
select m.mov_title, m.mov_year, r.rev_stars, m.mov_rel_country
from movie m inner join rating r
on m.mov_id = r.mov_id
where r.rev_stars = (
    select max(r.rev_stars)
    from rating r);

#22. Write a query in SQL to find the highest-rated Mystery movie, and report the title, year, and rating.
select m.mov_title, m.mov_year, r.rev_stars, m.mov_rel_country
from movie m, rating r
where m.mov_id = r.mov_id
and r.rev_stars = (
    select max(r.rev_stars)
    from rating r, movie_genres mg, genres g
    where r.mov_id = mg.mov_id
    and mg.gen_id = g.gen_id
    and g.gen_title = 'Mystery');  #RM:  partially correct because max rating for Mystery is 8.40 in subquery.  There are three movies with 8.40, and one is Mystery.

select m.mov_title, m.mov_year, r.rev_stars, m.mov_rel_country
from movie m, rating r
where m.mov_id = r.mov_id
and m.mov_id = (
    select r.mov_id
    from rating r, movie_genres mg, genres g
    where r.mov_id = mg.mov_id
    and mg.gen_id = g.gen_id
    and g.gen_title = 'Mystery'
    and r.rev_stars = (
        select max(r.rev_stars)
        from rating r, movie_genres mg, genres g
        where r.mov_id = mg.mov_id
        and mg.gen_id = g.gen_id
        and g.gen_title = 'Mystery'));  #RM:  correct.  Second subquery gets 8.40 highest rating.  First subquery gets Mystery 8.40 highest rating mov_id.

#23. Write a query in SQL to generate a report which shows the year when most of the Mystery movies produces, and number of movies and their average rating.  #RM:  there are 19 movies with a genre.  #RM:  question asked get all Mystery movies grouped by year, count, and average rating.  There is one movie.
select m.mov_year, g.gen_title, count(g.gen_title), avg(r.rev_stars)
from movie m inner join rating r
on m.mov_id = r.mov_id
inner join movie_genres mg
on m.mov_id = mg.mov_id
inner join genres g
on mg.gen_id = g.gen_id
where g.gen_title = 'Mystery'
group by m.mov_year, g.gen_title;

#24. Write a query in SQL to generate a report which contain the columns movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.
select movie.mov_title, actor.act_fname, actor.act_lname, movie.mov_year, movie_cast.role, genres.gen_title, director.dir_fname, director.dir_lname, movie.mov_dt_rel, rating.rev_stars
from movie
natural join genres
natural join movie_genres
natural join rating
natural join actor
natural join director
natural join movie_direction
natural join movie_cast
where actor.act_gender = 'F';