#Chapter 02 Beginning Data Exploration With SELECT (p 11)
#RM:  analysis database

select *
from teachers;
select last_name, first_name, salary
from teachers
order by salary desc;
select distinct school
from teachers;  --eliminates duplicates returns unique values
select distinct school, salary
from teachers;  --eliminates duplicates returns unique pair of values in this case
select last_name, school, hire_date
from teachers
order by school asc, hire_date desc;  --RM:  we can sort a column in order by statement and exclude the column in select statement.
select last_name, hire_date
from teachers
where school = 'Myers Middle School'
order by hire_date desc;  --Single quotes valid only.  We can restrict data in where clause and exclude the column(s) in select statement.

/* BETWEEN, IN, LIKE, ILIKE, NOT are valid.  BETWEEN is inclusive.  ILIKE is case insensitive PostgreSQL only.  Use % as wildcard. Use _ as single character wildcard.  */
select first_name, last_name, school, salary
from teachers
where salary between 40000 and 65000;
select first_name
from teachers
where first_name ilike 'sam%';  --ILIKE is case insensitive PostgreSQL only
select *
from teachers
where school = 'Myers Middle School' and salary < 40000;
select *
from teachers
where last_name = 'Cole' or last_name = 'Bush';
select *
from teachers
where school = 'F.D. Roosevelt HS' and (salary < 38000 or salary > 40000);