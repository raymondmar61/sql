#phpMyAdmin innova18_w3hrstevenking database

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
first_name  return three characters starting at 5th position    length(first_name)  concat(first_name, ' ', last_name)  
Steven  en  6   Steven King 
Neena   a   5   Neena Kochhar   
Lex     3   Lex De Haan 
Alexander   and 9   Alexander Hunold    
Bruce   e   5   Bruce Ernst 
David   d   5   David Austin    
Valli   i   5   Valli Pataballa 
Diana   a   5   Diana Lorentz   
Nancy   y   5   Nancy Greenberg 
Daniel  el  6   Daniel Faviet   
John        4   John Chen   
Ismael  el  6   Ismael Sciarra  
Jose Manuel  Ma 11  Jose Manuel Urman   
Luis        4   Luis Popp   
Den     3   Den Raphaely    
Alexander   and 9   Alexander Khoo  
Shelli  li  6   Shelli Baida    
Sigal   l   5   Sigal Tobias    
Guy     3   Guy Himuro  
Karen   n   5   Karen Colmenares    
Matthew hew 7   Matthew Weiss   
Adam        4   Adam Fripp  
Payam   m   5   Payam Kaufling  
Shanta  ta  6   Shanta Vollman  
Kevin   n   5   Kevin Mourgos   
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
salary  commission_pct  salary*commission_pct   salary/commission_pct   round(salary/commission_pct,2)  trunc(salary/commission_pct,2)  ceil(salary/commission_pct) floor(salary/commission_pct)    mod(salary, commission_pct) 
10000   0.30    3000.00 33333.3333  33333.33    33333.33    33334   33333   0.10    
7000    0.15    1050.00 46666.6667  46666.67    46666.66    46667   46666   0.10    
10000   0.35    3500.00 28571.4286  28571.43    28571.42    28572   28571   0.15    
9500    0.35    3325.00 27142.8571  27142.86    27142.85    27143   27142   0.30    
9000    0.35    3150.00 25714.2857  25714.29    25714.28    25715   25714   0.10    
8000    0.30    2400.00 26666.6667  26666.67    26666.66    26667   26666   0.20    
7500    0.30    2250.00 25000.0000  25000.00    25000.00    25000   25000   0.00    
7000    0.25    1750.00 28000.0000  28000.00    28000.00    28000   28000   0.00    
7200    0.10    720.00  72000.0000  72000.00    72000.00    72000   72000   0.00    
6800    0.10    680.00  68000.0000  68000.00    68000.00    68000   68000   0.00    
6400    0.10    640.00  64000.0000  64000.00    64000.00    64000   64000   0.00    
6200    0.10    620.00  62000.0000  62000.00    62000.00    62000   62000   0.00    
11500   0.25    2875.00 46000.0000  46000.00    46000.00    46000   46000   0.00    
10000   0.20    2000.00 50000.0000  50000.00    50000.00    50000   50000   0.00    
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 32 NESTING FUNCTIONS - YouTube [720p]
select first_name, last_name, lpad(upper(concat(first_name, last_name)),20,'*') as "Concat first name and last name upper case must be 20 characters fill rest with * on left"
from employees;
/*
first_name  last_name   Concat first name and last name upper case must be 20 characters fill rest with * on left   
Steven  King    **********STEVENKING    
Neena   Kochhar ********NEENAKOCHHAR    
Lex De Haan **********LEXDE HAAN    
Alexander   Hunold  *****ALEXANDERHUNOLD    
Bruce   Ernst   **********BRUCEERNST    
David   Austin  *********DAVIDAUSTIN    
Valli   Pataballa   ******VALLIPATABALLA    
Diana   Lorentz ********DIANALORENTZ    
Nancy   Greenberg   ******NANCYGREENBERG    
Daniel  Faviet  ********DANIELFAVIET    
John    Chen    ************JOHNCHEN    
Ismael  Sciarra *******ISMAELSCIARRA    
Jose Manuel Urman   ****JOSE MANUELURMAN
...
*/
select first_name, last_name, concat(first_name, ' ', last_name), replace(concat(first_name, ' ', last_name),' ','!')
from employees;
/*
first_name  last_name   concat(first_name, ' ', last_name)  replace(concat(first_name, ' ', last_name),' ','!') 
Steven  King    Steven King Steven!King 
Neena   Kochhar Neena Kochhar   Neena!Kochhar   
Lex De Haan Lex De Haan Lex!De!Haan 
Alexander   Hunold  Alexander Hunold    Alexander!Hunold    
Bruce   Ernst   Bruce Ernst Bruce!Ernst 
David   Austin  David Austin    David!Austin    
Valli   Pataballa   Valli Pataballa Valli!Pataballa 
Diana   Lorentz Diana Lorentz   Diana!Lorentz   
Nancy   Greenberg   Nancy Greenberg Nancy!Greenberg 
Daniel  Faviet  Daniel Faviet   Daniel!Faviet   
John    Chen    John Chen   John!Chen   
Ismael  Sciarra Ismael Sciarra  Ismael!Sciarra  
Jose Manuel Urman   Jose Manuel Urman   Jose!Manuel!Urman   
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

#[ORACLE DATABASE TUTORIALS] LECTURE 34 DATE FUNCTIONS
select hire_date, add_months(hire_date,1) as "Add one month"
from employees;
select start_date, end_date, months_between(start_date, end_date) as "Number of months between"
from jobhistory;
select hire_date, round(hire_date, 'month') as "Round date up if day is 15 or greater", trunc(hire_date, 'year') as "Truncate date by year"
from employees;
select hire_date, next_day(hire_date,'Tuesday') as "Returns next specified name day after hire_date"
from employees;
select hire_date, last_day(hire_date) as "Last day of the hire_date's month"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 35 CONVERSION FUNCTIONS - YouTube [720p]
select *
from employees
where hire_date = '2003-06-17';
select *
from employees
where department_id = '90'; #Oracle convert string number to number because column department_id is formatted as number.  RM:  bad habit to add quotes to numbers when column is number format.

#[ORACLE DATABASE TUTORIALS] LECTURE 36 TO_CHAR, TO _DATE, TO_NUMBER FUNCTIONS (PART 1) - YouTube [720p]
select first_name, last_name, hire_date, to_char(hire_date,'YYYY') as "Extract year"
from employees;
select first_name, last_name, hire_date, to_char(hire_date,'YY') as "Extract year two digits"
from employees;
select first_name, last_name, hire_date, to_char(hire_date,'YEAR') as "Extract year text"
from employees;
select first_name, last_name, hire_date, to_char(hire_date,'Mon') as "Extract month abbreviation Jan May Dec"
from employees;
select first_name, last_name, hire_date, to_char(hire_date,'MONTH') as "Extract month JANUARY MAY DECEMBER"
from employees;
#mysql
select first_name, last_name, hire_date, year(hire_date) as "Extract year"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 37 TO_CHAR, TO_DATE, TO_NUMBER FUNCTIONS (PART 2) - YouTube [720p]
select employee_id, to_char(employee_id, "dd") as "Ordinal number 5"
from employees;
#or
select employee_id, to_char(employee_id, "ddth") as "Ordinal number 5th"
from employees;
select employee_id, to_char(employee_id, "ddsp") as "Spelling number spelling text four"
from employees;
select salary, to_char(salary, '$99,999.99') as "$24,000.00 $9,000.00 $12,008.00"
from employees;
select salary*commission_pct, to_char(salary*commission_pct,'$99,9999.99') as "$680.00 $2,250.00"
from employees
where commission_pct is not null
select salary*commission_pct, to_char(salary*commission_pct,'$099,9999.99') as "$000,680.00 $002,250.00"
from employees
where commission_pct is not null
select first_name, last_name, hire_date
from employees
where hire_date > to_date('Jun 12, 2005','Mon DD, YYYY');

#[ORACLE DATABASE TUTORIALS] LECTURE 38 NVL, NVL2, NULLIF, COALESCE FUNCTIONS - YouTube [720p]
select job_id, first_name, last_name, commission_pct, nvl(commission_pct,0) as "Display 0 if commission_pct is null"
from employees;
#mysql
select job_id, first_name, last_name, commission_pct, ifnull(commission_pct,0) as "Display 0 if commission_pct is null"
from employees;
select job_id, first_name, last_name, commission_pct, nvl2(commission_pct,"There is a commission_pct","There is no commission_pct") as "If not null, then first quote, else second quote"
from employees;
select state_province, city, coalesce(state_province, city, "Return no state_province no city") as "Check if state_province, city null.  If both true, then display Return no state_province no city"
from locations;

#[ORACLE DATABASE TUTORIALS] LECTURE 39 CONDITIONAL EXPRESSIONS (CASE-DECODE) - YouTube [720p]
select first_name, last_name, job_id, salary, hire_date, case job_id when 'ST_MAN' then salary*1.2 when 'SH_MAN' then salary*1.3 when 'SA_MAN' then 1.4*salary else salary end as "Update Salary name case column"
from employees
where job_id in ('ST_MAN','SH_MAN','SA_MAN');
/*
first_name  last_name   job_id  salary  hire_date   Update Salary name case column  
Matthew Weiss   ST_MAN  8000    2004-07-18  9600.0  
Adam    Fripp   ST_MAN  8200    2005-04-10  9840.0  
Payam   Kaufling    ST_MAN  7900    2003-05-01  9480.0  
Shanta  Vollman ST_MAN  6500    2005-10-10  7800.0  
Kevin   Mourgos ST_MAN  5800    2007-11-16  6960.0  
John    Russell SA_MAN  14000   2004-10-01  19600.0 
Karen   Partners    SA_MAN  13500   2005-01-05  18900.0 
Alberto Errazuriz   SA_MAN  12000   2005-03-10  16800.0 
Gerald  Cambrault   SA_MAN  11000   2007-10-15  15400.0 
Eleni   Zlotkey SA_MAN  10500   2008-01-29  14700.0 
*/
select first_name, last_name, job_id, salary as "return rows where clause equals one IT_PROG and SA_MAN"
from employees
where (case
    when job_id = 'IT_PROG' and salary > 5000 then 1
    when job_id = 'SA_MAN' and salary > 10000 then 1
    else 0 end) = 1;
