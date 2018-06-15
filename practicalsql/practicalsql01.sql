#Chapter 01 Creating Your First Database And Table (p 1)

create database analysis;  --create a database

create table teachers (id bigserial, first_name varchar(25), last_name varchar(50), school varchar(50), hire_date date, salary numeric);  --bigserial is an integer auto-increments every time you add a row

drop table teachers;  --delete table

insert into teachers (first_name, last_name, school, hire_date, salary)
values ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
       ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);
