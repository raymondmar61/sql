#[ORACLE DATABASE TUTORIALS] LECTURE 9 DESCRIBE COMMAND - YouTube [720p]
desc employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 10 SQL STATEMENT BASICS - YouTube [720p]
select *
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 11 USING SELECT STATEMENT - YouTube [720p]
select first_name, last_name, email
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 12 USING COLUMN ALIASES - YouTube [720p]
select first_name as name, last_name as "two words between double quotes", email, salary*12 as "Yearly Salary"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 13 QUOTE (Q) OPERATOR - YouTube [720p]
select 'Oracle dual dummy database'
from dual;
select *
from employees
where first_name = 'Steven'
and last_name = 'King';
select first_name as "The double quote""s first name"
from employees;
#select first_name as "The double quote\"s first name"
#from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 14 DISTINCT OPERATOR - YouTube [720p]
select distinct job_id
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 15 CONCATENATION OPERATORS - YouTube [720p]
select 'My name is ' || first_name as "First Name"
from employees;
select first_name || ' ' || last_name as "Employee Name"
from employees;
select concat('My first name is ', first_name)
from employees;  #Must use concat for MySQL
select city, state_province, concat(city,'-',state_province)
from locations;

#[ORACLE DATABASE TUTORIALS] LECTURE 16 ARITHMETIC EXPRESSIONS AND NULL VALUES - YouTube [720p]
select employee_id, salary, salary*12 as "Annual Salary"
from employees;
select hire_date, date_add(hire_date,interval 5 day) as "Add five days"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 17 USING WHERE CLAUSE - YouTube [720p]
select *
from employees;
select *
from employees
where salary > 10000;
select *
from employees
where job_id = 'IT_PROG';

#[ORACLE DATABASE TUTORIALS] LECTURE 18 COMPARISON OPERATORS - YouTube [720p]
select *
from employees
where hire_date > '1/1/2005';  #Incorrect
select *
from employees
where hire_date > '2005-01-01';  #Correct
select *
from employees
where hire_date = '2007-05-21';
select *
from employees
where manager_id != 100;
#or
select *
from employees
where manager_id <> 100;

#[ORACLE DATABASE TUTORIALS] LECTURE 19 BETWEEN ... AND OPERATOR - YouTube [720p]
select first_name, last_name, salary
from employees
where salary between 10000 and 15000; #10,000 and 15,000 are included
select *
from employees
where hire_date between '2002-01-02' and '2005-01-29';

#[ORACLE DATABASE TUTORIALS] LECTURE 20 IN OPERATOR - YouTube [720p]
select employee_id, first_name, last_name, salary, manager_id
from employees
where employee_id in (100, 105, 102, 200);
select *
from employees
where first_name in ('Steven','Peter','Adam','aa');
select *
from employees
where hire_date in ('2008-03-08','2005-01-30',sysdate);  #sysdate invalid in phpMyAdmin.  MySQL use curdate() for today's date.

#[ORACLE DATABASE TUTORIALS] LECTURE 21 LIKE OPERATOR - YouTube [720p]
select first_name, last_name
from employees
where first_name like 'A%';
select first_name
from employees
where first_name like '_r%'; #search first names the second character is lower case r.
select *
from employees
where job_id like 'SA%';

#[ORACLE DATABASE TUTORIALS] LECTURE 22 IS NULL OPERATOR - YouTube [720p]
#RM:  I needed to set Steven and employee_id 100 to NULL
update employees
set manager_id = NULL
where employee_id = 100;
select first_name
from employees
where manager_id is NULL;
select first_name
from employees
where manager_id = NULL;  #error message on phpMyAdmin
#RM:  I needed to set commission_pct to NULL for employees not earning a commission perceneteage
update employees
set commission_pct = NULL
where commission_pct = 0.00;
select *
from employees
where commission_pct is NULL;

#[ORACLE DATABASE TUTORIALS] LECTURE 23 LOGICAL OPERATORS (AND, OR, NOT) - YouTube [720p]
select *
from employees
where job_id = 'SA_REP'
and salary > 10000;
select *
from employees
where job_id = 'SA_REP'
or salary > 10000;
select first_name, last_name, salary, job_id
from employees
where job_id = 'IT_PROG'
and salary >= 5000;
select first_name, last_name, salary, job_id
from employees
where job_id = 'IT_PROG'
or salary >= 5000;
select *
from employees
where salary > 10000
and job_id not in ('SA_MAN','ST_CLERK','SH_CLERK');

