#The Language Of SQL by Larry Rockoff Chapter 10 Summarizing Data

#DISTINCT removes duplicate rows from the output.  DISTINCT specifies unique values of the column or columns returned.
select distinct job_id
from employees;
/*
job_id	
AD_PRES	
AD_VP	
IT_PROG	
FI_MGR	
FI_ACCOUNT	
PU_MAN	
PU_CLERK	
ST_MAN	
ST_CLERK	
SA_MAN	
SA_REP	
SH_CLERK	
AD_ASST	
MK_MAN	
MK_REP	
HR_REP	
PR_REP	
AC_MGR	
AC_ACCOUNT	
*/
select distinct job_id, manager_id
from employees;
/*
job_id	manager_id	
AD_PRES	
    NULL
	
AD_VP	100	
IT_PROG	102	
IT_PROG	103	
FI_MGR	101	
FI_ACCOUNT	108	
PU_MAN	100	
PU_CLERK	114	
ST_MAN	100	
ST_CLERK	120	
ST_CLERK	121	
ST_CLERK	122	
ST_CLERK	123	
ST_CLERK	124	
SA_MAN	100	
SA_REP	145	
SA_REP	146	
SA_REP	147	
SA_REP	148	
SA_REP	149	
SH_CLERK	120	
SH_CLERK	121	
SH_CLERK	122	
SH_CLERK	123	
SH_CLERK	124	
*/

select sum(salary) as "Total salary job_id st_clerk"
from employees
where job_id = 'st_clerk'; #return 55700
select avg(salary) as "Average Sales Rep Salary", min(salary) as "Lowest", max(salary) as "Highest case insensitive"
from employees
where job_id = 'sa_rep';
/*
8350.0000	6100	11500	

Average Sales Rep Salary
Lowest
Highest case insensitive
8350.0000
6100
11500
*/
select count(*) as "Count Rows"
from employees; #return 107
select count(job_id) as "Count sh clerk in job_id column"
from employees
where job_id = 'sh_clerk'; #print 20
select count(*) as "Count Rows"
from locations; #return 23
select count(state_province) as "Pretend blank is NULL then returned 23-6=17"
from locations; #return 23
select count(distinct job_id) as "Count unique job_id"
from employees; #return 19
select job_id, avg(salary) as "Average salary by job_id"
from employees
group by job_id
order by job_id;
/*
job_id   	Average salary by job_id	
AC_ACCOUNT	8300.0000	
AC_MGR	12008.0000	
AD_ASST	4400.0000	
AD_PRES	24000.0000	
AD_VP	17000.0000	
FI_ACCOUNT	7920.0000	
FI_MGR	12008.0000	
HR_REP	6500.0000	
IT_PROG	5760.0000	
MK_MAN	13000.0000	
MK_REP	6000.0000	
PR_REP	10000.0000	
PU_CLERK	2780.0000	
PU_MAN	11000.0000	
SA_MAN	12200.0000	
SA_REP	8350.0000	
SH_CLERK	3215.0000	
ST_CLERK	2785.0000	
ST_MAN	7280.0000	
*/
#RM:  Null rows are ignored.
select job_id, avg(ISNULL(salary,0)) as "Replace NULL with 0 to include in avg"
from employees
group by job_id
order by job_id; #RM:  doesn't work in MySQL
select job_id, avg(salary) as "Average salary by job_id non executive, commission is null"
from employees
where job_id not in ('ad_pres', 'ad_vp')
and commission_pct is null
group by job_id;
/*
job_id	Average salary by job_id non executive, commission is null	
AC_ACCOUNT	8300.0000	
AC_MGR	12008.0000	
AD_ASST	4400.0000	
FI_ACCOUNT	7920.0000	
FI_MGR	12008.0000	
HR_REP	6500.0000	
IT_PROG	5760.0000	
MK_MAN	13000.0000	
MK_REP	6000.0000	
PR_REP	10000.0000	
PU_CLERK	2780.0000	
PU_MAN	11000.0000	
SH_CLERK	3215.0000	
ST_CLERK	2785.0000	
ST_MAN	7280.0000	
*/
select job_id, avg(salary) as "Average salary greater than 6001 by job_id non executive, commission is null"
from employees
where job_id not in ('ad_pres', 'ad_vp')
and commission_pct is null
group by job_id
having avg(salary)>6001;
/*
job_id	Average salary greater than 6001 by job_id non executive, commission is null	
AC_ACCOUNT	8300.0000	
AC_MGR	12008.0000	
FI_ACCOUNT	7920.0000	
FI_MGR	12008.0000	
HR_REP	6500.0000	
MK_MAN	13000.0000	
PR_REP	10000.0000	
PU_MAN	11000.0000	
ST_MAN	7280.0000	
*/