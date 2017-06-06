--database hrPDBORCL

select FIRST_NAME, LAST_NAME
from employees

select department_id, department_name
from departments

select employee_id, start_date
from job_history

select *
from employees
where salary > 5000

select department_ID
from departments
where department_name = 'Marketing'

select employee_id
from job_history
where department_id = 80

SELECT * FROM employees WHERE department_ID = 60 AND salary > 3000

select *
from employees
where department_id = 60 OR salary > 3000

select first_name, last_name
from employees
where department_id <> 60 and salary > 3000

select first_name, last_name
from employees
where salary >=24000 and not job_id = 'ad_pres'
--or
select first_name, last_name
from employees
where salary >= all (select salary from employees)  --Oracle specific syntax

describe EMPLOYEES  --runs sql code see EMPLOYEES table info

--1 who reports to manager ID 103
select first_name, last_name
from employees
where manager_id = 103

--2 Luis Popp salary
select salary
from employees
where first_name = 'Luis' and last_name = 'Popp'

--3 Kee Gee phone number
select phone_number
from employees
where last_name = 'Gee'  --Kee's first name is actually Ki.  Kee is intentionally incorrect.

--4 find first name and last name using RMATOS email
select first_name, last_name
from employees
where email = 'RMATOS'
--where email = 'rmatos' data case sensitive

--5 find people working on commission
select *
from employees
where commission_pct > 0
--where commission_pct IS NULL --people not working on commission

--6 find phone number employee id 123
select phone_number
from employees
where employee_id = 123

--7 user information phone number 011.44.1644.429263
select *
from employees
where phone_number = '011.44.1644.429263'  --phone number is varchar2(20)

--8 employee named Donald O'Connell?
select *
from employees
where first_name = 'Donald' and last_name = 'O''Connell'  --no data found is correct

--9 how long Renske Ladwig working
select hire_date
from employees
where first_name = 'Renske' and last_name = 'Ladwig'

--10 find HR department is located (few searches are needed)
select *
from departments
where department_name = 'Human Resources'

select *
from locations
where location_ID = 2400

--10 Nested select statements.  Not a join.
select *
from locations
where location_ID = (select location_id from departments where department_name = 'Human Resources')

--11 Salary range for shipping clerk position
select min_salary, max_salary
from jobs
where job_id = 'SH_CLERK'

--Sorting ORDER BY ASC DESC
select *
from employees
order by first_name ASC, last_name DESC

select *
from employees
order by first_name DESC

--IN, BETWEEN AND, LIKE % LIKE _ both case sensitive, IS NULL, IS NOT NULL
select employee_id
from employees
where department_id In (20, 60, 100)

select employee_id
from employees
where department_id between 20 and 80
--where department_id >=20 and department_id <=80

select *
from employees
where HIRE_DATE between '01/01/2001' and '01/01/2003'

select employee_id
from employees
where first_name like 'Nan%'

select *
from employees
where first_name like 'Randal_'

select *
from employees
where first_name like 'Dav%'

select employee_id
from employees
where commission_pct is not null

--Aggregate Functions COUNT, SUM, AVG, MAX, MIN
--AVG and SUM numeric values only. MIN, MAX any data type.
select count(*) as Count_Employees
from employees  --return 107 column heading is Count_Employees

select count(employee_id)
from employees --return 107 column heading is COUNT(EMPLOYEE_ID)

select count(COMMISSION_PCT)
from employees --return 35 column heading is COUNT(COMMISSION PCT)

select count(MANAGER_ID)
from employees --return 106 column heading is COUNT(MANAGER_ID)

select count(employee_id)
from employees 
where department_id = 60  --return 5 column heading is COUNT(EMPLOYEE_ID)

select sum(salary)
from employees  --return 691416 column heading SUM(SALARY)

select avg(salary)
from employees 
where department_id = 60  --return 5760 column heading is AVG(SALARY)

select min(salary)
from employees  --return 2100 column heading MIN(SALARY)

--how many employees work outside USA
select *
from locations
where country_ID Not In ('US')

