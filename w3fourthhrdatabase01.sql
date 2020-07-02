#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php
#https://www.w3resource.com/sql-exercises/joins-hr/index.php

#https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php
#1. Write a query in SQL to display the full name (first and last name), and salary for those employees who earn below 6000.
select first_name|| ' ' ||last_name as "Full Name", salary
from employees
where salary < 6000;

#2. Write a query in SQL to display the first and last_name, department number and salary for those employees who earn more than 8000.
select *
from employees
where salary > 8000;

#3. Write a query in SQL to display the first and last name, and department number for all employees whose last name is “McEwen”.
select *
from employees
where last_name = 'McEwen';

#4. Write a query in SQL to display all the information for all employees without any department number.  #RM:  database with no department number is noted with 0 or zero.
select *
from employees
where department_id = 0;
#also
select *
from employees
where department_id is null;

#5. Write a query in SQL to display all the information about the department Marketing.
select *
from departments
where department_name = 'Marketing';

#6. Write a query in SQL to display the full name (first and last), hire date, salary, and department number for those employees whose first name does not containing the letter M and make the result set in ascending order by department number.
select *
from employees
where first_name not like '%M%'
order by department_id asc;

#7. Write a query in SQL to display all the information of employees whose salary is in the range of 8000 and 12000 and commission is not null or department number is except the number 40, 120 and 70 and they have been hired before June 5th, 1987.
select *
from employees
where salary between 8000 and 12000
and (commission_pct is not null
or department_id not in (40,120,70))
and hire_date < '1987-06-05';  #RM:  the and's and the or's don't make sense in the solution.

#8. Write a query in SQL to display the full name (first and last name), and salary for all employees who does not earn any commission.
select *
from employees
where commission_pct is null;  #RM:  correct answer is where commission_pct = 0 because database denotes 0.00 under commission_pct.

#9. Write a query in SQL to display the full name (first and last), the phone number and email separated by hyphen, and salary, for those employees whose salary is within the range of 9000 and 17000. The column headings assign with Full_Name, Contact_Details and Remuneration respectively.
select first_name|| ' ' ||last_name as "Full_Name", phone_number|| ' - ' ||email as "Contact_Details", salary as "Remunereation"
from employees
where salary between 9000 and 17000;

#10. Write a query in SQL to display the first and last name, and salary for those employees whose first name is ending with the letter m.
select *
from employees
where first_name like '%m';

#11. Write a query in SQL to display the full name (first and last) name, and salary, for all employees whose salary is out of the range 7000 and 15000 and make the result set in ascending order by the full name.
select first_name || ' ' ||last_name as "Full Name", salary
from employees
where salary < 7000
or salary > 15000
order by "Full Name" asc;
#also
select first_name || ' ' ||last_name as "Full Name", salary
from employees
where salary not between 7000 and 15000
order by "Full Name" asc;

#12. Write a query in SQL to display the full name (first and last), job id and date of hire for those employees who was hired during November 5th, 2007 and July 5th, 2009.
select *
from employees
where hire_date between '2007-11-05' and '2009-07-05';

#13. Write a query in SQL to display the the full name (first and last name), and department number for those employees who works either in department 70 or 90.
select *
from employees
where department_id in (70, 90);

#14. Write a query in SQL to display the full name (first and last name), salary, and manager number for those employees who is working under a manager.
select *
from employees
where manager_id is not null;

#15. Write a query in SQL to display all the information from Employees table for those employees who was hired before June 21st, 2002.
select *
from employees
where hire_date < '2002-06-21';

#16. Write a query in SQL to display the first and last name, email, salary and manager ID, for those employees whose managers are hold the ID 120, 103 or 145.
select *
from employees
where manager_id in (120, 103, 145);

#17. Write a query in SQL to display all the information for all employees who have the letters D, S, or N in their first name and also arrange the result in descending order by salary.
select *
from employees
where first_name like '%D%'
or first_name like '%S%'
or first_name like '%N%'
order by salary desc;

#18. Write a query in SQL to display the full name (first name and last name), hire date, commission percentage, email and telephone separated by '-', and salary for those employees who earn the salary above 11000 or the seventh digit in their phone number equals 3 and make the result set in a descending order by the first name.
select first_name|| ' ' ||last_name as "Full Name", hire_date, commission_pct, email|| ' - ' ||phone_number as "Contact Details", salary as "Remunereation"
from employees
where salary > 11000
or phone_number like '________3___'
order by first_name desc;

#19. Write a query in SQL to display the first and last name, and department number for those employees who holds a letter s as a 3rd character in their first name.
select *
from employees
where first_name like '__s%';