/*
first_name  last_name   job_id  return rows where clause equals one IT_PROG and SA_MAN  
Alexander   Hunold  IT_PROG 9000    
Bruce   Ernst   IT_PROG 6000    
John    Russell SA_MAN  14000   
Karen   Partners    SA_MAN  13500   
Alberto Errazuriz   SA_MAN  12000   
Gerald  Cambrault   SA_MAN  11000   
Eleni   Zlotkey SA_MAN  10500   
*/
select first_name, last_name, job_id, salary, hire_date, decode(job_id, 'ST_MAN', salary*1.2, 'SH_MAN', salary*1.3, 'SA_MAN', 1.4*salary) as "Update salary name decode column"
from employees
where job_id in ('ST_MAN','SH_MAN','SA_MAN');  #decode is Oracle specific

#[ORACLE DATABASE TUTORIALS] LECTURE 40 GROUP FUNCTIONS - YouTube [720p]
#avg, count, max, min, sum  Group function types.  Null values ignored by default.

#[ORACLE DATABASE TUTORIALS] LECTURE 41 AVG FUNCTION - YouTube [720p]
select avg(salary), avg(all salary) as "All salaries", avg(distinct salary) as "Distinct salaries"
from employees;
/*
avg(salary) All salaries Distinct salaries
6461.8318 6461.8318 7067.3793
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 42 COUNT FUNCTION - YouTube [720p]
select count(*), count(manager_id) as "Count manager_id", count(all manager_id), count(distinct manager_id)
from employees;
/*
count(*) Count manager_id count(all manager_id) count(distinct manager_id)
107 106 106 18
*/
select count(*), count(commission_pct) as "Count rows with commission_pct", count(distinct commission_pct), count(nvl(commission_pct,0)) as "Return 0 if commission_pct is null"
from employees;
select count(*), count(commission_pct) as "Count rows with commission_pct", count(distinct commission_pct), count(ifnull(commission_pct,0)) as "mysql Return 0 if commission_pct is null"
from employees;
/*
count(*) Count rows with commission_pct count(distinct commission_pct) mysql Return 0 if commission_pct is null
107 35 7 107
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 43 MAX FUNCTION - YouTube [720p]
select max(salary), max(hire_date), max(first_name)
from employees;
/*
max(salary) max(hire_date) max(first_name)
24000   2008-04-21  Winston 
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 44 MIN FUNCTION - YouTube [720p]
select min(commission_pct), min(nvl(commission_pct,0)) as "Return 0 if commission_pct is null", min(hire_date), min(first_name)
from employees;
select min(commission_pct), min(ifnull(commission_pct,0)) as "mysql Return 0 if commission_pct is null", min(hire_date), min(first_name)
from employees;
/*
min(commission_pct) mysql Return 0 if commission_pct is null min(hire_date) min(first_name)
0.10 0.00 2001-01-13 Adam
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 45 SUM FUNCTION - YouTube [720p]
select sum(salary), sum(distinct salary) as "Sum distinct salaries"
from employees;
/*
sum(salary) Sum distinct salaries
691416 409908
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 46 OVERVIEW OF GROUP FUNCTION - YouTube [720p]
select min(salary), max(hire_date), avg(salary), count(*)
from employees;
/*
min(salary) max(hire_date) avg(salary) count(*)
2100 2008-04-21 6461.8318 107
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 47 GROUP BY CLAUSE - YouTube [720p]
select avg(salary)
from employees;

select avg(salary)
from employees
where job_id = 'IT_PROG';

select department_id, avg(salary) #divide rows into smaller groups
from employees
group by department_id
order by avg(salary);

select job_id, avg(salary)
from employees
group by job_id;

select job_id, department_id, manager_id, avg(salary) #RM:  the arrangement columns from left to right in select and group by are different
from employees
group by department_id, job_id, manager_id;

select avg(salary)
from employees
group by job_id;

select avg(salary), sum(salary), min(salary), max(salary), count(*)
from employees
group by department_id
order by avg(salary);

select department_id as "departments ID Number", avg(salary)
from employees
group by department_id
order by "departments ID Number";

select department_id, avg(salary) as "Average Salary"
from employees
where job_id in ('ST_MAN','SH_CLERK','ST_CLERK')
group by job_id, department_id
order by "Average Salary";

select job_id, avg(salary), sum(salary), max(hire_date)
from employees
where job_id in ('IT_PROG','ST_MAN','AC_ACCOUNT')
group by job_id;

#[ORACLE DATABASE TUTORIALS] LECTURE 48 HAVING [CLAUSE] - YouTube [720p]
select job_id, avg(salary) as "All Average Salaries"
from employees
group by job_id;

select job_id, avg(salary) as "Average Salaries Greater Than 10,000"
from employees
group by job_id
having avg(salary) > 10000;

select job_id, avg(salary)
from employees
where hire_date > '2000-01-21'
group by job_id
having avg(salary) > 10000;

#[ORACLE DATABASE TUTORIALS] LECTURE 49 NESTING GROUP FUNCTIONS - YouTube [720p]
select department_id, max(avg(salary))
from employees
group by department_id; #error message

select max(avg(salary))
from employees
group by department_id; #return 1933.33

#[ORACLE DATABASE TUTORIALS] LECTURE 50 JOINING MULTIPLE TABLES AND TYPES OF JOINS - YouTube [720p]
select *
from employees;

select *
from departments;

#[ORACLE DATABASE TUTORIALS] LECTURE 51 NATURAL JOINS - YouTube [720p]
select first_name, last_name, department_id
from employees natural join departments; #manager_id and departments columns department_id and manager_id are the common columns

select *
from employees natural join departments; #returns 32 rows.  Employee Steven King is not returned because manager_id is null.  Departments table there is no manager_id is null and department_id is 90.  Also matching columns manager_id and department_id between employees and departments are the leftmost columns.

#[ORACLE DATABASE TUTORIALS] LECTURE 52 JOIN WITH USING CLAUSE - YouTube [720p]
select *
from employees join departments
using (department_id); #parenthesis is required.  Steven King is returned because department_id matches.

select *
from employees join departments
using (department_id, manager_id); #parenthesis is required.  Steven King is not returned because department_id matches and manager_id doesn't match.

select first_name, last_name, department_id
from employees join departments
using (department_id);  #parenthesis is required.

select * from employees join departments using (department_id); #parenthesis is required.  Steven King is returned because department_id matches. select * from employees join departments using (department_id, manager_id); #parenthesis is required.  Steven King is not returned because department_id matches and manager_id doesn't match. select first_name, last_name, department_id from employees join departments using (department_id);  #parenthesis is required.

#[ORACLE DATABASE TUTORIALS] LECTURE 53 HANDLING AMBIGUOUS COLUMN NAMES - YouTube [720p]
select first_name, last_name, department_name, manager_id
from employees join departments
using (department_name); #error message because manager_id is common in employees table and departments table

select first_name, last_name, department_name, e.manager_id
from employees e join departments d
using (department_id); #table aliases on the immediate right of table name

select e.first_name, e.last_name, d.department_name, e.manager_id
from employees e join departments d
using (d.department_name); #Can't give an alias to a column that us in the using clause or natural join

select e.first_name, e.last_name, d.department_name, e.manager_id
from departments d join employees e
using (d.department_name); #Can't give an alias to a column that us in the using clause or natural join

select e.first_name, e.last_name, d.department_name, e.manager_id
from employees e join departments d
using (manager_id); #Can't give an alias to a column that us in the using clause or natural join; however, MySQL SQL code works.

select e.first_name, e.last_name, d.department_name, manager_id
from employees e join departments d
using (manager_id); #works

select e.first_name, e.last_name, d.department_name, e.manager_id from employees e join departments d using (d.department_name); #Can't give an alias to a column that us in the using clause or natural join select e.first_name, e.last_name, d.department_name, e.manager_id from departments d join employees e using (d.department_name); #Can't give an alias to a column that us in the using clause or natural join select e.first_name, e.last_name, d.department_name, e.manager_id from employees e join departments d using (manager_id); #Can't give an alias to a column that us in the using clause or natural join; however, MySQL SQL code works. select e.first_name, e.last_name, d.department_name, manager_id from employees e join departments d using (manager_id); #works

#[ORACLE DATABASE TUTORIALS] LECTURE 54 JOIN WITH ON CLAUSE - YouTube [720p]
select e.first_name, e.last_name, d.manager_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = d.manager_id;
#same as
select e.first_name, e.last_name, manager_id, d.department_name
from employees e join departments d
using (department_id, manager_id);

#[ORACLE DATABASE TUTORIALS] LECTURE 55 MULTIPLE JOIN OPERATIONS - YouTube [720p]
select e.first_name, e.last_name, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id;

#[ORACLE DATABASE TUTORIALS] LECTURE 56 RESTRICTING JOINS - YouTube [720p]
select e.first_name, e.last_name, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
where d.department_id = 100;

select e.first_name, e.last_name, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
and d.department_id = 100;

#[ORACLE DATABASE TUTORIALS] LECTURE 57 JOINING UNEQUAL TABLES - YouTube [720p]
#Using between . . . and or using comparison operators
select e.first_name, e.last_name, js.job_title, e.salary, js.min_salary, js.max_salary
from employees e join jobs js
on e.salary between js.min_salary and js.max_salary; #job_salaries table is jobs table in my MySQL innovateinfinitely.com phpMyAdmin.
#same as
select e.first_name, e.last_name, js.job_title, e.salary, js.min_salary, js.max_salary
from employees e join jobs js
on e.salary >= js.min_salary
and e.salary <= js.max_salary; #job_salaries table is jobs table in my MySQL innovateinfinitely.com phpMyAdmin.

select e.first_name, e.last_name, js.job_title, e.salary, js.min_salary, js.max_salary
from employees e join jobs js
on e.salary >= js.min_salary
and e.salary <= js.max_salary
and e.job_id = js.job_id; #for my phpMyAdmin, there was cartesian cross join.  I needed the e.job_id = js.job_id

#[ORACLE DATABASE TUTORIALS] LECTURE 58 SELF JOIN - YouTube [720p]
select employee_id, first_name, last_name, manager_id
from employees;
/*
employee_id first_name  last_name   manager_id  
100 Steven  King        NULL    
101 Neena   Kochhar 100 
102 Lex De Haan 100 
103 Alexander   Hunold  102 
104 Bruce   Ernst   103 
105 David   Austin  103 
106 Valli   Pataballa   103 
107 Diana   Lorentz 103 
108 Nancy   Greenberg   101 
*/
select e.employee_id, e.first_name, e.last_name, e.manager_id, m.first_name as "Manager First Name", m.last_name as "Manager Last Name"
from employees e join employees m
on m.employee_id = e.manager_id;
/*
employee_id first_name  last_name   manager_id  Manager First Name  Manager Last Name   
101 Neena   Kochhar 100 Steven  King    
102 Lex De Haan 100 Steven  King    
103 Alexander   Hunold  102 Lex De Haan 
104 Bruce   Ernst   103 Alexander   Hunold  
105 David   Austin  103 Alexander   Hunold  
106 Valli   Pataballa   103 Alexander   Hunold  
107 Diana   Lorentz 103 Alexander   Hunold  
108 Nancy   Greenberg   101 Neena   Kochhar 
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 59 OUTER JOINS - YouTube [720p]

#[ORACLE DATABASE TUTORIALS] LECTURE 60 LEFT OUTER JOIN - YouTube [720p]
select e.first_name, e.last_name, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

#[ORACLE DATABASE TUTORIALS] LECTURE 61 RIGHT OUTER JOIN - YouTube [720p]
select e.first_name, e.last_name, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
/*
...
first_name last_name department_name
Michael Hartstein Marketing
Pat Fay Marketing
Susan Mavris Human Resources
Hermann Baer Public Relations
Shelley Higgins Accounting
William Gietz Accounting
NULL NULL Treasury
NULL NULL Corporate Tax
NULL NULL Control And Credit
NULL NULL Shareholder Services
NULL NULL Benefits
NULL NULL Manufacturing
NULL NULL Construction
NULL NULL Contracting
NULL NULL Operations
NULL NULL IT Support
NULL NULL NOC
NULL NULL IT Helpdesk
NULL NULL Government Sales
NULL NULL Retail Sales
NULL NULL Recruiting
NULL NULL Payroll
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 62 FULL OUTER JOIN - YouTube [720p]
select e.first_name, e.last_name, e.department_id, d.department_id as "Department ID d", d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
#https://stackoverflow.com/questions/4796872/how-to-do-a-full-outer-join-in-mysql
/*
SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION ALL
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id
WHERE t1.id IS NULL
*/
select *
from employees e
left join departments d on e.department_id = d.department_id
union
select *
from employees e
right join  departments d
on e.department_id = d.department_id;

