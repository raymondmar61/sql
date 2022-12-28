/* Complete MySQL Beginner to Expert [en6YPAgc6WM] */
create database helloworlddb;
show databases;
drop database helloworlddb;
use helloworlddb;
select helloworlddb(); /* video showed active database is helloworlddb.  MySQL Workbench error message Error Code: 1305. FUNCTION helloworlddb.helloworlddb does not exist	0.00023 sec*/
use giraffe;
select database();
/*
# database()
'giraffe'
*/
create database catapp;
use catapp; /* Activate database, go to database */
create table cats
(name varchar(100), age int);
show tables;
/*
# Tables_in_catapp
'cats'
*/
show columns from cats;
/*
# Field, Type, Null, Key, Default, Extra
name, varchar(100), YES, , , 
age, int, YES, , , 
*/
#or
desc cats;
/*
# Field, Type, Null, Key, Default, Extra
name, varchar(100), YES, , , 
age, int, YES, , , 
*/
drop table cats; /* Delete table */
create table pastries
(name varchar(50), quantity int);
desc pastries;
/*
# Field, Type, Null, Key, Default, Extra
name, varchar(50), YES, , , 
quantity, int, YES, , , 
*/
drop table pastries;
create table cats
(name varchar(50), age int);
insert into cats (name, age)
values ("Blue",1);
insert into cats (age, name)
values (11,"Draco");
insert into cats
values ("Peanut",2),('Butter',4),("Jelly",7); /* Single quotes or double quotes valid */
select *
from cats;
/*
# name	age
Blue	1
Draco	11
Peanut	2
Butter	4
Jelly	7
*/
create table people
(firstname varchar(20), lastname varchar(20), age int);
insert into people
values("Tina","Belcher",13),("Bob","Belcher",42),("Linda","Belcher",45),("Phillip","Frond",38),("Calvin","Fischoeder",70);
select *
from people;
/*
Tina	Belcher	13
Bob	Belcher	42
Linda	Belcher	45
Phillip	Frond	38
Calvin	Fischoeder	70
*/
drop table people;
#Null means the value is unknown.  Null is not zero.  Null is not blank.
insert into cats (name)
values("Alabama");
select *
from cats;
/*
# name	age
Blue	1
Draco	11
Peanut	2
Butter	4
Jelly	7
Alabama	NULL
*/
create table cats2
(name varchar(100) not null, age int not null);
desc cats2;
/*
# Field	Type	Null	Key	Default	Extra
name	varchar(100)	NO			
age	int	NO			
*/
insert into cats2(name, age)
values("Texas",);
show warnings;
/*
# Level	Code	Message
Error	1064	You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 2
*/
create table cats3
(name varchar(20) default 'no name provided', age int default 99);
desc cats3;
/*
# Field	Type	Null	Key	Default	Extra
name	varchar(20)	YES		no name provided	
age	int	YES		99	
*/
insert into cats3(age)
values(13);
insert into cats3()
values();
insert into cats3()
values("Montana",null);
select *
from cats3;
/*
# name	age
no name provided	13
no name provided	99
Montana	null
*/
create table cats4
(name varchar(100) not null default 'no name provided', age int not null default 99);
desc cats4;
/*
# Field	Type	Null	Key	Default	Extra
name	varchar(100)	NO		no name provided	
age	int	NO		99	
*/
insert into cats4(name, age)
values("Cali",NULL);
show warnings;
/*
# Level	Code	Message
Error	1048	Column 'age' cannot be null
*/
#Primary key.  Unique identifier unique id.
create table uniquecats
(catid int not null auto_increment, name varchar(100), age int, primary key (catid));
#or
create table uniquecats
(catid int not null auto_increment primary key, name varchar(100), age int);
desc uniquecats;
/*
# Field	Type	Null	Key	Default	Extra
catid	int	NO	PRI		auto_increment
name	varchar(100)	YES			
age	int	YES			
*/
insert into uniquecats(name, age)
values("Fred",23),("Louise",3);
select *
from uniquecats;
/*
# catid	name	age
1	Fred	23
2	Louise	3
*/
create table employees
(id int not null auto_increment, lastname varchar(255) not null, firstname varchar(255) not null, middlename varchar(255), age integer not null, currentstatus varchar(100) not null default "employed", primary key(id));
desc employees;
/*
# Field	Type	Null	Key	Default	Extra
id	int	NO	PRI		auto_increment
lastname	varchar(255)	NO			
firstname	varchar(255)	NO			
middlename	varchar(255)	YES			
age	int	NO			
currentstatus	varchar(100)	NO		employed	
*/
insert into employees(lastname, firstname, age)
values("Smith","Dora",58);
select *
from employees;
/*
# id	lastname	firstname	middlename	age	currentstatus
1	Smith	Dora		58	employed
*/
drop table cats;
create table cats
(catid int not null auto_increment primary key, name varchar(100), breed varchar(100), age int);
insert into cats (name, breed, age)
values("Ringo","Tabby",4),("Cindy","Maine Coon",10),("Dumbledore","Maine Coon",11),("Egg","Persian",4),("Misty","Tabby",13),("George Michael","Ragdoll",9),("Jackson","Sphynx",7);
select *
from cats;
/*
# catid	name	breed	age
1	Ringo	Tabby	4
2	Cindy	Maine Coon	10
3	Dumbledore	Maine Coon	11
4	Egg	Persian	4
5	Misty	Tabby	13
6	George Michael	Ragdoll	9
7	Jackson	Sphynx	7
*/
select age, name
from cats
where age=4 and name="Egg";
/*
# age	name
4	Egg
*/

