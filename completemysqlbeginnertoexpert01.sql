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
select authorfname, authorlname, concat(authorfname, " ", authorlname) as 'Combine columns'
from books;
/*
# authorfname	authorlname	Combine columns
Jhumpa	Lahiri	Jhumpa Lahiri
Neil	Gaiman	Neil Gaiman
Neil	Gaiman	Neil Gaiman
Jhumpa	Lahiri	Jhumpa Lahiri
Dave	Eggers	Dave Eggers
Dave	Eggers	Dave Eggers
Michael	Chabon	Michael Chabon
Patti	Smith	Patti Smith
Dave	Eggers	Dave Eggers
Neil	Gaiman	Neil Gaiman
Raymond	Carver	Raymond Carver
Raymond	Carver	Raymond Carver
Don	DeLillo	Don DeLillo
John	Steinbeck	John Steinbeck
David	Foster Wallace	David Foster Wallace
David	Foster Wallace	David Foster Wallace
*/
select title, authorfname, authorlname, concat_ws(' - ', title, authorfname, authorlname) as 'Combine columns with separator'
from books;
/*
# title	authorfname	authorlname	Combine columns with separator
The Namesake	Jhumpa	Lahiri	The Namesake - Jhumpa - Lahiri
Norse Mythology	Neil	Gaiman	Norse Mythology - Neil - Gaiman
American Gods	Neil	Gaiman	American Gods - Neil - Gaiman
Interpreter of Maladies	Jhumpa	Lahiri	Interpreter of Maladies - Jhumpa - Lahiri
A Hologram for the King: A Novel	Dave	Eggers	A Hologram for the King: A Novel - Dave - Eggers
The Circle	Dave	Eggers	The Circle - Dave - Eggers
The Amazing Adventures of Kavalier & Clay	Michael	Chabon	The Amazing Adventures of Kavalier & Clay - Michael - Chabon
Just Kids	Patti	Smith	Just Kids - Patti - Smith
A Heartbreaking Work of Staggering Genius	Dave	Eggers	A Heartbreaking Work of Staggering Genius - Dave - Eggers
Coraline	Neil	Gaiman	Coraline - Neil - Gaiman
What We Talk About When We Talk About Love:  Stories	Raymond	Carver	What We Talk About When We Talk About Love:  Stories - Raymond - Carver
Where I'm Calling From: Selected Stories	Raymond	Carver	Where I'm Calling From: Selected Stories - Raymond - Carver
White Noise	Don	DeLillo	White Noise - Don - DeLillo
Cannery Row	John	Steinbeck	Cannery Row - John - Steinbeck
Oblivion: Stories	David	Foster Wallace	Oblivion: Stories - David - Foster Wallace
Consider the Lobster	David	Foster Wallace	Consider the Lobster - David - Foster Wallace
*/
select substring('Hello World',3,5) as 'Extract string start at third character extract five characters'; /* print llo W */
select substring('Hello World',7) as 'Extract all string start at seventh character'; /* #print World */
select substring('Hello World',-4) as 'Extract all string backwards four characters'; /* #print orld */
select title, concat(substring(title,1,10),'...') as 'Extract characters ten from beginning add three dots at the end'
from books;
/*
# title	Extract characters ten from beginning add three dots at the end
The Namesake	The Namesa...
Norse Mythology	Norse Myth...
American Gods	American G...
Interpreter of Maladies	Interprete...
A Hologram for the King: A Novel	A Hologram...
The Circle	The Circle...
The Amazing Adventures of Kavalier & Clay	The Amazin...
Just Kids	Just Kids...
A Heartbreaking Work of Staggering Genius	A Heartbre...
Coraline	Coraline...
What We Talk About When We Talk About Love:  Stories	What We Ta...
Where I'm Calling From: Selected Stories	Where I'm ...
White Noise	White Nois...
Cannery Row	Cannery Ro...
Oblivion: Stories	Oblivion: ...
Consider the Lobster	Consider t...
*/
select replace('Hello World','Hell','#$%^') as 'Replace string replace character'; /* #print #$%^o World */
select title, replace(title,'e','3') as 'Replace letter e with string number 3'
from books;
/*
# title	Replace letter e with string number 3
The Namesake	Th3 Nam3sak3
Norse Mythology	Nors3 Mythology
American Gods	Am3rican Gods
Interpreter of Maladies	Int3rpr3t3r of Maladi3s
A Hologram for the King: A Novel	A Hologram for th3 King: A Nov3l
The Circle	Th3 Circl3
The Amazing Adventures of Kavalier & Clay	Th3 Amazing Adv3ntur3s of Kavali3r & Clay
Just Kids	Just Kids
A Heartbreaking Work of Staggering Genius	A H3artbr3aking Work of Stagg3ring G3nius
Coraline	Coralin3
What We Talk About When We Talk About Love:  Stories	What W3 Talk About Wh3n W3 Talk About Lov3:  Stori3s
Where I'm Calling From: Selected Stories	Wh3r3 I'm Calling From: S3l3ct3d Stori3s
White Noise	Whit3 Nois3
Cannery Row	Cann3ry Row
Oblivion: Stories	Oblivion: Stori3s
Consider the Lobster	Consid3r th3 Lobst3r
*/
select reverse('Hello World') as 'Backwards string'; /* #print 'dlroW olleH' */
select authorfname, reverse(authorfname)
from books;
/*
# authorfname	reverse(authorfname)
Jhumpa	apmuhJ
Neil	lieN
Neil	lieN
Jhumpa	apmuhJ
Dave	evaD
Dave	evaD
Michael	leahciM
Patti	ittaP
Dave	evaD
Neil	lieN
Raymond	dnomyaR
Raymond	dnomyaR
Don	noD
John	nhoJ
David	divaD
David	divaD
*/
select char_length('Hello World') as 'Count characters in string'; /* #print 11 */
select authorlname, char_length(authorlname) as 'Character length'
from books;
/*
# authorlname	Character length
Lahiri	6
Gaiman	6
Gaiman	6
Lahiri	6
Eggers	6
Eggers	6
Chabon	6
Smith	5
Eggers	6
Gaiman	6
Carver	6
Carver	6
DeLillo	7
Steinbeck	9
Foster Wallace	14
Foster Wallace	14
*/
select upper('Hello World') as "Upper case", lower('Hello World') as "Lower case"; /* #print 'HELLO WORLD' 'hello world' */
select title, upper(title) as "Title all caps"
from books;
/*
# title	Title all caps
The Namesake	THE NAMESAKE
Norse Mythology	NORSE MYTHOLOGY
American Gods	AMERICAN GODS
Interpreter of Maladies	INTERPRETER OF MALADIES
A Hologram for the King: A Novel	A HOLOGRAM FOR THE KING: A NOVEL
The Circle	THE CIRCLE
The Amazing Adventures of Kavalier & Clay	THE AMAZING ADVENTURES OF KAVALIER & CLAY
Just Kids	JUST KIDS
A Heartbreaking Work of Staggering Genius	A HEARTBREAKING WORK OF STAGGERING GENIUS
Coraline	CORALINE
What We Talk About When We Talk About Love:  Stories	WHAT WE TALK ABOUT WHEN WE TALK ABOUT LOVE:  STORIES
Where I'm Calling From: Selected Stories	WHERE I'M CALLING FROM: SELECTED STORIES
White Noise	WHITE NOISE
Cannery Row	CANNERY ROW
Oblivion: Stories	OBLIVION: STORIES
Consider the Lobster	CONSIDER THE LOBSTER
*/
select reverse(upper('Why does my cat look at me with such hatred?'));  /* #print ?DERTAH HCUS HTIW EM TA KOOL TAC YM SEOD YHW */
select replace(concat('I',' ','like',' ','cats'),' ', '_'); /* #print I_like_cats */
select title, replace(title,' ','->') as 'title replace spaces'
from books;
/*
# title	title replace spaces
The Namesake	The->Namesake
Norse Mythology	Norse->Mythology
American Gods	American->Gods
Interpreter of Maladies	Interpreter->of->Maladies
A Hologram for the King: A Novel	A->Hologram->for->the->King:->A->Novel
The Circle	The->Circle
The Amazing Adventures of Kavalier & Clay	The->Amazing->Adventures->of->Kavalier->&->Clay
Just Kids	Just->Kids
A Heartbreaking Work of Staggering Genius	A->Heartbreaking->Work->of->Staggering->Genius
Coraline	Coraline
What We Talk About When We Talk About Love:  Stories	What->We->Talk->About->When->We->Talk->About->Love:->->Stories
Where I'm Calling From: Selected Stories	Where->I'm->Calling->From:->Selected->Stories
White Noise	White->Noise
Cannery Row	Cannery->Row
Oblivion: Stories	Oblivion:->Stories
Consider the Lobster	Consider->the->Lobster
*/
select authorlname, reverse(authorlname) as "Backwards string author last name"
from books;
/*
# authorlname	Backwards string author last name
Lahiri	irihaL
Gaiman	namiaG
Gaiman	namiaG
Lahiri	irihaL
Eggers	sreggE
Eggers	sreggE
Chabon	nobahC
Smith	htimS
Eggers	sreggE
Gaiman	namiaG
Carver	revraC
Carver	revraC
DeLillo	olliLeD
Steinbeck	kcebnietS
Foster Wallace	ecallaW retsoF
Foster Wallace	ecallaW retsoF
*/
select upper(concat(authorfname, ' ' ,authorlname)) as "Full name capitalized"
from books;
/*
# Full name capitalized
JHUMPA LAHIRI
NEIL GAIMAN
NEIL GAIMAN
JHUMPA LAHIRI
DAVE EGGERS
DAVE EGGERS
MICHAEL CHABON
PATTI SMITH
DAVE EGGERS
NEIL GAIMAN
RAYMOND CARVER
RAYMOND CARVER
DON DELILLO
JOHN STEINBECK
DAVID FOSTER WALLACE
DAVID FOSTER WALLACE
*/
select concat(title,' was released in ',releaseyear) as "Concat sentence. Reminder run desc books for column names"
from books;
/*
# Concat sentence. Reminder run desc books for column names
The Namesake was released in 2003
Norse Mythology was released in 2016
American Gods was released in 2001
Interpreter of Maladies was released in 1996
A Hologram for the King: A Novel was released in 2012
The Circle was released in 2013
The Amazing Adventures of Kavalier & Clay was released in 2000
Just Kids was released in 2010
A Heartbreaking Work of Staggering Genius was released in 2001
Coraline was released in 2003
What We Talk About When We Talk About Love:  Stories was released in 1981
Where I'm Calling From: Selected Stories was released in 1989
White Noise was released in 1985
Cannery Row was released in 1945
Oblivion: Stories was released in 2004
Consider the Lobster was released in 2005
*/
select title, char_length(title)
from books;
/*
# title	char_length(title)
The Namesake	12
Norse Mythology	15
American Gods	13
Interpreter of Maladies	23
A Hologram for the King: A Novel	32
The Circle	10
The Amazing Adventures of Kavalier & Clay	41
Just Kids	9
A Heartbreaking Work of Staggering Genius	41
Coraline	8
What We Talk About When We Talk About Love:  Stories	52
Where I'm Calling From: Selected Stories	40
White Noise	11
Cannery Row	11
Oblivion: Stories	17
Consider the Lobster	20
*/
select concat(substring(title,1,10),'...') as "short title", concat(authorlname,',',authorfname) as "author", concat(stockquantity,' in stock')as "quantity"
from books;
/*
# short title	author	quantity
The Namesa...	Lahiri,Jhumpa	32 in stock
Norse Myth...	Gaiman,Neil	43 in stock
American G...	Gaiman,Neil	12 in stock
Interprete...	Lahiri,Jhumpa	97 in stock
A Hologram...	Eggers,Dave	154 in stock
The Circle...	Eggers,Dave	26 in stock
The Amazin...	Chabon,Michael	68 in stock
Just Kids...	Smith,Patti	55 in stock
A Heartbre...	Eggers,Dave	104 in stock
Coraline...	Gaiman,Neil	100 in stock
What We Ta...	Carver,Raymond	23 in stock
Where I'm ...	Carver,Raymond	12 in stock
White Nois...	DeLillo,Don	49 in stock
Cannery Ro...	Steinbeck,John	95 in stock
Oblivion: ...	Foster Wallace,David	172 in stock
Consider t...	Foster Wallace,David	92 in stock
*/
/* Insert three more books */
insert into books (title, authorfname, authorlname, releaseyear, stockquantity, pages)
values('10% Happier','Dan','Harris',2014,29,256),('fake_book','Freida','Harris',2001,287,428),('Lincoln In The Bardo','George','Saunders',2017,1000,367);  /* fake_book is a fake book */
select distinct(authorlname) as "Unique last name no duplicates"
from books;
/*
# Unique last name no duplicates
Lahiri
Gaiman
Eggers
Chabon
Smith
Carver
DeLillo
Steinbeck
Foster Wallace
Harris
Saunders
*/
select distinct(concat(authorfname,' ',authorlname)) /* select distinct authorfname, authorlame from books; also works */
from books;
/*
# (concat(authorfname,' ',authorlname))
Jhumpa Lahiri
Neil Gaiman
Dave Eggers
Michael Chabon
Patti Smith
Raymond Carver
Don DeLillo
John Steinbeck
David Foster Wallace
Dan Harris
Freida Harris
George Saunders
*/
select distinct authorfname, authorlname
from books
order by authorlname, authorfname desc; /*order by 1, 2 desc; also works */
/*
# authorfname	authorlname
Raymond	Carver
Michael	Chabon
Don	DeLillo
Dave	Eggers
David	Foster Wallace
Neil	Gaiman
Freida	Harris
Dan	Harris
Jhumpa	Lahiri
George	Saunders
Patti	Smith
John	Steinbeck
*/
select title as "Return three rows limit rows"
from books
limit 3;
/*
# Return three rows limit rows
The Namesake
Norse Mythology
American Gods
*/
select title, releaseyear as "Five most recent books start at zero which is first row return five"
from books
order by releaseyear desc
limit 0,5;
/*
# title	Five most recent books start at zero which is first row return five
Lincoln In The Bardo	2017
Norse Mythology	2016
10% Happier	2014
The Circle	2013
A Hologram for the King: A Novel	2012
*/
select title, releaseyear as "Sixth most recent book afterwards start at five which is sixth row return the rest of the rows"
from books
order by releaseyear desc
limit 5, 18729817928173;
/*
# title	Sixth most recent book afterwards start at five which is sixth row return the rest of the rows
Just Kids	2010
Consider the Lobster	2005
Oblivion: Stories	2004
Coraline	2003
The Namesake	2003
American Gods	2001
A Heartbreaking Work of Staggering Genius	2001
fake_book	2001
The Amazing Adventures of Kavalier & Clay	2000
Interpreter of Maladies	1996
Where I'm Calling From: Selected Stories	1989
White Noise	1985
What We Talk About When We Talk About Love:  Stories	1981
Cannery Row	1945
*/
/* wild card search use percentage % for asterik *.  The underscore _ is one character. */
select authorfname, title as "Find books first name author begins with Da case insensitive"
from books
where authorfname like 'da%';
/*
# authorfname	Find books first name author begins with Da case insensitive
Dave	A Hologram for the King: A Novel
Dave	The Circle
Dave	A Heartbreaking Work of Staggering Genius
David	Oblivion: Stories
David	Consider the Lobster
Dan	10% Happier
*/
select authorfname, title as "Search book title with percentage sign % use escape character backslash \\"
from books
where title like '%\%%';
/*
# authorfname	Search book title with percentage sign % use escape character backslash \
Dan	10% Happier
*/
select title as "Find titles with stories in title"
from books
where title like '%stories%';
/*
# Find titles with stories in title
What We Talk About When We Talk About Love:  Stories
Where I'm Calling From: Selected Stories
Oblivion: Stories
*/
select title as "Book most pages", pages
from books
order by pages desc
limit 1;
/*
# Book most pages	pages
The Amazing Adventures of Kavalier & Clay	634
*/
select concat(title,' - ',releaseyear) as "Summary title and year three most recent books"
from books
order by releaseyear desc
limit 3;
/*
# Summary title and year three most recent books
Lincoln In The Bardo - 2017
Norse Mythology - 2016
10% Happier - 2014
*/
select title, authorlname as "Author last name with a space"
from books
where authorlname like '% %';
/*
# title	Author last name with a space
Oblivion: Stories	Foster Wallace
Consider the Lobster	Foster Wallace
*/
select title, releaseyear, stockquantity as "Three books fewest in stock"
from books
order by stockquantity asc, releaseyear desc
limit 0,3;
/*
# title	releaseyear	Three books fewest in stock
American Gods	2001	12
Where I'm Calling From: Selected Stories	1989	12
What We Talk About When We Talk About Love:  Stories	1981	23
*/
select title, authorlname
from books
order by authorlname, title;
/*
# title	authorlname
What We Talk About When We Talk About Love:  Stories	Carver
Where I'm Calling From: Selected Stories	Carver
The Amazing Adventures of Kavalier & Clay	Chabon
White Noise	DeLillo
A Heartbreaking Work of Staggering Genius	Eggers
A Hologram for the King: A Novel	Eggers
The Circle	Eggers
Consider the Lobster	Foster Wallace
Oblivion: Stories	Foster Wallace
American Gods	Gaiman
Coraline	Gaiman
Norse Mythology	Gaiman
10% Happier	Harris
fake_book	Harris
Interpreter of Maladies	Lahiri
The Namesake	Lahiri
Lincoln In The Bardo	Saunders
Just Kids	Smith
Cannery Row	Steinbeck
*/
select concat(upper('my favorite author is '),upper(authorfname),' ',upper(authorlname),'!')
from books
order by authorlname;
/*
# concat(upper('my favorite author is '),upper(authorfname),' ',upper(authorlname),'!')
MY FAVORITE AUTHOR IS RAYMOND CARVER!
MY FAVORITE AUTHOR IS RAYMOND CARVER!
MY FAVORITE AUTHOR IS MICHAEL CHABON!
MY FAVORITE AUTHOR IS DON DELILLO!
MY FAVORITE AUTHOR IS DAVE EGGERS!
MY FAVORITE AUTHOR IS DAVE EGGERS!
MY FAVORITE AUTHOR IS DAVE EGGERS!
MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE!
MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE!
MY FAVORITE AUTHOR IS NEIL GAIMAN!
MY FAVORITE AUTHOR IS NEIL GAIMAN!
MY FAVORITE AUTHOR IS NEIL GAIMAN!
MY FAVORITE AUTHOR IS DAN HARRIS!
MY FAVORITE AUTHOR IS FREIDA HARRIS!
MY FAVORITE AUTHOR IS JHUMPA LAHIRI!
MY FAVORITE AUTHOR IS JHUMPA LAHIRI!
MY FAVORITE AUTHOR IS GEORGE SAUNDERS!
MY FAVORITE AUTHOR IS PATTI SMITH!
MY FAVORITE AUTHOR IS JOHN STEINBECK!
*/