#[ORACLE DATABASE TUTORIALS] LECTURE 63 CROSS JOIN (CARTESIAN PRODUCT) - YouTube [720p]
select e.first_name, e.last_name, e.department_id, d.department_id as "Department ID d", d.department_name
from employees e cross join departments d;

#[ORACLE DATABASE TUTORIALS] LECTURE 64 USING SUBQUERIES - YouTube [720p]
select salary
from employees
where employee_id = 201; #return 13000
select *
from employees
where salary > (
    select salary
    from employees
    where employee_id = 201);

#[ORACLE DATABASE TUTORIALS] LECTURE 65 SINGLE ROW SUBQUERIES - YouTube [720p]
select department_id
from employees
where employee_id = 201; #return 20
select *
from employees
where department_id = (
    select department_id
    from employees
    where employee_id = 201);
select *
from employees
where department_id = (
    select department_id
    from employees
    where employee_id = 201)
and salary > (
    select salary
    from employees
    where employee_id = 201);
select *
from employees
where hire_date = (
    select min(hire_date)
    from employees);

#[ORACLE DATABASE TUTORIALS] LECTURE 66 MULTIPLE ROW SUBQUERIES - YouTube [720p]
select first_name, last_name, department_id, salary
from employees
where salary in (14000, 15000, 10000);
select first_name, last_name, department_id, salary as "Salaries are the minimums in departments"
from employees
where salary in (
    select min(salary)
    from employees
    group by department_id);
