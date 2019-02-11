#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/movie-database-exercise/basic-exercises-on-movie-database.php

/*
Sample table:  movie
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
#1. Write a query in SQL to find the name and year of the movies.
select mov_title, mov_year
from movie;