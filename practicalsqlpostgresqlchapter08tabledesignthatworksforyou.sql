--Practical SQL By Anthony DeBarros Second Edition Chapter 08 Table Design That Works For You

create table naturalkeyexamplecolumnconstraint
(licenseid text constraint primarykeyconstraintnamelicensekey primary key, firstname text, lastname text);
drop table naturalkeyexamplecolumnconstraint;
create table naturalkeyexample  --as a table constraint to be declare after listing all columns
(licenseid text, firstname text, lastname text, constraint primarykeyconstraintnamelicensekey primary key (licenseid));
insert into naturalkeyexample (licenseid, firstname, lastname)
values ('T229901','Gem','Godfrey');
insert into naturalkeyexample (licenseid, firstname, lastname) 
values ('T229901','John','Mitchell');
create table naturalkeycompositeexample
(studentid text, schoolday date, present boolean, constraint primarykeyconstraintnamestudentkey primary key (studentid, schoolday));
insert into naturalkeycompositeexample
values(775,'2022-01-22','Y');
insert into naturalkeycompositeexample
values(775,'2022-01-23','Y');
insert into naturalkeycompositeexample
values(775,'2022-01-23','N');
create table autoincrementsurrogatekeyexample
(ordernumber bigint generated always as identity, productname text, ordertime timestamp with time zone, constraint primarykeyconstraintnameordernumbercolumn primary key (ordernumber));  --generated always as key is the syntax to create an auto increment primary key column
drop table autoincrementsurrogatekeyexample;
insert into autoincrementsurrogatekeyexample (productname, ordertime) values
('productname column','2022-04-05 07:46-07'),
('Beachball Polish','2020-03-15 09:21-07'),
('Wrinkle De-Atomizer','2017-05-22 14:00-07'),
('Flux Capacitor','1985-10-26 01:18:00-07');
select *
from autoincrementsurrogatekeyexample;
'''
"ordernumber"	"productname"	"ordertime"
1	"productname column"	"2022-04-05 07:46:00-07"
2	"Beachball Polish"	"2020-03-15 09:21:00-07"
3	"Wrinkle De-Atomizer"	"2017-05-22 14:00:00-07"
4	"Flux Capacitor"	"1985-10-26 01:18:00-07"
'''
insert into autoincrementsurrogatekeyexample overriding system value
values(55,'override increment ordernumber id column assign 55','2022-04-05 07:47:00-07');
select *
from autoincrementsurrogatekeyexample;
'''
"ordernumber"	"productname"	"ordertime"
1	"productname column"	"2022-04-05 07:46:00-07"
2	"Beachball Polish"	"2020-03-15 09:21:00-07"
3	"Wrinkle De-Atomizer"	"2017-05-22 14:00:00-07"
4	"Flux Capacitor"	"1985-10-26 01:18:00-07"
55	"override increment ordernumber id column assign 55"	"2022-04-05 07:47:00-07"
'''
alter table autoincrementsurrogatekeyexample
alter column ordernumber restart with 111;  --a new autoincrement start with number 111
insert into autoincrementsurrogatekeyexample (productname, ordertime)
values('new product order id is 100','2022-04-05 01:11:00-07');
insert into autoincrementsurrogatekeyexample (productname, ordertime)
values('new product order id made a mistakes id 111 should be order id is 111; this is 112','2022-04-05 01:11:00-07');
select *
from autoincrementsurrogatekeyexample;
'''
"ordernumber"	"productname"	"ordertime"
1	"productname column"	"2022-04-05 07:46:00-07"
2	"Beachball Polish"	"2020-03-15 09:21:00-07"
3	"Wrinkle De-Atomizer"	"2017-05-22 14:00:00-07"
4	"Flux Capacitor"	"1985-10-26 01:18:00-07"
55	"override increment ordernumber id column assign 55"	"2022-04-05 07:47:00-07"
111	"new product order id is 100"	"2022-04-05 01:11:00-07"
112	"new product order id made a mistakes id 111 should be order id is 111; this is 112"	"2022-04-05 01:11:00-07"
'''
create table licenses
(licenseid text, firstname text, lastname text, constraint primarykeyconstraintnamelicenseid primary key (licenseid));
create table registrations
(registrationid text, registrationdate timestamp with time zone, licenseid text references licenses (licenseid), constraint primarykeyconstraintnameregistrationkey primary key (registrationid, licenseid));  --licenseid text references licenses references the table licenses
insert into licenses
values('T229901', 'Steve','Rothery');
insert into registrations
values('A203391','2022-03-17','T229901');
insert into registrations
values('A75772','2022-03-17','T000001');  --licenseid in registrations table is a foreign key to licenses table.  Must have a licenseid in licenses table to have an entry in registrations table
insert into registrations
values('A75772','2022-03-17','T229901');
select *
from registrations;
'''
"registrationid"	"registrationdate"	"licenseid"
"A203391"	"2022-03-17 00:00:00-07"	"T229901"
"A75772"	"2022-03-17 00:00:00-07"	"T229901"
'''
create table registrationsokaytodeleteforeignkeyrowdata
(registrationid text, registrationdate date, licenseid text references licenses (licenseid) on delete cascade, constraint primarykeyconstraintnameregistrationkey primary key (registrationid, licenseid));  --add syntax on delete cascade when defining the foreign key constraint to allow deletions.  Deleting a row in licenses table should also delete all related rows in registrations table.  licenseid text references licenses references the table licenses.
--check constraint evalulates data meets expected criteria.  check is the syntax.
create table checkconstraintexample
(userid bigint generated always as identity, userrole text, salary numeric(10,2), constraint primarykeyconstraintnameuserid primary key (userid),constraint checkconstraintnameuserrolelist check (userrole in ('Admin','Staff')), constraint checkconstraintnamesalaryabovezero check (salary >=0));
'''
More constraint examples
constraint checkconstraintnameand check(credits>=120 and tuition = 'Paid')
constraint checkconstraintnamelessthan check (saleprice < retail price)
'''
create table uniqueconstraintexample
(contactid bigint generated always as identity, firstname text, lastname text, email text, constraint primarykeycontactid primary key (contactid), constraint uniqueconstraintnameemail unique (email));  --Column with unique constraint can be null
drop table uniqueconstraintexample;
insert into uniqueconstraintexample (firstname, lastname, email) values
('Samantha','Lee','slee@example.org'),
('Betty','Diaz','bdiaz@example.org');
select *
from uniqueconstraintexample;
'''
"contactid"	"firstname"	"lastname"	"email"
1	"Samantha"	"Lee"	"slee@example.org"
2	"Betty"	"Diaz"	"bdiaz@example.org"
'''
insert into uniqueconstraintexample (firstname, lastname, email)
values ('Sasha','Lee','slee@example.org');  --ERROR:  duplicate key value violates unique constraint "uniqueconstraintnameemail"
create table notnullexample
(studentid bigint generated always as identity, firstname text not null, lastname text not null, constraint primarykeystudentid primary key (studentid));
alter table tablename drop constraint typetheconstraintnametodeleteconstraint;
alter table tablename alter column typetheconstraintnametodeletenotnullcolumn drop not null;
alter table tablename add constraint addprimarykeyconstraintname primary key (column name added primary key);
alter table tablename alter column columnnamesetnotnull set not null;