/*
first_name  last_name   department_id   Salaries are the minimums in departments    
Neena   Kochhar 90  17000   
Lex De Haan 90  17000   
Bruce   Ernst   60  6000    
Diana   Lorentz 60  4200    
Luis    Popp    100 6900    
Karen   Colmenares  30  2500    
Shanta  Vollman 50  6500    
James   Marlow  50  2500    
TJ  Olson   50  2100    
Joshua  Patel   50  2500    
Peter   Vargas  50  2500    
Peter   Tucker  80  10000   
Oliver  Tuvault 80  7000    
Janette King    80  10000   
Sarath  Sewall  80  7000    
Harrison    Bloom   80  10000   
Sundita Kumar   80  6100    
Kimberely   Grant   0   7000    
Martha  Sullivan    50  2500    
Nandita Sarchand    50  4200    
Randall Perkins 50  2500    
Jennifer    Whalen  10  4400    
Pat Fay 20  6000    
Susan   Mavris  40  6500    
Hermann Baer    70  10000   
*/
select salary
from employees
where job_id = 'SA_MAN';
/*
salary  
14000   
13500   
12000   
11000   
10500   
*/
select first_name, last_name, department_id, salary as "Salaries are greater than the minimum in SA_MAN"
from employees
where salary > any (
    select salary
    from employees
    where job_id = 'SA_MAN');
/*
first_name  last_name   department_id   Salaries are greater than the minimum in SA_MAN  
Steven  King    90  24000   
Neena   Kochhar 90  17000   
Lex De Haan 90  17000   
Nancy   Greenberg   100 12008   
Den Raphaely    30  11000   
John    Russell 80  14000   
Karen   Partners    80  13500   
Alberto Errazuriz   80  12000   
Gerald  Cambrault   80  11000   
Lisa    Ozer    80  11500   
Ellen   Abel    80  11000   
Michael Hartstein   20  13000   
Shelley Higgins 110 12008   
*/
select first_name, last_name, department_id, salary as "Salaries are equal to any in SA_MAN"
from employees
where salary = any (
    select salary
    from employees
    where job_id = 'SA_MAN');
/*
first_name  last_name   department_id   Salaries are equal to any in SA_MAN 
Den Raphaely    30  11000   
John    Russell 80  14000   
Karen   Partners    80  13500   
Alberto Errazuriz   80  12000   
Gerald  Cambrault   80  11000   
Eleni   Zlotkey 80  10500   
Clara   Vishney 80  10500   
Ellen   Abel    80  11000   
*/
select first_name, last_name, department_id, salary as "Salaries are less than the maximum SA_MAN"
from employees
where salary < any (
    select salary
    from employees
    where job_id = 'SA_MAN');
/*
first_name  last_name   department_id   Salaries are less than the maximum SA_MAN   
Alexander   Hunold  60  9000    
Bruce   Ernst   60  6000    
David   Austin  60  4800    
Valli   Pataballa   60  4800    
Diana   Lorentz 60  4200    
Nancy   Greenberg   100 12008   
Daniel  Faviet  100 9000    
John    Chen    100 8200    
Ismael  Sciarra 100 7700    
Jose Manuel Urman   100 7800    
Luis    Popp    100 6900    
Den Raphaely    30  11000   
Alexander   Khoo    30  3100    
Shelli  Baida   30  2900    
Sigal   Tobias  30  2800    
Guy Himuro  30  2600    
Karen   Colmenares  30  2500    
Matthew Weiss   50  8000    
Adam    Fripp   50  8200    
Payam   Kaufling    50  7900    
Shanta  Vollman 50  6500    
Kevin   Mourgos 50  5800    
Julia   Nayer   50  3200    
Irene   Mikkilineni 50  2700    
James   Landry  50  2400    
...
*/
select first_name, last_name, department_id, salary as "Salaries are greater than the maximum in SA_MAN"
from employees
where salary > all (
    select salary
    from employees
    where job_id = 'SA_MAN');
/*
first_name  last_name   department_id   Salaries are greater than the maximum in SA_MAN 
Steven  King    90  24000   
Neena   Kochhar 90  17000   
Lex De Haan 90  17000   
*/
select first_name, last_name, department_id, salary as "Salaries are less than the minimum in SA_MAN"
from employees
where salary < all (
    select salary
    from employees
    where job_id = 'SA_MAN');
