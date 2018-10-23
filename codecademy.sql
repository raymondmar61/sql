--https://www.codecademy.com/learn/learn-sql

#1 Learn SQL:  Manipulation
select *
from celebs;
/*
id	name	age
1	Justin Bieber	22
2	Beyonce Knowles	33
3	Jeremy Lin	26
4	Taylor Swift	26
*/
/* create table tablename (column1 integer, column2 text, column3 data, column 4 real)
or
clause tablename (parameters)
RM:  create table also a statement such as select statement for select query?  It seems statement and clause are interchangeably.
*/values (3, 'Jeremy Lin', 26);

create table celebs (id integer, name text, age integer);
insert into celebs (id, name, age)
values (1, 'Justin Bieber', 21);
insert into celebs (id, name, age)
values (2, 'Beyonce Knowles', 33);
insert into celebs (id, name, age)
insert into celebs (id, name, age)
values (4, 'Taylor Swift', 26);
select name
from celebs;
update celebs
set age = 22
where id = 1;  --update record, edit record, edit row, update row
alter table celebs
add column twitter_handle text;  --insert column
update celebs
set twitter_handle = '@taylorswift13'
where id = 4;
delete from celebs
where twitter_handle is null;  --delete record, delete row
create table awards (id integer primary key, recipient text not null, award_name text default "Grammy");
--UNIQUE columns have a different value for every row. This is similar to PRIMARY KEY except a table can have many different UNIQUE columns.
--DEFAULT columns take an additional argument that will be the assumed value for an inserted row if the new row does not specify a value for that column.

#2 Learn SQl:  Queries
select *
from movies;
/*
Database Schema
movies 230 rows
id	INTEGER
name	TEXT
genre	TEXT
year	INTEGER
imdb_rating	REAL
*/
select name, genre, year
from movies;
select imdb_rating as 'IMDb'
from movies;  --AS is a keyword in SQL that allows you to rename a column or table using an alias.
select distinct genre
from inventory; --DISTINCT is used to return unique values in the output. It filters out all duplicate values in the specified column(s).
select *
from movies
where imdb_rating < 5;  --WHERE clause restricts query results to obtain only the information we want.
select *
from movies
where name like 'Se_en';
select *
from movies
where name like '%man%';
select *
from movies
where name like 'The %';  --selects all the information about the movie titles that begin with the word 'The'.  Exclude They, Them, Their, There
select name
from movies
where imdb_rating is null;
select *
from movies
where name between 'A' and 'J';  --The BETWEEN operator can be used in a WHERE clause to filter the result set within a certain range. The values can be numbers, text or dates.  Returns movies beginning with letters between A inclusive and J exclusive.
select *
from movies
where year between 1990 and 1999;  --Returns movies between 1990 and 1999 both inclusive
select *
from movies
where name between 'D' and 'G';  --Returns movies between D and F.
select *
from movies
where year between 1970 and 1979
and imdb_rating > 8;
select *
from movies
where year < 1985
and genre = 'horror';
select *
from movies
where genre = 'romance'
or genre = 'comedy';
select name, year, imdb_rating
from movies
order by imdb_rating desc;  --The column that we ORDER BY doesn't even have to be one of the columns that we're displaying.  ORDER BY always goes after WHERE if WHERE is present.
select *
from movies
order by imdb_rating desc
limit 3;  --LIMIT is a clause that lets you specify the maximum number of rows the result set will have.  LIMIT must be at the end.  Some SQL databases support LIMIT.
select name, case when imdb_rating > 8 then 'Fantastic' when imdb_rating > 6 then 'Poorly Received' else 'Avoid at all costs' end as 'Review'
from movies;  --A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL's way of handling if-then if then logic.  Each WHEN tests a condition and the following THEN gives us the string if the condition is true.  The ELSE gives us the string if all the above conditions are false.  The CASE statement must end with END.  We can rename the case when column to 'Review' using AS.
select name, case when genre = 'romance' then 'Chill' when genre = 'comedy' then 'Chill' else 'Intense' end as 'Mood'
from movies;
--also
select name, case when genre = 'romance' or genre = 'comedy' then 'Chill' else 'Intense' end as 'Mood'
from movies;
-- Start 1 Learn SQL: Manipulation Create a Table 10/22/18