select catid as "cat id alias double quotes", age
from cats
where catid=age;
/*
# cat id alias double quotes	age
4	4
7	7
*/
set sql_safe_updates = 0; #https://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench for Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.  RM:  I needed to scroll down SQL Editor.  The vertical scroll bar was too thin for me to see.
update cats
set breed="Shorthair"
where breed="Tabby";
select *
from cats;
/*
# catid	name	breed	age
1	Ringo	Shorthair	4
2	Cindy	Maine Coon	10
3	Dumbledore	Maine Coon	11
4	Egg	Persian	4
5	Misty	Shorthair	13
6	George Michael	Ragdoll	9
7	Jackson	Sphynx	7
*/
update cats
set name="Jack"
where name="Jackson";
update cats
set breed="British Shorthair"
where name="Ringo";
update cats
set age=12
where breed="Maine Coon";
select *
from cats;
/*
# catid	name	breed	age
1	Ringo	British Shorthair	4
2	Cindy	Maine Coon	12
3	Dumbledore	Maine Coon	12
4	Egg	Persian	4
5	Misty	Shorthair	13
6	George Michael	Ragdoll	9
7	Jack	Sphynx	7
*/
delete from cats
where name="Egg";
select *
from cats;
/*
# catid	name	breed	age
1	Ringo	British Shorthair	4
2	Cindy	Maine Coon	12
3	Dumbledore	Maine Coon	12
5	Misty	Shorthair	13
6	George Michael	Ragdoll	9
7	Jack	Sphynx	7
*/
delete from cats
where age = 4
or
catid=age;
select *
from cats;
/*
# catid	name	breed	age
2	Cindy	Maine Coon	12
3	Dumbledore	Maine Coon	12
5	Misty	Shorthair	13
6	George Michael	Ragdoll	9
*/
delete from cats; /* Delete all rows.  Doesn't delete cats table */