/*
first_name  last_name   department_id   Salaries are less than the maximum in SA_MAN    
Alexander   Hunold  60  9000    
Bruce   Ernst   60  6000    
David   Austin  60  4800    
Valli   Pataballa   60  4800    
Diana   Lorentz 60  4200    
Daniel  Faviet  100 9000    
John    Chen    100 8200    
Ismael  Sciarra 100 7700    
Jose Manuel Urman   100 7800    
Luis    Popp    100 6900    
Alexander   Khoo    30  3100    
Shelli  Baida   30  2900    
Sigal   Tobias  30  2800    
Guy Himuro  30  2600    
Karen   Colmenares  30  2500    
Matthew Weiss   50  8000    
Adam    Fripp   50  8200    
Payam   Kaufling    50  7900    
Shanta  Vollman 50  6500    
Kevin   Mourgos 50  5800    
Julia   Nayer   50  3200    
Irene   Mikkilineni 50  2700    
James   Landry  50  2400    
Steven  Markle  50  2200    
Laura   Bissot  50  3300    
...
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 67 MULTIPLE COLUMN SUBQUERIES - YouTube [720p]
select min(salary)
from employees
group by department_id;
/*  return 12 rows
min(salary)
7000
4400
6000
2500
6500
2100
4200
10000
6100
17000
6900
8300
*/
select first_name, last_name, department_id, salary
from employees
where salary in (
    select min(salary)
    from employees
    group by department_id);  #incorrectly get the employees who earn the minimmum salaries in all departments.  Actually getting employees earning salaries in the subquery.
/*
return 26 rows
first_name  last_name   department_id   salary  
Neena   Kochhar 90  17000   
Lex De Haan 90  17000   
Bruce   Ernst   60  6000    
Diana   Lorentz 60  4200    
Luis    Popp    100 6900    
Karen   Colmenares  30  2500    
Shanta  Vollman 50  6500    
James   Marlow  50  2500    
TJ  Olson   50  2100    
Joshua  Patel   50  2500    
Peter   Vargas  50  2500    
Peter   Tucker  80  10000   
Oliver  Tuvault 80  7000    
Janette King    80  10000   
Sarath  Sewall  80  7000    
Harrison    Bloom   80  10000   
Sundita Kumar   80  6100    
Kimberely   Grant   0   7000    
Martha  Sullivan    50  2500    
Nandita Sarchand    50  4200    
Randall Perkins 50  2500    
Jennifer    Whalen  10  4400    
Pat Fay 20  6000    
Susan   Mavris  40  6500    
Hermann Baer    70  10000   
*/
select department_id, min(salary)
from employees
group by department_id;
/*
department_id   min(salary) 
0   7000    
10  4400    
20  6000    
30  2500    
40  6500    
50  2100    
60  4200    
70  10000   
80  6100    
90  17000   
100 6900    
110 8300    
*/
select first_name, last_name, department_id, salary
from employees
where (department_id, salary) in (
    select department_id, min(salary)
    from employees
    group by department_id);  #correctly get employees earning salaries in the subquery.
/*
first_name  last_name   department_id   salary  
Neena   Kochhar 90  17000   
Lex De Haan 90  17000   
Diana   Lorentz 60  4200    
Luis    Popp    100 6900    
Karen   Colmenares  30  2500    
TJ  Olson   50  2100    
Sundita Kumar   80  6100    
Kimberely   Grant   0   7000    
Jennifer    Whalen  10  4400    
Pat Fay 20  6000    
Susan   Mavris  40  6500    
Hermann Baer    70  10000   
William Gietz   110 8300    
*/

select first_name, last_name, job_id, salary as "Employee highest salary in each job_id"
from employees
where (salary, job_id) in (
    select max(salary), job_id
    from employees
    group by job_id)
order by salary desc;

#[ORACLE DATABASE TUTORIALS] LECTURE 68 SET OPERATORS - YouTube [720p]
#bonus create table retired_employees
create table retired_employees (employee_id integer not null primary key, first_name varchar(15), last_name varchar(20), email varchar(20), phone_number varchar(20), hire_date date, job_id varchar(10), salary integer, commission_pct decimal(3,2), manager_id integer, department_id integer);
#bonus insert rows insert data retired_employees
insert into retired_employees
values(103, "Alexander","Hunold","AHUNOLD","590.423.4567","2006-01-03","IT_PROG",9000,0,102,60);
insert into retired_employees
values(104, "Bruce","Ernst","BERNST","590.423.4568","2007-05-21","IT_PROG",6000,0,103,60);
insert into retired_employees
values(105, "David","Austin","DAUSTIN","590.423.4569","2005-06-25","IT_PROG",4800,0,103,60);
insert into retired_employees
values(106, "Valli","Pataballa","VPATABAL","590.423.4560","2006-02-05","IT_PROG",4800,0,103,60);
insert into retired_employees
values(107, "Diana","Lorentz","DLORENTZ","590.423.4567","2007-02-07","IT_PROG",4200,0,103,60);
insert into retired_employees
values(207, "Omer","Dagasan","ODAGASAN","555.555.5555","1999-01-01","IT_PROG",10000,0,103,60);
select first_name, last_name as "Last name top query first query priority", salary
from retired_employees
union
select first_name, last_name, salary
from employees
order by first_name;
/*
first_name      Last name top query first query priority    salary  
Adam    Fripp   8200    
Alana   Walsh   3100    
Alberto Errazuriz   12000   
Alexander   Hunold  9000    
Alexander   Khoo    3100    
Alexis  Bull    4100    
Allan   McEwen  9000    
Alyssa  Hutton  8800    
Amit    Banda   6200    
Anthony Cabrio  3000    
Britney Everett 3900    
Bruce   Ernst   6000    
Charles Johnson 6200    
Christopher Olsen   8000    
...
*/  
select first_name, last_name as "UNION ALL includes duplicate rows", salary
from retired_employees
union all
select first_name, last_name, salary
from employees
order by first_name;
/*
first_name      Last name top query first query priority    salary  Duplicate rows Alexander Hunold and Bruce Ernst and David Austin
Adam    Fripp   8200    
Alana   Walsh   3100    
Alberto Errazuriz   12000   
Alexander   Hunold  9000    
Alexander   Khoo    3100    
Alexander   Hunold  9000    
Alexis  Bull    4100    
Allan   McEwen  9000    
Alyssa  Hutton  8800    
Amit    Banda   6200    
Anthony Cabrio  3000    
Britney Everett 3900    
Bruce   Ernst   6000    
Bruce   Ernst   6000    
Charles Johnson 6200    
Christopher Olsen   8000    
Clara   Vishney 10500   
Curtis  Davies  3100    
Daniel  Faviet  9000    
Danielle    Greene  9500    
David   Lee 6800    
David   Austin  4800    
David   Bernstein   9500    
David   Austin  4800    
Den Raphaely    11000   
*/
select first_name, last_name, salary
from retired_employees
intersect
select first_name, last_name, salary
from employees
order by first_name;
#MySQL does not support the INTERSECT operator. However, you can emulate the INTERSECT operator.  Source:  https://www.mysqltutorial.org/mysql-intersect/
select distinct r.employee_id, r.first_name, r.last_name, r.salary
from retired_employees r inner join employees e
using (employee_id);  #paranthesis is required
#or
select distinct employee_id, first_name, last_name, salary
from retired_employees
where employee_id in (
    select employee_id
    from employees);