#20. Write a query in SQL to display the employee ID, first name, job id, and department number for those employees who is working except the departments 50,30 and 80.
select *
from employees
where department_id not in (50, 30, 80);

#21. Write a query in SQL to display the employee Id, first name, job id, and department number for those employees whose department number equals 30, 40 or 90.
select *
from employees
where department_id in (30, 40, 90);

#22. Write a query in SQL to display the ID for those employees who did two or more jobs in the past.
select employee_id
from job_history
group by employee_id
having count(employee_id) >=2;

#23. Write a query in SQL to display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary for a job.
select job_id, count(*), sum(salary), max(salary)-min(salary) as "Difference highest and lowest salary"
from employees
group by job_id;

#24. Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days.
select job_id
from job_history
where end_date-start_date > 300
group by job_id
having count(*) >=2;
/*
job_id
AC_ACCOUNT
ST_CLERK
*/

#25. Write a query in SQL to display the country ID and number of cities in that country we have.
select country_id, count(*)
from locations
group by country_id;

#26. Write a query in SQL to display the manager ID and number of employees managed by the manager.
select manager_id, count(employee_id)
from employees
group by manager_id;

#27. Write a query in SQL to display the details of jobs in descending sequence on job title.
select *
from jobs
order by job_title desc;

#28. Write a query in SQL to display the first and last name and date of joining of the employees who is either Sales Representative or Sales Man.
select *
from employees
where job_id in ('SA_REP','SA_MAN');

#29. Write a query in SQL to display the average salary of employees for each department who gets a commission percentage.
select department_id, avg(salary)
from employees
where commission_pct is not null
group by department_id;

#30. Write a query in SQL to display those departments where any manager is managing 4 or more employees.
select department_id, manager_id, count(employee_id)
from employees
group by department_id, manager_id
having count(employee_id) >=4;
/*
department_id	manager_id	count
80	100	5
100	108	5
50	100	5
80	147	6
80	148	6
30	114	5
50	124	8
80	149	5
50	121	8
50	123	8
80	146	6
60	103	4
80	145	6
50	122	8
50	120	8
*/
select distinct department_id
from employees
group by department_id, manager_id
having count(employee_id) >=4;
/*
department_id
80
50
60
100
30
*/

#31. Write a query in SQL to display those departments where more than ten employees work who got a commission percentage.
select department_id
from employees
where commission_pct is not null
group by department_id
having count(*) > 10;

#32. Write a query in SQL to display the employee ID and the date on which he ended his previous job.  #RM:  Find all employee's last date which is his previous job.
select employee_id, max(end_date)
from job_history
group by employee_id;

#33. Write a query in SQL to display the details of the employees who have no commission percentage and salary within the range 7000 to 12000 and works in that department which number is 50.
select *
from employees
where commission_pct is null
and salary between 7000 and 12000
and department_id = 50;

#34. Write a query in SQL to display the job ID for those jobs which average salary is above 8000.
select job_id
from employees
group by job_id
having avg(salary) > 8000;

#35. Write a query in SQL to display job Title, the difference between minimum and maximum salaries for those jobs which max salary within the range 12000 to 18000.
select job_title, max_salary - min_salary as "Salary Difference"
from jobs
where max_salary between 12000 and 18000;

#36. Write a query in SQL to display all those employees whose first name or last name starts with the letter D.
select *
from employees
where first_name like 'D&'
or last_name like 'D&';

#37. Write a query in SQL to display the details of jobs which minimum salary is greater than 9000.
select *
from jobs
where min_salary > 9000;

#38. Write a query in SQL to display those employees who joined after 7th September, 1987.
select *
from employees
where hire_date > '1987-09-07';

#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;
#also
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

#2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

#3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.
select e.first_name, e.last_name, e.salary, j.grade_level
from employees e join job_grade j
on e.salary between j.lowest_sal and j.highest_sal;

#4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
where e.department_id in (80,40)
order by e.last_name;

#5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where e.first_name like '%z%';

#6. Write a query in SQL to display all departments including those where does not have any employee.  #RM:  Example of right outer join.  Display employees and their departments and departments without employees
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

#7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
select first_name, last_name, salary
from employees
where salary < (
	select salary
	from employees
	where employee_id = 182);
#also using joins
select e.first_name, e.last_name, e.salary
from employees e join employees salary182
on e.salary < salary182.salary
and salary182.employee_id = 182;

#8. Write a query in SQL to display the first name of all employees including the first name of their manager.
select e.first_name as "employee", m.first_name as "manager"
from employees e join employees m
on e.manager_id = m.employee_id;

#9. Write a query in SQL to display the department name, city, and state province for each department.
select d.department_name, l.city, l.state_province
from departments d join locations l
on d.location_id = l.location_id;

