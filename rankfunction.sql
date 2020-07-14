#https://www.sqltutorial.org/sql-window-functions/sql-rank/
#The rank() function assigns a rank to each row in the partition of a result set.
#Syntax:  rank() over (partition by <expr1>[{,<expr2>...}] order by <expr1> [asc|desc], [{,<expr2>...}])
#The partition by clause distributes the rows in the result set into partitions by one or more criteria.
#The order by clause sorts the rows in each partition
#The rank() function is operated on the rows of each partition and re-initialized when corssing each partition boundary.
#Multiple rows share the same rank the rank of the next row is not consecutive.

select emp_name, salary, rank() over (order by salary asc) as "Salary lowest to highest"
from employees;
/*
emp_name	salary	Salary lowest to highest
SANDRINE	900.00	1
JULIUS	1050.00	2
ADNRES	1200.00	3
MADDEN	1350.00	4
WADE	1350.00	4
MARKER	1400.00	6
TUCKER	1600.00	7
ADELYN	1700.00	8
CLARE	2550.00	9
BLAZE	2750.00	10
JONAS	2957.00	11
SCARLET	3100.00	12
FRANK	3100.00	12
KAYLING	6000.00	14
*/

select emp_name, salary, dense_rank() over (order by salary desc) denserankconsecutiveranknumbers
from employees;
/*
emp_name	salary	denserankconsecutiveranknumbers
KAYLING	6000.00	1
SCARLET	3100.00	2
FRANK	3100.00	2
JONAS	2957.00	3
BLAZE	2750.00	4
CLARE	2550.00	5
ADELYN	1700.00	6
TUCKER	1600.00	7
MARKER	1400.00	8
MADDEN	1350.00	9
WADE	1350.00	9
ADNRES	1200.00	10
JULIUS	1050.00	11
SANDRINE	900.00	12
*/

select rank() over (order by salary desc) rankcolumnname
from employees;
/*
rankcolumnname
1
2
2
4
5
6
7
8
9
10
10
12
13
14
*/

select rank() over (order by salary desc) ranknumber
from employees
where ranknumber = 2;
/*
nothing
*/

#RM  Subquery is the rank.  Primary query gets the second ranks.
select *
from (
	select rank() over (order by salary desc) rankcolumnname
	from employees) neednamehere
where rankcolumnname = 2;
/*
rankcolumnname
2
2
*/

#Find employees second highest salary.
select emp_name, emp_id, salary, rank() over (order by salary desc) salaryrank
from employees;
/*
emp_name	emp_id	salary	salaryrank
KAYLING	68319	6000.00	1
SCARLET	67858	3100.00	2
FRANK	69062	3100.00	2
JONAS	65646	2957.00	4
BLAZE	66928	2750.00	5
CLARE	67832	2550.00	6
ADELYN	64989	1700.00	7
TUCKER	68454	1600.00	8
MARKER	69324	1400.00	9
MADDEN	66564	1350.00	10
WADE	65271	1350.00	10
ADNRES	68736	1200.00	12
JULIUS	69000	1050.00	13
SANDRINE	63679	900.00	14
*/
select emp_name, emp_id, salary, rank() over (order by salary desc) salaryrank
from employees
where salaryrank = 2;
/*
nothing
*/
select *
from (
	select emp_name, emp_id, salary, rank() over (order by salary desc) salaryrank
	from employees) neednamehere
where salaryrank = 2;
/*
emp_name	emp_id	salary	salaryrank
SCARLET	67858	3100.00	2
FRANK	69062	3100.00	2
*/
select emp_name, emp_id, salary
from (
	select emp_name, emp_id, salary, rank() over (order by salary desc) salaryrank
	from employees) neednamehere
where salaryrank = 2;
/*
emp_name	emp_id	salary
SCARLET	67858	3100.00
FRANK	69062	3100.00
*/
select neednamehere.emp_name, neednamehere.emp_id, neednamehere.salary
from (
	select emp_name, emp_id, salary, rank() over (order by salary desc) salaryrank
	from employees) neednamehere
where neednamehere.salaryrank = 2;
/*
emp_name	emp_id	salary
SCARLET	67858	3100.00
FRANK	69062	3100.00
*/

#partition is like a group by.  Group the salaries by dep_id.
select emp_name, dep_id, salary, rank() over (partition by dep_id order by salary asc) salaryrank
from employees;
/*
emp_name	dep_id	salary	salaryrank
MARKER	1001	1400.00	1
CLARE	1001	2550.00	2
KAYLING	1001	6000.00	3
SANDRINE	2001	900.00	1
ADNRES	2001	1200.00	2
JONAS	2001	2957.00	3
SCARLET	2001	3100.00	4
FRANK	2001	3100.00	4
JULIUS	3001	1050.00	1
MADDEN	3001	1350.00	2
WADE	3001	1350.00	2
TUCKER	3001	1600.00	4
ADELYN	3001	1700.00	5
BLAZE	3001	2750.00	6
*/