#[ORACLE DATABASE TUTORIALS] LECTURE 69 UNION AND UNION AILL OPERATORS - YouTube [720p]
select first_name, last_name as "union eliminates duplicate rows", salary
from retired_employees
union
select first_name, last_name, salary
from employees
where job_id = "ID_PROG"
order by first_name;
/*
first_name      union eliminates duplicate rows salary  
Alexander   Hunold  9000    
Bruce   Ernst   6000    
David   Austin  4800    
Diana   Lorentz 4200    
Omer    Dagasan 10000   
Valli   Pataballa   4800    
*/
select first_name, last_name as "union all includes duplicate rows", email, salary, job_id
from retired_employees
union all
select first_name, last_name, email, salary, job_id
from employees
order by job_id, first_name;
/*
first_name      union all includes duplicate rows   email   salary  job_id   Duplicates Alexander Hunold, Bruce Ernst, David Austin, Diana Lorentz, Valli Pataballa; not duplicate Omer Dagasan 
William Gietz   WGIETZ  8300    AC_ACCOUNT  
Shelley Higgins SHIGGINS    12008   AC_MGR  
Jennifer    Whalen  JWHALEN 4400    AD_ASST 
Steven  King    SKING   24000   AD_PRES 
Lex De Haan LDEHAAN 17000   AD_VP   
Neena   Kochhar NKOCHHAR    17000   AD_VP   
Daniel  Faviet  DFAVIET 9000    FI_ACCOUNT  
Ismael  Sciarra ISCIARRA    7700    FI_ACCOUNT  
John    Chen    JCHEN   8200    FI_ACCOUNT  
Jose Manuel Urman   JMURMAN 7800    FI_ACCOUNT  
Luis    Popp    LPOPP   6900    FI_ACCOUNT  
Nancy   Greenberg   NGREENBE    12008   FI_MGR  
Susan   Mavris  SMAVRIS 6500    HR_REP  
Alexander   Hunold  AHUNOLD 9000    IT_PROG 
Alexander   Hunold  AHUNOLD 9000    IT_PROG 
Bruce   Ernst   BERNST  6000    IT_PROG 
Bruce   Ernst   BERNST  6000    IT_PROG 
David   Austin  DAUSTIN 4800    IT_PROG 
David   Austin  DAUSTIN 4800    IT_PROG 
Diana   Lorentz DLORENTZ    4200    IT_PROG 
Diana   Lorentz DLORENTZ    4200    IT_PROG 
Omer    Dagasan ODAGASAN    10000   IT_PROG 
Valli   Pataballa   VPATABAL    4800    IT_PROG 
Valli   Pataballa   VPATABAL    4800    IT_PROG 
Michael Hartstein   MHARTSTE    13000   MK_MAN      
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 70 INTERESCT OPERATOR - YouTube [720p]
select first_name, last_name as "intersect returns rows must be in both queries", email, salary, job_id
from retired_employees
intersect
select first_name, last_name, email, salary, job_id
from employees
order by first_name, job_id;
select first_name, last_name as "no intersect in MYSQL", email, salary, job_id
from retired_employees
where employee_id in (
    select employee_id
    from employees)
order by first_name;
/*
first_name      no intersect in MYSQL   email   salary  job_id  
Alexander   Hunold  AHUNOLD 9000    IT_PROG 
Bruce   Ernst   BERNST  6000    IT_PROG 
David   Austin  DAUSTIN 4800    IT_PROG 
Diana   Lorentz DLORENTZ    4200    IT_PROG 
Valli   Pataballa   VPATABAL    4800    IT_PROG 
*/
select distinct employee_id, first_name, last_name as "include distinct no intersect in MYSQL", email, salary, job_id
from retired_employees
where employee_id in (
    select employee_id
    from employees)
order by first_name;

#[ORACLE DATABASE TUTORIALS] LECTURE 71 MINUS OPERATOR - YouTube [720p]
select first_name, last_name as "return rows in first query and not in second query", email, salary, job_id
from retired_employees
minus
select first_name, last_name, email, salary, job_id
from employees
order by first_name, job_id;
#MySQL does not support the MINUS operator.  Use the JOIN clause.  Source:  https://www.mysqltutorial.org/mysql-minus/
select e.employee_id as "e", r.employee_id as "r", r.first_name, r.last_name as "MYSQL left join return rows in first query and not in second query", r.email, r.salary, r.job_id
from retired_employees r left join employees e
on r.employee_id = e.employee_id;
/*
e   r   first_name  MYSQL left join return rows in first query and not in second query  email   salary  job_id  
103 103 Alexander   Hunold  AHUNOLD 9000    IT_PROG 
104 104 Bruce   Ernst   BERNST  6000    IT_PROG 
105 105 David   Austin  DAUSTIN 4800    IT_PROG 
106 106 Valli   Pataballa   VPATABAL    4800    IT_PROG 
107 107 Diana   Lorentz DLORENTZ    4200    IT_PROG 

    NULL
    207 Omer    Dagasan ODAGASAN    10000   IT_PROG 
*/
select r.first_name, r.last_name as "MYSQL left join return rows in first query and not in second query", r.email, r.salary, r.job_id
from retired_employees r left join employees e
on r.employee_id = e.employee_id
where e.employee_id is null;
/*
Omer    Dagasan ODAGASAN    10000   IT_PROG 
*/
#or
select r.first_name, r.last_name as "MYSQL left join return rows in first query and not in second query", r.email, r.salary, r.job_id
from retired_employees r left join employees e
using (employee_id)
where e.employee_id is null;

#[ORACLE DATABASE TUTORIALS] LECTURE 72 MATCHING UNMATCHED QUERIES IN SET OPERATIONS - YouTube [720p]
select job_id, department_id, first_name, last_name
from employees
union
select job_id, department_id, null, null
from jobhistory;
select job_id, null as "department_id from jobhistory table", first_name
from employees
union
select job_id, department_id, null
from jobhistory;

#[ORACLE DATABASE TUTORIALS] LECTURE 73 ODER BY WITH SET OPERATORS - YouTube [720p]
select first_name, last_name, salary, department_id as "order by clause sorts from first query; no query alias in order by"
from employees
union
select first_name, last_name, salary, department_id
from retired_employees
order by salary desc;
/*
first_name  last_name   salary      order by clause sorts from first query; no query alias in order by  Focus attention on Omer Dagasan row.
Steven  King    24000   90  
Neena   Kochhar 17000   90  
Lex De Haan 17000   90  
John    Russell 14000   80  
Karen   Partners    13500   80  
Michael Hartstein   13000   20  
Nancy   Greenberg   12008   100 
Shelley Higgins 12008   110 
Alberto Errazuriz   12000   80  
Lisa    Ozer    11500   80  
Den Raphaely    11000   30  
Ellen   Abel    11000   80  
Gerald  Cambrault   11000   80  
Eleni   Zlotkey 10500   80  
Clara   Vishney 10500   80  
Omer    Dagasan 10000   60  
Peter   Tucker  10000   80  
Janette King    10000   80  
Hermann Baer    10000   70  
Harrison    Bloom   10000   80  
Tayler  Fox 9600    80  
David   Bernstein   9500    80  
Patrick Sully   9500    80  
Danielle    Greene  9500    80  
Alexander   Hunold  9000    60  
Alexander   Hunold  9000    60  
*/
select first_name, last_name, salary as "SALARYALIAS", department_id
from employees
union
select first_name, last_name, salary, department_id
from retired_employees
order by "SALARYALIAS" desc;

#[ORACLE DATABASE TUTORIALS] LECTURE 74 DATA MANUPULATION LANGUAGE (DML) - YouTube [720p]

