--Ctrl + Enter or F9 runs a query

show user;

select *
from tab;  --show tables?
select *
from employees;
select employee_id, first_name, last_name, salary, salary + 1000
from employees;
select first_name ||' '||last_name  --concatenate.  Remember single quotes only.
from employees; 
--The Employee id of Mr. Steven King is 100
select 'The Employee id of Mr. '||first_name||' '||last_name||' is '||employee_id as "Detail"
from employees;
select distnct job_id
from job_history;