#10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.  #RM:  practice left outer join
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

#11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.
select e.first_name as "employee", m.first_name as "manager"
from employees e left outer join employees m
on e.manager_id = m.employee_id;

#12. Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select first_name, last_name, department_id
from employees
where department_id in (
	select department_id
	from employees
	where last_name = 'Taylor');
#also using joins
select e.first_name, e.last_name, e.department_id
from employees e join employees taylor
on e.department_id = taylor.department_id
and taylor.last_name = 'Taylor';

#13. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.
select jobs.job_title, d.department_name, e.first_name, e.last_name, e.hire_date
from employees e join departments d
on e.department_id = d.department_id
join jobs
on jobs.job_id = e.job_id
join job_history
on job_history.employee_id = e.employee_id
where job_history.start_date >= '1993-01-01'
and job_history.start_date <= '1997-08-31';
/*
job_title		department_name		employee_name	start_date
Administration Assistant  Executive	 Jennifer Whalen	1995-09-17
*/

#14. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.
select jobs.job_title, e.first_name, e.last_name, jobs.max_salary-e.salary as "difference max salary and employee salary"
from employees e join jobs
on e.job_id = jobs.job_id;

#15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.
select d.department_name, round(avg(e.salary),2), count(e.department_id)
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name;
/*
department_name	round	count
Shipping	3475.56	45
Sales	8955.88	34
IT	5760.00	5
Administration	4400.00	1
Finance	8600.00	6
Purchasing	4150.00	6
Marketing	9500.00	2
Public Relations	10000.00	1
Accounting	10150.00	2
Executive	19333.33	3
Human Resources	6500.00	1
*/

#16. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 80.  #RM:  salary difference is the max salary and the employee's salary.
select e.first_name, e.last_name, jobs.job_title, jobs.max_salary-e.salary as "difference max salary and employee salary"
from employees e join jobs
on e.job_id = jobs.job_id
where e.department_id = 80;

#17. Write a query in SQL to display the name of the country, city, and the departments which are running there.
select c.country_name, l.city, d.department_name
from departments d join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;
#official solution
select country_name,city, department_name 
from countries 
join locations using (country_id) 
join departments using (location_id);

#18. Write a query in SQL to display department name and the full name (first and last name) of the manager.
select d.department_name, e.first_name, e.last_name
from departments d join employees e
on d.manager_id = e.manager_id;

#19. Write a query in SQL to display job title and average salary of employees.
select jobs.job_title, avg(e.salary)
from jobs join employees e
on jobs.job_id = e.job_id
group by jobs.job_title;

#20. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000.
select job_history.*
from job_history join employees e
on job_history.employee_id = e.employee_id
where e.salary >= 12000;

#21. Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.  #RM:  I don't understand question.  I think questions asks find country and city and the number of departments in the country and city where the departments havae two or more workers.
select c.country_name, l.city, count(e.employee_id)
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id
group by c.country_name, l.city
having count(e.employee_id) >= 2;
/*
country_name	city	count
Canada	Toronto	2
United States of America	Seattle	18
United States of America	South San Francisco	45
United States of America	Southlake	5
*/
#official solution
select country_name, city, count(department_id)
from countries 
join locations using (country_id) 
join departments using (location_id) 
where department_id in (
	select department_id 
	from employees 
	group by department_id 
	having count(department_id)>=2)
group by country_name,city;
/*
country_name			city			count
United States of America 	South San Francisco	1
Canada				Toronto			1
United States of America	Seattle			4
United States of America	Southlake		1
*/

#22. Write a query in SQL to display the department name, full name (first and last name) of manager, and their city.
#used official solution.
select d.department_name, e.first_name, e.last_name, l.city
from employees e join departments d
on e.employee_id = d.manager_id
join locations l
on d.location_id = l.location_id;
#RM:  department's table includes manager's id.
/*
department_name	first_name	last_name	city
Executive	Steven	King	Seattle
IT	Alexander	Hunold	Southlake
Finance	Nancy	Greenberg	Seattle
Purchasing	Den	Raphaely	Seattle
Shipping	Adam	Fripp	South San Francisco
Sales	John	Russell	OX9 9ZB
Administration	Jennifer	Whalen	Seattle
Marketing	Michael	Hartstein	Toronto
Human Resources	Susan	Mavris	London
Public Relations	Hermann	Baer	Munich
Accounting	Shelley	Higgins	Seattle
*/