#[ORACLE DATABASE TUTORIALS] LECTURE 75 INSERT STATEMENT (PART 1) - YouTube [720p]
insert into jobs (job_id, job_title, min_salary, max_salary)
values ("GR_LDR", "Group Leader", 8500, 20000);
insert into jobs (job_id, job_title, min_salary, max_salary)
values ("PR_MGR", "Project Manager", 500, 15000);
insert into jobs
values ("PR_CRD","Project Coordinator",4000,18000);
insert into jobs (min_salary, job_id, job_title)
values (4000, "PR_CRD2","Project Coordinator2");
insert into departments
values(280, "Customer Relations",null, null);

#[ORACLE DATABASE TUTORIALS] LECTURE 76 INSERT STATEMENT (PART 2) - YouTube [720p]
insert into jobhistory (employee_id, start_date, end_date, job_id, department_id)
values (120, to_date("2003-02-02","yyyy-mm-dd"), sysdate, "IT_PROG", 60);
#RM:  use to_date to_date('Jun 12, 2005','Mon DD, YYYY')
insert into jobhistory (employee_id, start_date, end_date, job_id, department_id)
values (120, to_date("Feb 02, 2003","Mon DD, YYYY"), sysdate, "IT_PROG", 60);
#RM:  to_date error message on my phpMyAdmin.  Also error message on sysdate.  Need paranthesis.
insert into jobhistory (employee_id, start_date, end_date, job_id, department_id)
values (120, "2003-02-02", sysdate(), "IT_PROG", 60);
#copy table as long as employeescopy table exists
insert into employeescopy
select * from employees;
insert into employeescopy
select * from employees
where job_id = "IT_PROG";
insert into employeescopy (employee_id, first_name, last_name, email, hire_date, job_id, salary)
select (employee_id, first_name, last_name, email, hire_date, job_id, salary) from employees
where job_id = "IT_PROG";
#copy table as long as employeeaddresses table exists
insert into employeeaddresses
select employee_id, first_name, last_name, city || " " || street_address as "Address"
from employees join departments
using (department_id)
join locations
using (location_id);

#[ORACLE DATABASE TUTORIALS] LECTURE 77 UPDATE STATEMENT - YouTube [720p]
#copy table employees as employeescopy for the lesson
create table employeescopy
(employee_id integer not null primary key, first_name varchar(15), last_name varchar(20), email varchar(20), phone_number varchar(20), hire_date date, job_id varchar(10), salary integer, commission_pct decimal(3,2), manager_id integer, department_id integer);
insert into employeescopy
select * from employees;
delete from employeescopy;  #delete all rows delete rows all
update employeescopy
set salary = 500; #update salary column all salary values are 500
update employeescopy
set salary = 50000
where job_id = 'IT_PROG'; #update IT_PROG salaries set all to 50000
update employeescopy
set salary = 5, department_id = null
where job_id = 'IT_PROG'; #update IT_PROG salaries set all to 5 and department_id is null
update employeescopy
set (salary, commission_pct) = (
    select max(salary), max(commission_pct)
    from employees)
where job_id = 'IT_PROG';  #RM:  phpMyAdmin error message
update employeescopy
set salary = (
    select max(salary)
    from employees)
where job_id = 'IT_PROG';
update employeescopy
set commission_pct = (
    select max(commission_pct)
    from employees)
where job_id = 'IT_PROG';  #RM:  phpMyAdmin run two separate update SQL statements

#[ORACLE DATABASE TUTORIALS] LECTURE 78 DELETE STATEMENT - YouTube [720p]
delete from employeescopy;  #delete table employeescopy
delete employeescopy;  #delete table employeescopy
delete from employeescopy
where job_id = 'IT_PROG'; #delete rows where job_id is IT_PROG
delete from employeescopy
where department_id in (
    select department_id
    from departments
    where department_name like 'SA%');

#[ORACLE DATABASE TUTORIALS] LECTURE 79 TRANSACTION CONTROL STATEMENTS - YouTube [720p]
/*
Oracle database is a transactional database.  Transaction is for data security.  We see changes before making changes permanent.  Other users see old data before changes are permanent.  Transaction starts with the first execution of a DML statement and finishes with a commit, rollback operation, system failure, DDL Data Definition Languagestatement, or DCL Data Control Language statement.  A DML operation is executed, the affected rows are locked and anyone else can't update or delete these rows.  There are 3 transactional control statements:  commit, rollback, and savepoint.
*/

#[ORACLE DATABASE TUTORIALS] LECTURE 80 COMMIT AND ROLLBACK STATEMENTS - YouTube [720p]
rollback; #Rollback is undo all changes on data.  Restores data back to its previous state.  Database goes back to previous.
commit; #Saves changes database changes in database.  Makes changes permanent and ends transaction.  Can't rollback after a commit.
#DDL Data Definition Language statement or DCL Data Control Language statement DDL or DCL statements commit is automatically executed.
#RM:  rollback and commit exists in MySQL.  I can't make it work on phpMyAdmin.

#[ORACLE DATABASE TUTORIALS] LECTURE 81 SAVEPOINT STATEMENT - YouTube [720p]
savepoint savepointname; #saves the state of the transaction.  We can rollback to the state.  It's like a checkpoint of rollbacks.  Savepoint goes back to the checkpoint; however, the rollbacks and savepoints after the checkpoint thereafter are deleted.
#For example, if we create four savepoints a, b, c, and d.  Go back to savepoint a.  Rollbacks from savepoints b, c, and d are deleted.
rollback to savepointb; #Using rollback without savepoints deletes all savepoints.  For example, if I rollback to savepoint B, then savepoint c and savepoint d are deleted.
rollback *without savepointname*; #Rollsback to beginning of DML or first transaction without any savepoint.

#[ORACLE DATABASE TUTORIALS] LECTURE 82 FOR UPDATE STATEMENT - YouTube [720p]
#Locks all rows returning from the query.  The lock is released with commit statement or rollback statement.  If a row we want to lock with for update statement is already locked, then the select statement waits until the lock is released.
#To perform a quick execution, we write nowait keyword.  In this time, control of locked rows passed from the other user to you.  nowait may be harmful to the other user because the user didn't want to change these columns but we forced to change these columns.
select *
from employees
where job_id = 'IT_PROG'
for update nowait;
select first_name, last_name, salary
from employees e join departments d
using department_id
where location_id = 1400
for update;  #employees e table and departments d table these rows are locked.  join rows from all the tables are locked.
select first_name, last_name, salary
from employees e join departments d
using department_id
where location_id = 1400
for update of first_name, last_name; #We can use for update of columnname to specify columns we want to lock to prevent locking all the tables.
#for update wait numberofseconds database waits numberofseconds and afterwards gives control to everyone else.

#[ORACLE DATABASE TUTORIALS] LECTURE 83 DATA DEFINITION LANGUAGE (DDL) - YouTube [360p]
#Data Definition Language DDL define database structure.  Create objects in the database, alter the structure of the database, drop which is delete objects from the database, truncate remove records from a table including all spaces allocated for the records are removed, comment add comments to the data dictionary, rename renames an object.

#[ORACLE DATABASE TUTORIALS] LECTURE 84 NAMING RULES - YouTube [720p]

