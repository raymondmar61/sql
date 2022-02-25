#Practical SQL By Anthony DeBarros Second Edition Chapter 02 Creating Your First Database And Table

create database analysis;
create database databasename;
--RM:  Ctrl+Spacebar intellisense.  Ctrl+/ comments.

create table teachers (id bigserial, firstname varchar(25), lastname varchar(50), school varchar(50), hiredate date, salary numeric); --bigserial integer type auto-increments every time you add a row to the table

insert into teachers (firstname, lastname, school, hiredate, salary)
values('Janet','Smith','F.D. Roosevelt HS','2011-10-30',36200),
('Lee','Reynolds','F.D. Roosevelt HS','1993-05-22',65000),
('Samuel','Cole','Myers Middle School','2005-08-01',43500),
('Samanta','Bush','Myers Middle School','2011-10-30',36200),
('Betty','Diaz','Myers Middle School','2005-08-30',43500),
('Kathleen','Roush','F.D. Roosevelt HS','2010-10-22',38500);
--Text and dates require single quotes.  Date format is yyyy-mm-dd which is the international standard for date formats.
