#The Language Of SQL by Larry Rockoff Chapter 15 Set Logic

#Create view to learn UNION
create view employeesmanagers as
    select emp_id, emp_name, job_name, manager_id, salary
    from employees
    where job_name in ('President','Manager')
    order by emp_id;
create view employeesnonmanagers as
    select emp_id, emp_name, job_name, manager_id, salary
    from employees
    where job_name not in ('President','Manager')
    order by emp_id;

select *
from employeesmanagers;
/*
emp_id  emp_name    job_name    manager_id  salary  
65646   JONAS   MANAGER 68319   2957    
66928   BLAZE   MANAGER 68319   2750    
67832   CLARE   MANAGER 68319   2550    
68319   KAYLING PRESIDENT       NULL    6000    
*/

select *
from employeesnonmanagers;
/*
emp_id  emp_name    job_name    manager_id  salary  
63679   SANDRINE    CLERK   69062   900 
64989   ADELYN  SALESMAN    66928   1700    
65271   WADE    SALESMAN    66928   1350    
66564   MADDEN  SALESMAN    66928   1350    
67858   SCARLET ANALYST 65646   3100    
68454   TUCKER  SALESMAN    66928   1600    
68736   ADNRES  CLERK   67858   1200    
69000   JULIUS  CLERK   66928   1050    
69062   FRANK   ANALYST 65646   3100    
69324   MARKER  CLERK   67832   1400    
*/

select emp_name, job_name, manager_id, salary
from employeesmanagers
where salary >= 2750
union
select emp_name, job_name, manager_id, salary
from employeesnonmanagers
where salary >=1600
order by salary;
/*
emp_name    job_name    manager_id  salary      
TUCKER  SALESMAN    66928   1600    
ADELYN  SALESMAN    66928   1700    
BLAZE   MANAGER 68319   2750    
JONAS   MANAGER 68319   2957    
SCARLET ANALYST 65646   3100    
FRANK   ANALYST 65646   3100    
KAYLING PRESIDENT       NULL    6000    
*/

select manager_id
from employeesmanagers
union
select manager_id
from employeesnonmanagers
order by manager_id;
/*
manager_id      
NULL em times 1
65646 enm times 2  
66928 enm times 5  
67832 enm times 1  
67858 enm times 1 
68319 em times 3  
69062 enm times 1  
*/

select manager_id
from employeesmanagers
union all
select manager_id
from employeesnonmanagers
order by manager_id;
/*
manager_id      
NULL em times 1    
65646   enm times 2
65646   enm times 2
66928   enm times 5
66928   enm times 5
66928   enm times 5
66928   enm times 5
66928   enm times 5
67832   enm times 1
67858   enm times 1
68319   em times 3
68319   em times 3
68319   em times 3
69062   enm times 1
*/

select distinct manager_id
from employeesmanagers
union all
select distinct manager_id
from employeesnonmanagers
order by manager_id;  #The distinct ensures each manager_id is returned once in its select statement
/*
manager_id      
NULL
65646   
66928   
67832   
67858   
68319   
69062   
*/

#intersect is unavailable in MySQL
select manager_id
from employeesmanagers
intersect
select manager_id
from employeesnonmanagers
order by manager_id;

#delete view
drop view employeesmanagers, employeesnonmanagers;  #RM:  drop multiple views in one SQL statement valid
drop view employeesmanagers;
drop view employeesnonmanagers;