#[ORACLE DATABASE TUTORIALS] LECTURE 85 CREATE TABLE STATEMENT - YouTube [720p]
describe employees;
/*
Field Type Null Key Default Extra
employee_id int(11) NO  PRI     NULL
        
first_name  varchar(15) YES     NULL
        
last_name   varchar(20) YES         NULL
        
email   varchar(20) YES         NULL
        
phone_number    varchar(20) YES         NULL
        
hire_date   date    YES         NULL
        
job_id  varchar(10) YES         NULL
        
salary  int(11) YES         NULL
        
commission_pct  decimal(3,2)    YES 
    NULL
        
manager_id  int(11) YES         NULL
        
department_id   int(11) YES         NULL
*/
create table myemployees
(employee_id number(3), first_name varchar2(50), last_name varchar2(50), hire_date date default sysdate); #sysdate invalid in phpMyAdmin.  MySQL use curdate() for today's date.  number invalid.  Use integer.  default doesn't work in MySQL.
create table myemployees
(employee_id integer(3), first_name varchar(50), last_name varchar(50), hire_date date curdate()); #MySQL can't default current date https://stackoverflow.com/questions/39808684/mysql-date-field-with-default-curdate-not-datetime
create table myemployees
(employee_id integer(3), first_name varchar(50), last_name varchar(50), hire_date date);
create table tablenameassubquerycopytable
as subquery;
create table employeescopyassubquery
as select * from employees;
create table employeescopyassubquerywithoutdata
as select * from employees where 1=2;
create table employeesitprogrammer
as select * from employees where job_id = 'IT_PROG';
create table employeesfirstnamelastnamesalary
(first_namecopiedtable, last_namecopiedtable, salarycopiedtable)
as select first_name, last_name, salary from employees; #error message using MySQL
create table employeesfirstnamelastnamesalary
(first_name varchar(15), last_name varchar(20), salary integer(11))
as select first_name, last_name, salary from employees; #MySQL.  column names must be the same in copied table and source table as the subquery
create table oraclsqlemployeesannualsalary
(first_namecopiedtable, last_namecopiedtable, salarycopiedtable)
as select first_name, last_name, 12*salary from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 86 ALTER TABLE STATEMENTS - YouTube [720p]
alter table employeescopy
add birthdate date;
alter table employeescopy
add (faxnumber number, fathersname varchar2(50), password varchar2(10) default 'abc123');
alter table employeescopy
add (faxnumber integer(10), fathersname varchar(50), password varchar(10) default 'abc123'); #MySQL
alter table employeescopy
modify fathersname varchar2(100);
alter table employeescopy
modify (faxnumber varchar2(11), password varchar2(10) default '0000'); #modifying a column to a default value affects new rows.  Existing rows unchanged.
alter table employeescopy
drop column password; #if there is one column to delete, add keyword column
alter table employeescopy
drop (faxnumber, password);

#[ORACLE DATABASE TUTORIALS] LECTURE 87 DROP TABLE STATEMENT - YouTube [720p]
drop table tablenametobedeleted;

#[ORACLE DATABASE TUTORIALS] LECTURE 88 TRUNCATE TABLE STATEMENT - YouTube [720p]
#Truncate deletes all rows and commits together.  Deletes removes each row one at a time.  Truncate is a DDL statement.  Drop any table privilege is required to truncate a table.
truncate table employeescopy;

#[ORACLE DATABASE TUTORIALS] LECTURE 89 COMMENT STATEMENT - YouTube [720p]
comment on column tablename.columnname is 'comment inserted here';
comment on column employees.job_id is 'comment inserted here';
comment on table employees is 'comment inserted here';
#We can't delete a comment.  Instead, add an empty comment.  comment on column tablename.tablecolumn is '';  <--empty string
select *
from user_tab_comments
where table_name = 'tablename';  #view tablename's comments
select *
from user_col_comments
where table_name = 'tablename';  #view tablename's column comments

#[ORACLE DATABASE TUTORIALS] LECTURE 90 RENAME STATEMENT - YouTube [720p]
alter table employeescopyassubquery
rename column first_name to firstname;

rename oldtablename to newtablename;
#or
alter table oldtablename rename to newtablename;

#[ORACLE DATABASE TUTORIALS] LECTURE 91 CREATING CONSTAINTS - YouTube [720p]
#We can add constraints creating a table or after creating a table.  Constraints can be column level or table level.  Table level constraints can be formed of more than one column.
create table tablename
(columnname number [constraint columnlevelconstraintname] constraint type, first_name varchar2(50), last_name varchar2(50), department_id number, [constraint tablelevelconstraintname] constrainttype (columnname1, . . .));

#[ORACLE DATABASE TUTORIALS] LECTURE 92 NOT NULL CONSTRAINT - YouTube [720p]
insert into jobs
values(null,'temp entry','10','1000');  #MySQL said: Documentation  #1048 - Column 'job_id' cannot be null
create table managerstemp
(employee_id number not null, first_name varchar2(50), last_name varchar2(50) constraint constraintnamelastnamecolumn not null, department_id number not null);  #there are three not null constraints.  One not null constraint is named.

#[ORACLE DATABASE TUTORIALS] LECTURE 93 UNIQUE CONSTRAINT - YouTube [720p]
create table managerstemp
(employee_id number, first_name varchar2(50) unique, last_name varchar2(50) constraint givelastnamecolumnconstraintname unique, department_id number not null, phone_number varchar2(11) unique not null, constraint tablelevelconstriantnameonecolumn unique (department_id), constraint anothertablelevelconstraintnamemultiplecolumns unique (employee_id, first_name, last_name));

#[ORACLE DATABASE TUTORIALS] LECTURE 94 PRIMARY KEY CONTRAINT - YouTube [720p]
create table managerstemp
(employee_id number constraint columnlevelconstraintprimarykeyname primary key, first_name varchar2(50), last_name varchar2(50));
create table managerstemp
(employee_id number, first_name varchar2(50), last_name varchar2(50), constraint tablelevelconstraintprimarykeyname primary key (employee_id));
alter table managerstemp
add constraint updatetableaddconstraintname primary key (employee_id);
alter table managerstemp
add constraint updatetableaddtwoconstraintsname primary key (employee_id, last_name);

#[ORACLE DATABASE TUTORIALS] LECTURE 95 FOREIGN KEY CONSTRAINT - YouTube [720p]
create table managers
(manager_id number constraint primarykeynamemanagers primary key, first_name, varchar2(50), last_name varchar2(50), department_id number, constraint employeemanagernameforeignkey foreign key (manager_id) references employees (employee_id));  #constraint employeemanagernameforeignkey (manager_id) references employees (employee_id) is the foreign key.  employeemanagernameforeignkey is the foreign key name.  foreign key is the foreign key keyword.  (manager_id) is the foreign key column for which references refers to employees table employee_id column in employees table.  manager_id is both primary key for managers and foreign key for employees.
delete from departments
where department_id = 90;  #returns error message delete dependencies first then parent or disable constraint.  Can't delete from parent table departments.
create table managers
(manager_id number constraint primarykeynamemanagers primary key, first_name, varchar2(50), last_name varchar2(50), department_id number, constraint employeemanagernameforeignkey foreign key (manager_id) references employees (employee_id) on delete cascade); #on delete casecade keyword deletes dependent rows in the child table when a related row in the parent table is deleted.

#[ORACLE DATABASE TUTORIALS] LECTURE 96 CHECK CONSTRAINT - YouTube [720p]
create table managers
(manager_id number constraint primarykeynamemanagers primary key, first_name, varchar2(50), last_name varchar2(50), department_id number, salary number, email varchar2(50), constraint minimumsalaryconstraintname check (salary>0));