#The Language Of SQL by Larry Rockoff Chapter 17 Modifying Data

insert into employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
values (71234, 'ROGER','ANALYST',65646,'2022-01-14',4200.00,null,2001),
values (82345, 'TOM','SALESMAN',66928,'2022-01-14',2000.00,1200.00,3001),
values (93456, 'JOE','IT',68319,'2022-01-14',3000.00,null,1001);
/*Oracle doesn't permit multiple rows.  RM:  MySQL at least my phpMyAdmin version doesn't permit multiple rows.  Each row must include the intert into
insert into employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
values (71234, 'ROGER','ANALYST',65646,'2022-01-14',4200.00,null,2001);
insert into employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
values (82345, 'TOM','SALESMAN',66928,'2022-01-14',2000.00,1200.00,3001);
insert into employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
values (93456, 'JOE','IT',68319,'2022-01-14',3000.00,null,1001);
*/
#The order the columns listed doesn't have toe be the same as in the database.
insert into employees (emp_name, emp_id, job_name, manager_id, salary, commission, dep_id,hire_date)
values ('BRETT', 998848,'ANALYST',65646,4000.00,null,2001,'2022-01-14');
#If the values are written in order of the table columns from left to right, then no need to mention the column names in parenthesis for the insert into statement.  The author discourages to avoid errors.  Missing values in a column are given a null value.
select *
from employees;
/*
emp_id  emp_name    job_name    manager_id  hire_date   salary  commission  dep_id  
68319   KAYLING PRESIDENT   NULL    1991-11-18  6000    NULL    1001    
66928   BLAZE   MANAGER 68319   1991-05-01  2750    NULL    3001    
67832   CLARE   MANAGER 68319   1991-06-09  2550    NULL    1001    
65646   JONAS   MANAGER 68319   1991-04-02  2957    NULL    2001    
67858   SCARLET ANALYST 65646   1997-04-19  3100    NULL    2001    
69062   FRANK   ANALYST 65646   1991-12-03  3100    NULL    2001    
63679   SANDRINE    CLERK   69062   1990-12-18  900 NULL    2001    
64989   ADELYN  SALESMAN    66928   1991-02-20  1700    400 3001    
65271   WADE    SALESMAN    66928   1991-02-22  1350    600 3001    
66564   MADDEN  SALESMAN    66928   1991-09-28  1350    1500    3001    
68454   TUCKER  SALESMAN    66928   1991-09-08  1600    NULL    3001    
68736   ADNRES  CLERK   67858   1997-05-23  1200    NULL    2001    
69000   JULIUS  CLERK   66928   1991-12-03  1050    NULL    3001    
69324   MARKER  CLERK   67832   1992-01-23  1400    NULL    1001    
71234   ROGER   ANALYST 65646   2022-01-14  4200    NULL    2001    
82345   TOM SALESMAN    66928   2022-01-14  2000    1200    3001    
93456   JOE IT  68319   2022-01-14  3000    NULL    1001    
998848  BRETT   ANALYST 65646   2022-01-14  4000    NULL    2001    

/* Pretend another table addanyoftheseemployees
emp_id | emp_name | job_name  | manager_id | hire_date  | salary  | commission | dep_id
--------+----------+-----------+------------+------------+---------+------------+--------
  11111 | OLIVER   | IT        |      65646 | 2022-01-18 | 3800.00 |            |   1001
  22222 | TIMMY    | FACULTIES |      68319 | 2022-01-01 | 1000.00 |            |   3001
  33333 | TEDDY    | FACULTIES |      68319 | 2022-01-09 | 1050.00 |            |   2001
  44444 | FRANN    | ADMIN     |      68319 | 2022-01-02 | 1275.00 |            |   2001
*/
*/
insert into employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)
select *
from addanyoftheseemployees
where job_name = 'FACULTIES';  #Timmy and Teddy rows are added to employees table.  Missing values in a column are given a null value.
delete from employees
where hire_date = '2022-01-14';
delete from tablename; #Delete all data in a single table.  Truncate is faster.
truncate table tablename; #Delete all data in a single table.  Truncate is faster.  Truncate resets values for autoincrement columns.  Delete doesn't reset.
update employees
set salary = 10000
where emp_id = 68319;
update employees
set salary = 20000, job_name = 'SENIOR MANAGER', commission = 500.00
where emp_id = 65646;
select *
from employees
where emp_id in (68319,65646);
/*
emp_id  emp_name    job_name    manager_id  hire_date   salary  commission  dep_id  
65646   JONAS   SENIOR MAN  68319   1991-04-02  20000   500 2001
68319   KAYLING PRESIDENT       NULL    1991-11-18  10000       NULL    1001    
*/
update employees
set salary = 6000
where emp_id = 68319;
update employees
set salary = 2957.00, job_name = 'MANAGER', commission = null
where emp_id = 65646;
select *
from employees
where emp_id in (68319,65646);
/*
emp_id  emp_name    job_name    manager_id  hire_date   salary  commission  dep_id  
65646   JONAS   MANAGER 68319   1991-04-02  2957        NULL    2001    
68319   KAYLING PRESIDENT       NULL    1991-11-18  6000        NULL    1001    
*/
#Author says a more common example of an update query is update data in one table based on data in another table.  Use correlated subquery.
update employees
set dep_id = 1002
where dep_id in (
    select dep_id
    from department
    where dep_name = 'FINANCE2SENIOR');  #pretend department table has a new department named FINANCE2SENIOR
/*
1.  Pretend employees table has a dep_name and dep_location columns
2.  department table updated dep_name for two departments
3.  Update employees table dep_location column change 2001 MELBOURNE to QUEENS and 3001 PERTH to SOUTHAUSTRALIA
Sample table: department
 dep_id |  dep_name  | dep_location
--------+------------+--------------
   1001 | FINANCE    | SYDNEY
   2001 | AUDIT      | QUEENS
   3001 | MARKETING  | SOUTHAUSTRALIA
   4001 | PRODUCTION | BRISBANE
(4 rows)
*/
update employees
set employees.dep_location = (
    select department.dep_location
    from department
    where employees.dep_id=department.dep_id);