#[ORACLE DATABASE TUTORIALS] LECTURE 24 RULES OF PRECEDENCE - YouTube [720p]
select first_name, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or job_id = 'ST_CLERK'
and salary > 5000;
select first_name, last_name, job_id, salary
from employees
where (job_id = 'IT_PROG'
or job_id = 'ST_CLERK')
and salary > 5000;
select first_name, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or (job_id = 'ST_CLERK'
and salary > 5000);

#[ORACLE DATABASE TUTORIALS] LECTURE 25 ORDER BY CLAUSE - YouTube [720p]
select first_name, last_name, salary
from employees
order by last_name;
select first_name, last_name, salary
from employees
order by salary desc;

#[ORACLE DATABASE TUTORIALS] LECTURE 26 ASC AND DESC OPERATORS - YouTube [720p]
select first_name, last_name, salary
from employees
order by first_name, last_name;
select first_name, last_name, salary*12 as yearysalary
from employees
order by first_name, yearysalary;
select first_name, salary, commission_pct
from employees
order by first_name desc, last_name asc;

#[ORACLE DATABASE TUTORIALS] LECTURE 27 NULLS FIRST AND NULLS LAST OPERATORS - YouTube [720p]
select first_name, salary, commission_pct
from employees
order by commission_pct nulls first;
#sort by column position
select first_name, salary, commission_pct
from employees
order by 3;  #sort by commission_pct as the third column
select *
from employees
order by 5;  #sort by the fifth column which is the phone_number in results
select *
from employees
order by 1 desc, 2 asc;  #sort by the first column employee_id and then the second column first_name in results

#[ORACLE DATABASE TUTORIALS] LECTURE 28 SINGLE ROW FUNCTIONS - YouTube [720p]

