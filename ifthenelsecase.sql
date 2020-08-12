select emp_id, salary, case when salary >= 6000 then 'top'  when salary >=2000 then 'medium'  when salary >=1000 then 'low' else 'rock bottom' end
from employees;

select emp_id, job_name, case when (job_name = 'PRESIDENT' or job_name = 'MANAGER') then 'management' when job_name = 'SALESMAN' then 'vital' else 'staff' end as jobcategory
from employees;

select emp_id, commission, case when commission is null then 'Yes' else 'No' end as commissioncheck
from employees;

select salary, case when salary >=2000 then salary else 0 end as columnsalary
from employees;
select round(avg(case when salary >=2000 then salary else null end),2) as "Average Salary 2,000+"
from employees;
#RM:  Average avg ignores null.  Average avg includes 0.

select emp_id, salary+commission as totalcompensation, (case when salary+commission<=1350 then 'rock bottom' when salary+commission<=2000 then 'small' when salary+commission<=2500 then 'medium' when salary+commission<=3000 then 'large' else 'great' end) as caselabel
from employees
where commission is not null;
/*
emp_id	totalcompensation	caselabel
64989	2100.00	medium
65271	1950.00	small
66564	2850.00	large
68454	1600.00	small
*/
select job_name, sum(salary), case when sum(salary)>=8000 then 'too expensive' when sum(salary)>=6000 then 'acceptable' when sum(salary)>=4000 then 'cheap' else 'error' end as sumdescription
from employees
group by job_name;
/*
job_name	sum	sumdescription
SALESMAN	6000.00	acceptable
MANAGER	8257.00	too expensive
ANALYST	6200.00	acceptable
CLERK	4550.00	cheap
PRESIDENT	6000.00	acceptable
*/

select emp_id, job_name, case job_name when 'PRESIDENT' then 'leader' when 'MANAGER' then 'lieutenant' when 'SALESMAN' then 'soldier' else 'support' end as casecolumnname
from employees
order by emp_id;
#also and preferred
select emp_id, job_name, case when job_name='PRESIDENT' then 'leader' when job_name='MANAGER' then 'lieutenant' when job_name='SALESMAN' then 'soldier' else 'support' end as casecolumnname
from employees
order by emp_id;

select emp_id, job_name, case when job_name in ('PRESIDENT','MANAGER') then 'tops' when job_name in ('ANALYST','SALESMAN') then 'educated' else 'support' end as casecolumnname
from employees;
select emp_id, job_name, case job_name when in ('PRESIDENT','MANAGER') then 'tops' when in ('ANALYST','SALESMAN') then 'educated' else 'support' end as casecolumnname
from employees; #returns nothing

select emp_id, job_name, case when emp_name = 'MARKER' then 'actual leader' when job_name in ('PRESIDENT','MANAGER') then 'tops' when job_name in ('ANALYST','SALESMAN') then 'educated' else 'support' end as casecolumnname
from employees;

#Additive CASE adding CASE.  May need to use the and keyword and or keyword to repeat criteria for some + case statements; e.g., in the tutorial video discount for red and yellow mountain bikes, not red and yellow touring bikes.
select emp_id, emp_name, job_name, case when job_name = 'MANAGER' then .10 else null end as additiveten
from employees;
/*
emp_id	emp_name	job_name	additiveten
68319	KAYLING	PRESIDENT	
66928	BLAZE	MANAGER	0.10
67832	CLARE	MANAGER	0.10
65646	JONAS	MANAGER	0.10
*/
select emp_id, emp_name, job_name, case when job_name = 'MANAGER' then .10 end + case when emp_name = 'JONAS' then .20  else .10 end as additivenumbers
from employees;
/*
emp_id	emp_name	job_name	additivenumbers
68319	KAYLING	PRESIDENT	
66928	BLAZE	MANAGER	0.20
67832	CLARE	MANAGER	0.20
65646	JONAS	MANAGER	0.30
*/
select emp_id, emp_name, job_name, case when job_name = 'MANAGER' then .10 end + case when emp_name = 'JONAS' then .20  end as additivenumbers
from employees;
/*
emp_id	emp_name	job_name	additivenumbers
68319	KAYLING	PRESIDENT	
66928	BLAZE	MANAGER	
67832	CLARE	MANAGER	
65646	JONAS	MANAGER	0.30
*/
select emp_id, emp_name, job_name, case when job_name = 'MANAGER' then .10 end + case when emp_name = 'JONAS' then .20  else .00 end as additivenumbers
from employees;
/*
emp_id	emp_name	job_name	additivenumbers
68319	KAYLING	PRESIDENT	
66928	BLAZE	MANAGER	0.10
67832	CLARE	MANAGER	0.10
65646	JONAS	MANAGER	0.30
*/
select emp_id, emp_name, salary, job_name, case when job_name = 'MANAGER' then .10 end + case when salary >=2600 then .20 else .00 end + case when emp_name = 'JONAS' then .30 else .00 end as additivenumbers
from employees
where job_name = 'MANAGER';
/*
emp_id	emp_name	salary	job_name	additivenumbers
66928	BLAZE	2750.00	MANAGER	0.30
67832	CLARE	2550.00	MANAGER	0.10
65646	JONAS	2957.00	MANAGER	0.60
*/