select *
from departments

select count(employee_ID)
from employees
where department_id In (20, 40, 80, 70)

--Nested select statements using In()
select count(employee_ID)
from employees
where department_ID In (
  select department_ID
  from departments
  where location_ID In (
    select location_id
    from locations
    where country_ID Not In ('US')))

--what department their employees from outside US work in
--Nested select statements using In()
select *
from departments
where location_ID In (
    select location_ID
    from locations
    where country_ID Not In ('US'))
  
--how many employees work in Bay Area
select count(employee_id)
from employees
where phone_number like '408%' or phone_number like '415%' or phone_number like '650%' or phone_number like '510%'

--who are the employees who don't report to a manager
select *
from employees
where manager_id is null

--who is getting highest commission
--Nested select statements using =
select *
from employees
where commission_pct = (select max(commission_pct) from employees)

--who is the first employee hired
--Nested select statements using =
select *
from employees
where hire_date = (select min(hire_date) from employees)

--Advanced:  how many people work in each department
--Use statement GROUP BY.  Both SQL queries work.  It's a matter of presentation.
select count (employee_ID), department_ID
from employees
group by department_ID

select department_ID, count (employee_ID)
from employees
group by department_ID

--how many managers are in the company
--Use DISTINCT keyword
select count(distinct manager_ID)
from employees

--grouping.  Find out who (first name, last name) gets top salary in each department.  No answer provided.
select *
from employees
where (select department_ID, max(salary)
from employees
group by department_ID)

select *
from employees
where (salary In (select max(salary) from employees group by department_ID))
and
where (department_ID In (select department_ID, max(salary) from employees group by department_ID))

select *
from employees
where (department_ID in (100) and salary In (12008))
or (department_ID in (30) and salary In (11000))
or (department_ID in (90) and salary In (24000))

select department_ID, max(salary)
from employees
group by department_ID

--INSERT, DELETE, UPDATE.  Insert new record into a table; data entered as ordered in table fields.
--If Autocommit is checked, then new record is permanently added.  Also, type ROLLBACK to undo insert new record if no commit .
INSERT into Employees
VALUES (207,'Test','Tester','TTESTER','408.555.5555','02/17/2008','IT_PROG',12000,NULL,103,60)

select *
from employees
where employee_id In (207)

INSERT into Employees
VALUES ((SELECT MAX(employee_id)+1 FROM employees),'Test','Testerr','TTESTERR','408.555.5555','02/17/2008','IT_PROG',12000,NULL,103,60)

ROLLBACK

--If we don't specify a predicate or where condition, then the entire table is deleted.
DELETE 
FROM employees
WHERE employee_id = 207
--or
DELETE
FROM employees
WHERE email='TTESTER'

DELETE
FROM employees
WHERE employee_ID BETWEEN 107 AND 127

--TRUNCATE deletes a table data permanently.  Faster than DELETE.  No predicates.
--DROP deletes a table permanently from the database.
--UPDATE modifies records in a table.  Okay to use AND, OR, BETWEEN
UPDATE employees
SET salary = 20000
WHERE employee_id = 106

UPDATE employees
SET salary = 1000000
WHERE job_id = 'AD_PRES' AND employee_id = 100

--Change Diana Lorentz to Diana Goetz.  Also, email alias must be updated.  And confirm nobody else using email alias DGOETZ.
SELECT *
FROM employees
WHERE first_name = 'Diana' AND last_name = 'Lorentz'

UPDATE employees
SET last_name = 'Goetz', email = 'DGOETZ'  --doesn't like AND, use comma
WHERE employee_id = 107

--JOIN.  Getting information from related tables is called JOIN operation.
--Step 1 start with fields to see in our result table.  Template-->table.tablefieldname
--Step 2 specify where we like to retrieve the information or specify the tables.
--Step 3 match or equate the fields in tables to connect the tables
SELECT employees.first_name, employees.last_name, employees.phone_number, departments.department_name
FROM employees, departments  --2,916 results.  Cartesian.  Multiple records in employees by records in departments