#bonus
select e.employee_id, e.first_name, e.last_name, manager.employee_id "manager's employee id", manager.first_name as "manager first name", manager.last_name as "manager last name"
from employees e left outer join employees manager
on e.manager_id = manager.employee_id;
/*
employee_id	first_name	last_name	manager's employee id	manager first name	manager last name
100	Steven	King			
101	Neena	Kochhar	100	Steven	King
102	Lex	De Haan	100	Steven	King
103	Alexander	Hunold	102	Lex	De Haan
104	Bruce	Ernst	103	Alexander	Hunold
105	David	Austin	103	Alexander	Hunold
106	Valli	Pataballa	103	Alexander	Hunold
107	Diana	Lorentz	103	Alexander	Hunold
108	Nancy	Greenberg	101	Neena	Kochhar
109	Daniel	Faviet	108	Nancy	Greenberg
110	John	Chen	108	Nancy	Greenberg
111	Ismael	Sciarra	108	Nancy	Greenberg
112	Jose Manuel	Urman	108	Nancy	Greenberg
113	Luis	Popp	108	Nancy	Greenberg
114	Den	Raphaely	100	Steven	King
115	Alexander	Khoo	114	Den	Raphaely
116	Shelli	Baida	114	Den	Raphaely
117	Sigal	Tobias	114	Den	Raphaely
118	Guy	Himuro	114	Den	Raphaely
119	Karen	Colmenares	114	Den	Raphaely
120	Matthew	Weiss	100	Steven	King
121	Adam	Fripp	100	Steven	King
122	Payam	Kaufling	100	Steven	King
123	Shanta	Vollman	100	Steven	King
124	Kevin	Mourgos	100	Steven	King
125	Julia	Nayer	120	Matthew	Weiss
126	Irene	Mikkilineni	120	Matthew	Weiss
127	James	Landry	120	Matthew	Weiss
128	Steven	Markle	120	Matthew	Weiss
129	Laura	Bissot	121	Adam	Fripp
130	Mozhe	Atkinson	121	Adam	Fripp
*/

#23. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.
select job_history.employee_id, j.job_title, job_history.end_date-job_history.start_date
from job_history join jobs j
on job_history.job_id = j.job_id
where job_history.department_id = 80;

#24. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London.
select e.first_name, e.last_name, e.salary
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'London';

#25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
#partially correct because wanted the last job
select e.first_name, e.last_name, j.job_title, job_history.start_date, job_history.end_date
from employees e join job_history
on e.employee_id = job_history.employee_id
join jobs j
on job_history.job_id = j.job_id
where e.commission_pct = 0;
/*
first_name	last_name	job_title	start_date	end_date
Jennifer	Whalen	Administration Assistant	1995-09-17	2001-06-17
Neena	Kochhar	Accounting Manager	2001-10-28	2005-03-15
Jennifer	Whalen	Public Accountant	2002-07-01	2006-12-31
Neena	Kochhar	Public Accountant	1997-09-21	2001-10-27
Payam	Kaufling	Stock Clerk	2007-01-01	2007-12-31
Den	Raphaely	Stock Clerk	2006-03-24	2007-12-31
Lex	De Haan	Programmer	2001-01-13	2006-07-24
Michael	Hartstein	Marketing Representative	2004-02-17	2007-12-19
*/
#official solution
select concat(e.first_name, ' ', e.last_name) as employee_name, j.job_title, h.*
from employees e join (
	select max(start_date), max(end_date), employee_id
	from job_history
	group by employee_id) h
	on e.employee_id=h.employee_id
join jobs j
on j.job_id=e.job_id
where e.commission_pct = 0;
/*
employee_name		job_title			starting_date	ending_date	employee_id
Neena Kochhar		Administration Vice President	2001-10-28	2005-03-15	101
Lex De Haan		Administration Vice President	2001-01-13	2006-07-24	102
Den Raphaely		Purchasing Manager		2006-03-24	2007-12-31	114
Payam Kaufling		Stock Manager			2007-01-01	2007-12-31	122
Jennifer Whalen		Administration Assistant	2002-07-01	2006-12-31	200
Michael Hartstein	Marketing Manager		2004-02-17	2007-12-19	201
*/
#user solution
select e.first_name, e.last_name, j.job_title. h.start_date, h.end_date
from jobs j join job_history h
on h.job_id = j.job_id
join employees e
on e.employee_id = h.employee_id
where e.commission_pct = 0
and h.start_date = (
	select max(start_date)
	from job_history h1
	where h.employee_id = h1.employee_id);
/* can't confirm user solution works */

#26. Write a query in SQL to display the department name and number of employees in each of the department.
select d.department_name, d.department_id, count(e.department_id)
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name, d.department_id
order by d.department_id;

#27. Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working.
select e.first_name, e.last_name, e.employee_id, c.country_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;