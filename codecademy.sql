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
*/
create table celebs (id integer, name text, age integer);
insert into celebs (id, name, age)
values (1, 'Justin Bieber', 21);
insert into celebs (id, name, age)
values (2, 'Beyonce Knowles', 33);
insert into celebs (id, name, age)
values (3, 'Jeremy Lin', 26);
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