SELECT employees.first_name, employees.last_name, employees.phone_number, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id
ORDER BY departments.department_name, employees.last_name

--nicknames or assign alias to tables
SELECT e.first_name, e.last_name, e.phone_number, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY d.department_name, e.last_name

SELECT e1.employee_id AS managerID, e2.first_name, e2.last_name
FROM employees e1, employees e2  --join same tables together
WHERE e2.manager_id = e1.employee_id AND e2.manager_id IS NOT NULL
ORDER BY e1.employee_id

--number of employees in each department
select count (employee_ID), department_ID
from employees
group by department_ID

select count(e.employee_ID)
from employees e, departments d, locations l
where l.country_id <> 'US'
and d.location_id = l.location_id
and e.department_id = d.department_id

--LEFT OUTER JOIN or RIGHT OUTER JOIN
--Join statements exercises
--1 how much top salary employee #101 can earn
--2 office street address employee email ID RMATOS is working
--3 Where IT department is located (country, city, address)
--4 how much money employees working in Great Britian are making combined? Query 3 tables employees, departments, locations

--Views.  View is a virtual table which is created by executing a result of a query.  Essentially it is an abbreviation of SELECT statement.
--A view can be updated with UPDATE.  However, it is underlying table which is updated, not view itself.
--Example below retrives all employee names in Bay Area.  Store as a view named "local_employees_v".
SELECT first_name, last_name
FROM employees
WHERE phone_number like '650%'
SELECT *
FROM local_employees_v
WHERE phone_number like '650%'

--A materialized view contain data.  Regard materialized view as a subset of the table.
--e.g. we may have Bay Area employees placed in materialized view named local_employees_mv.

--A trigger is a SQL code activated when a certain event happens.  A common usage is when a new record is added to a database, the trigger is invoked.
--e.g. a new employee joined the company and is added to employees table, an email sent to manager, ID department, payroll department.

--Interview Questions
--What is SQL stand for?  Structured Query Language.
--How do you select all records from the table?  SELECT * FROM table_name
--What is a join?  Join is a process of retrieve pieces of data from different sets or tables and returns them to the user or program as one "joined" collection of data.
--How do you add record to a table?  INSERT INTO table_name VALUES ('ALEX',33,'M')
--How do you add a column to a table?  ALTER TABLE table_name ADD (AGE, NUMBER)
--How do you change value of the field?  UPDATE table_name SET number = 200 WHERE item_number = 'CD'
--What does COMMIT do?  Saving all changes made by DML statements.
--What is a primary key?  The column or columns that has completely unique data throughout the table is known as the primary key field.
--What is a foreign key?  Links one table to another table's primary or foreign key.
--What is the main role of a primary key in a table?  Maintain the internal integrity of a data table.
--Can a table have more than one foreign key defined?  Yes.
--List all the possible values that can be stored in a boolean data?  0 and 1.
--Describe how NULL work?  The NULL handles missing values.
--What is normalization?  The process of table design.
--What is Trigger?  Executies a block of procedural code against the database when a table event occurs.
--Can one select a random collection of rows from a table?  Yes.  10% of rows randomly selected.
SELECT *
FROM employees SAMPLE(10)
--Write a SQL statement return each city once from students table?
SELECT DISTINCT city
FROM students
--What is DML and DDL?  Data Manipulation Language and Data Definition Language.
--Write a SQL statement returns first name, last name, salary, and gives each of them a number.  ROWNUM is Oracle specific.
SELECT first_name, last_name, salary, ROWNUM
FROM instructors
--Is the WHERE clause must appear before GROUP BY?  Yes.  SELECT and FROM are mandatory.
SELECT *
FROM table_name
WHERE
GROUP BY
HAVING
ORDER BY
--DELETE removes some or all the rows from a table.
--TRUNCATE removes all the rows from a table.  ROLLBACK impossible.
--DROP removes a table.
--dual is a dummy table created by Oracle.  Do anything.
SELECT 'the end'
from dual