#Exercise shirts database
create database shirtsdb;
create table shirts
(shirtid int not null auto_increment primary key, article varchar(20), color varchar(20), shirtsize varchar(10), lastworn int); /*lastworn is the number of days shirt worn */
insert into shirts(article,color,shirtsize,lastworn)
values("t-shirt","white","S",10),("t-shirt","green","S",200),("polo shirt","black","M",10),("tank top","blue","S",50),("t-shirt","pink","S",0),("polo shirt","red","M",5),("tank top","white","S",200),("tank top","blue","M",15); /* Need to mention column names after insert into sql statement */
insert into shirts(article,color,shirtsize,lastworn)
values("polo shirt","purple","M",50);
select *
from shirts;
/*
# shirtid	article	color	shirtsize	lastworn
1	t-shirt	white	S	10
2	t-shirt	green	S	200
3	polo shirt	black	M	10
4	tank top	blue	S	50
5	t-shirt	pink	S	0
6	polo shirt	red	M	5
7	tank top	white	S	200
8	tank top	blue	M	15
9	polo shirt	purple	M	50
*/
select article, color
from shirts
where shirtsize = "M";
/*
# article	color
polo shirt	black
polo shirt	red
tank top	blue
polo shirt	purple
*/
set sql_safe_updates = 0;
update shirts
set shirtsize = "L"
where article = "polo shirt";
update shirts
set lastworn = 0
where lastworn = 15; /* worn the shirt last worn 15 days ago today.  Set lastworn to zero */
update shirts
set shirtsize = "XS", color = "off white" /* separate multiple criteria with a comma.  Using "and" is invalid */
where color = "white";
delete from shirts
where lastworn = 200;
delete from shirts
where article = "tank top";
delete from shirts; /* delete all rows or delete rows all */
drop table shirts; /* delete table */

#SQL code from a .sql file
use catapp; /* Activate database, go to database */
source /home/mar/mysql/sqlfilewrittensublimetext.sql; /* Error code 1064.  It didn't work for MySQL Workbench. */
/*
create table catssublimetext
(catid int not null auto_increment, name varchar(100),age int, primary key (catid));
*/

#String functions
create database bookshop;
use bookshop; /* Activate database, go to database */
create table books
(bookid int not null auto_increment, title varchar(100), authorfname varchar(100), authorlname varchar(100), releaseyear int, stockquantity int, pages int, primary key (bookid));
insert into books (title, authorfname, authorlname, releaseyear, stockquantity, pages)
values ("The Namesake","Jhumpa","Lahiri",2003,32,291), ("Norse Mythology","Neil","Gaiman",2016,43,304), ("American Gods","Neil","Gaiman",2001,12,465), ("Interpreter of Maladies","Jhumpa","Lahiri",1996,97,198), ("A Hologram for the King: A Novel","Dave","Eggers",2012,154,352), ("The Circle","Dave","Eggers",2013,26,504), ("The Amazing Adventures of Kavalier & Clay","Michael","Chabon",2000,68,634), ("Just Kids","Patti","Smith",2010,55,304), ("A Heartbreaking Work of Staggering Genius","Dave","Eggers",2001,104,437), ("Coraline","Neil","Gaiman",2003,100,208), ("What We Talk About When We Talk About Love:  Stories","Raymond","Carver",1981,23,176), ("Where I'm Calling From: Selected Stories","Raymond","Carver",1989,12,526), ("White Noise","Don","DeLillo",1985,49,320), ("Cannery Row","John","Steinbeck",1945,95,181), ("Oblivion: Stories","David","Foster Wallace",2004,172,329), ("Consider the Lobster","David","Foster Wallace",2005,92,343);
select *
from books;
/*
# bookid	title	authorfname	authorlname	releaseyear	stockquantity	pages
1	The Namesake	Jhumpa	Lahiri	2003	32	291
2	Norse Mythology	Neil	Gaiman	2016	43	304
3	American Gods	Neil	Gaiman	2001	12	465
4	Interpreter of Maladies	Jhumpa	Lahiri	1996	97	198
5	A Hologram for the King: A Novel	Dave	Eggers	2012	154	352
6	The Circle	Dave	Eggers	2013	26	504
7	The Amazing Adventures of Kavalier & Clay	Michael	Chabon	2000	68	634
8	Just Kids	Patti	Smith	2010	55	304
9	A Heartbreaking Work of Staggering Genius	Dave	Eggers	2001	104	437
10	Coraline	Neil	Gaiman	2003	100	208
11	What We Talk About When We Talk About Love:  Stories	Raymond	Carver	1981	23	176
12	Where I'm Calling From: Selected Stories	Raymond	Carver	1989	12	526
13	White Noise	Don	DeLillo	1985	49	320
14	Cannery Row	John	Steinbeck	1945	95	181
15	Oblivion: Stories	David	Foster Wallace	2004	172	329
16	Consider the Lobster	David	Foster Wallace	2005	92	343
*/