#[ORACLE DATABASE TUTORIALS] LECTURE 29 CHARACTER FUNCTIONS (PART 1) - YouTube [720p]
#initcap(first_name) not valid in MySQL
select first_name, lower(first_name), upper(first_name), initcap(first_name)
from employees;
#A solution for one word string
select first_name, lower(first_name), upper(first_name),  concat(upper(left(first_name,1)),mid(first_name,2))
from employees;
select first_name, upper(first_name), lower(last_name), email, upper('MY name is Ellen')
from employees
where upper(last_name) = 'KING';
select first_name, substr(first_name,5,3) as 'return three characters starting at 5th position', length(first_name), concat(first_name, ' ', last_name)
from employees;
/*
first_name	return three characters starting at 5th position	length(first_name)	concat(first_name, ' ', last_name)	
Steven	en	6	Steven King	
Neena	a	5	Neena Kochhar	
Lex		3	Lex De Haan	
Alexander	and	9	Alexander Hunold	
Bruce	e	5	Bruce Ernst	
David	d	5	David Austin	
Valli	i	5	Valli Pataballa	
Diana	a	5	Diana Lorentz	
Nancy	y	5	Nancy Greenberg	
Daniel	el	6	Daniel Faviet	
John		4	John Chen	
Ismael	el	6	Ismael Sciarra	
Jose Manuel	 Ma	11	Jose Manuel Urman	
Luis		4	Luis Popp	
Den		3	Den Raphaely	
Alexander	and	9	Alexander Khoo	
Shelli	li	6	Shelli Baida	
Sigal	l	5	Sigal Tobias	
Guy		3	Guy Himuro	
Karen	n	5	Karen Colmenares	
Matthew	hew	7	Matthew Weiss	
Adam		4	Adam Fripp	
Payam	m	5	Payam Kaufling	
Shanta	ta	6	Shanta Vollman	
Kevin	n	5	Kevin Mourgos	
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 30 CHARATER FUNCTION (PART 2) - YouTube [720p]
select first_name, last_name, concat(first_name, ' ', last_name), first_name && ' ' && last_name as 'concatenate with pipes || in Oracle SQL Not MySQL'
from employees;
select first_name, instr(first_name,'a') as 'Return position number for letter a'
from employees;
select first_name, replace(first_name,'a','-') as "Replace letter a lower case with a hyphen -"
from employees;
select first_name, lpad(first_name,15,'-') as "First name must have 15 characters fill left with -"
from employees;
select first_name, rpad(first_name,15,'-') as "First name must have 15 characters fill right with -"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 31 NUMBER FUNCTIONS - YouTube [720p]
select salary, commission_pct, salary*commission_pct, salary/commission_pct, round(salary/commission_pct,2), trunc(salary/commission_pct,2), ceil(salary/commission_pct), floor(salary/commission_pct), mod(salary, commission_pct)
from employees
where commission_pct is not null;
/*
RM:  selected rows posted
salary	commission_pct	salary*commission_pct	salary/commission_pct	round(salary/commission_pct,2)	trunc(salary/commission_pct,2)	ceil(salary/commission_pct)	floor(salary/commission_pct)	mod(salary, commission_pct)	
10000	0.30	3000.00	33333.3333	33333.33	33333.33	33334	33333	0.10	
7000	0.15	1050.00	46666.6667	46666.67	46666.66	46667	46666	0.10	
10000	0.35	3500.00	28571.4286	28571.43	28571.42	28572	28571	0.15	
9500	0.35	3325.00	27142.8571	27142.86	27142.85	27143	27142	0.30	
9000	0.35	3150.00	25714.2857	25714.29	25714.28	25715	25714	0.10	
8000	0.30	2400.00	26666.6667	26666.67	26666.66	26667	26666	0.20	
7500	0.30	2250.00	25000.0000	25000.00	25000.00	25000	25000	0.00	
7000	0.25	1750.00	28000.0000	28000.00	28000.00	28000	28000	0.00	
7200	0.10	720.00	72000.0000	72000.00	72000.00	72000	72000	0.00	
6800	0.10	680.00	68000.0000	68000.00	68000.00	68000	68000	0.00	
6400	0.10	640.00	64000.0000	64000.00	64000.00	64000	64000	0.00	
6200	0.10	620.00	62000.0000	62000.00	62000.00	62000	62000	0.00	
11500	0.25	2875.00	46000.0000	46000.00	46000.00	46000	46000	0.00	
10000	0.20	2000.00	50000.0000	50000.00	50000.00	50000	50000	0.00	
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 32 NESTING FUNCTIONS - YouTube [720p]
select first_name, last_name, lpad(upper(concat(first_name, last_name)),20,'*') as "Concat first name and last name upper case must be 20 characters fill rest with * on left"
from employees;
/*
first_name	last_name	Concat first name and last name upper case must be 20 characters fill rest with * on left	
Steven	King	**********STEVENKING	
Neena	Kochhar	********NEENAKOCHHAR	
Lex	De Haan	**********LEXDE HAAN	
Alexander	Hunold	*****ALEXANDERHUNOLD	
Bruce	Ernst	**********BRUCEERNST	
David	Austin	*********DAVIDAUSTIN	
Valli	Pataballa	******VALLIPATABALLA	
Diana	Lorentz	********DIANALORENTZ	
Nancy	Greenberg	******NANCYGREENBERG	
Daniel	Faviet	********DANIELFAVIET	
John	Chen	************JOHNCHEN	
Ismael	Sciarra	*******ISMAELSCIARRA	
Jose Manuel	Urman	****JOSE MANUELURMAN
...
*/
select first_name, last_name, concat(first_name, ' ', last_name), replace(concat(first_name, ' ', last_name),' ','!')
from employees;
/*
first_name	last_name	concat(first_name, ' ', last_name)	replace(concat(first_name, ' ', last_name),' ','!')	
Steven	King	Steven King	Steven!King	
Neena	Kochhar	Neena Kochhar	Neena!Kochhar	
Lex	De Haan	Lex De Haan	Lex!De!Haan	
Alexander	Hunold	Alexander Hunold	Alexander!Hunold	
Bruce	Ernst	Bruce Ernst	Bruce!Ernst	
David	Austin	David Austin	David!Austin	
Valli	Pataballa	Valli Pataballa	Valli!Pataballa	
Diana	Lorentz	Diana Lorentz	Diana!Lorentz	
Nancy	Greenberg	Nancy Greenberg	Nancy!Greenberg	
Daniel	Faviet	Daniel Faviet	Daniel!Faviet	
John	Chen	John Chen	John!Chen	
Ismael	Sciarra	Ismael Sciarra	Ismael!Sciarra	
Jose Manuel	Urman	Jose Manuel Urman	Jose!Manuel!Urman	
...
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 33 DATE OPERATORS - YouTube [720p]
select hire_date
from employees;
/*
RM:  Oracle default date display and internal database date format
hire_date
2003-06-17
2005-09-21
2001-01-13
2006-01-03
2007-05-21
2005-06-25
2006-02-05
...
*/
select hire_date, sysdate() as "system's date", current_date as "current date from user's session", current_timestamp
from employees  #mySQL
select hire_date, sysdate as "system's date", current_date as "current date from user's session", sessiontimezone, current_timestamp
from employees;  #Oracle
select hire_date, hire_date+4 as "Add four days"
from employees