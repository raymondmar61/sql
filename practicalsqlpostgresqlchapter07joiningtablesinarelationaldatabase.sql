#Practical SQL By Anthony DeBarros Second Edition Chapter 07 Joining Tables In A Relational Database
create table departments
(deptid integer, dept text, city text, constraint deptkey primary key (deptid), constraint deptcityunique unique (dept, city));  --deptkey is the constraint name for primary key column deptid.  deptcityunique is the constraint name for unique values column dept and column city as a pair.
create table employees
(empid integer, firstname text, lastname text, salary numeric(10,2), deptid integer references departments (deptid), constraint empkey primary key (empid));  --depid column references deptid column in departments table or join employees table and departments table.  depid in employees is the foreign key connected to depid in departments table.
insert into departments
values (1, 'Tax','Atlanta'),
(2, 'IT','Boston');
insert into employees
values (1,'Julia','Reyes',115300,1),
(2,'Janet','King',98000,1),
(3,'Arthur','Pappas',72700,2),
(4,'Michael','Taylor',89500,2);
select *
from departments;
'''
"deptid"	"dept"	"city"
1	"Tax"	"Atlanta"
2	"IT"	"Boston"
'''
select *
from employees;
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"
1	"Julia"	"Reyes"	115300.00	1
2	"Janet"	"King"	98000.00	1
3	"Arthur"	"Pappas"	72700.00	2
4	"Michael"	"Taylor"	89500.00	2
'''
select *
from employees join departments
on employees.deptid = departments.deptid
order by employees.deptid;
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"	"deptid"	"dept"	"city"
1	"Julia"	"Reyes"	115300.00	1	1	"Tax"	"Atlanta"
2	"Janet"	"King"	98000.00	1	1	"Tax"	"Atlanta"
3	"Arthur"	"Pappas"	72700.00	2	2	"IT"	"Boston"
4	"Michael"	"Taylor"	89500.00	2	2	"IT"	"Boston"
'''
create table district2020
(id integer constraint idkey2020 primary key, school2020 text);
create table district2035
(id integer constraint idkey2035 primary key, school2035 text);
insert into district2020
values (1, 'Oak Street School'),
(2, 'Roosevelt High School'),
(5, 'Dover Middle School'),
(6, 'Webutuck High School');
insert into district2035
values (1, 'Oak Street School'),
(2, 'Roosevelt High School'),
(3, 'Morrison Elementary'),
(4, 'Chase Magnet Academy'),
(6, 'Webutuck High School');
select *
from district2020 join district2035
on district2020.id = district2035.id
order by district2020.id;
'''
"id"	"school2020"	"id"	"school2035"
1	"Oak Street School"	1	"Oak Street School"
2	"Roosevelt High School"	2	"Roosevelt High School"
6	"Webutuck High School"	6	"Webutuck High School"
'''
select *
from district2020 join district2035
using (id)
order by district2020.id;
'''
"id"	"school2020"	"school2035"
1	"Oak Street School"	"Oak Street School"
2	"Roosevelt High School"	"Roosevelt High School"
6	"Webutuck High School"	"Webutuck High School"
'''
select *
from district2020 left join district2035
on district2020.id = district2035.id
order by district2020.id;
'''
"id"	"school2020"	"id"	"school2035"
1	"Oak Street School"	1	"Oak Street School"
2	"Roosevelt High School"	2	"Roosevelt High School"
5	"Dover Middle School"		
6	"Webutuck High School"	6	"Webutuck High School"
'''
select *
from district2020 right join district2035
on district2020.id = district2035.id
order by district2020.id;
'''
"id"	"school2020"	"id"	"school2035"
1	"Oak Street School"	1	"Oak Street School"
2	"Roosevelt High School"	2	"Roosevelt High School"
6	"Webutuck High School"	6	"Webutuck High School"
		3	"Morrison Elementary"
		4	"Chase Magnet Academy"
'''
select *
from district2020 right join district2035
using (id)
order by district2020.id;
'''
"id"	"school2020"	"school2035"
1	"Oak Street School"	"Oak Street School"
2	"Roosevelt High School"	"Roosevelt High School"
6	"Webutuck High School"	"Webutuck High School"
3		"Morrison Elementary"
4		"Chase Magnet Academy"
'''
select *
from district2020 full outer join district2035
on district2020.id = district2035.id
order by district2020.id;
--Return all rows from both tables regardless of match or no match
'''
"id"	"school2020"	"id"	"school2035"
1	"Oak Street School"	1	"Oak Street School"
2	"Roosevelt High School"	2	"Roosevelt High School"
5	"Dover Middle School"		
6	"Webutuck High School"	6	"Webutuck High School"
		4	"Chase Magnet Academy"
		3	"Morrison Elementary"
'''
select *
from district2020 cross join district2035
order by district2020.id;
--Return all possible combination or rows.  Cartesian product.
'''
"id"	"school2020"	"id"	"school2035"
1	"Oak Street School"	1	"Oak Street School"
1	"Oak Street School"	2	"Roosevelt High School"
1	"Oak Street School"	3	"Morrison Elementary"
1	"Oak Street School"	4	"Chase Magnet Academy"
1	"Oak Street School"	6	"Webutuck High School"
2	"Roosevelt High School"	1	"Oak Street School"
...
5	"Dover Middle School"	6	"Webutuck High School"
6	"Webutuck High School"	1	"Oak Street School"
6	"Webutuck High School"	2	"Roosevelt High School"
6	"Webutuck High School"	3	"Morrison Elementary"
6	"Webutuck High School"	4	"Chase Magnet Academy"
6	"Webutuck High School"	6	"Webutuck High School"
'''
select *
from district2020 left join district2035
on district2020.id = district2035.id
where district2035.id is null;
--anti-join or antijoin
'''
"id"	"school2020"	"id"	"school2035"
5	"Dover Middle School"		
'''
select *
from district2020 right join district2035
on district2020.id = district2035.id
where district2020.id is null;
--anti-join or antijoin
'''
"id"	"school2020"	"id"	"school2035"
		3	"Morrison Elementary"
		4	"Chase Magnet Academy"
'''
select district2020.id as "column alias double quote", district2020.school2020, district2035.school2035
from district2020 left join district2035
on district2020.id = district2035.id
order by district2020.id;
'''
"column alias double quote"	"school2020"	"school2035"
1	"Oak Street School"	"Oak Street School"
2	"Roosevelt High School"	"Roosevelt High School"
5	"Dover Middle School"	
6	"Webutuck High School"	"Webutuck High School"
'''
select d20.id as "column alias double quote", d20.school2020 columnaliasoneword, d35.school2035 "table aliases"
from district2020 d20 left join district2035 d35
on d20.id = d35.id
order by d20.id;
'''
"column alias double quote"	"columnaliasoneword"	"table aliases"
1	"Oak Street School"	"Oak Street School"
2	"Roosevelt High School"	"Roosevelt High School"
5	"Dover Middle School"	
6	"Webutuck High School"	"Webutuck High School"
'''
create table district2020enrollment
(id integer, enrollment integer);
create table district2020grades
(id integer, grades varchar(10));
insert into district2020enrollment
values (1, 360),
(2, 1001),
(5, 450),
(6, 927);
insert into district2020grades
values (1, 'K-3'),
(2, '9-12'),
(5, '6-8'),
(6, '9-12');
select d20.id, d20.school2020, en20.enrollment
from district2020 d20 join district2020enrollment en20
on d20.id = en20.id;
'''
"id"	"school2020"	"enrollment"
1	"Oak Street School"	360
2	"Roosevelt High School"	1001
5	"Dover Middle School"	450
6	"Webutuck High School"	927
'''
select d20.id, d20.school2020, gr20.grades
from district2020 d20 join district2020grades gr20
on d20.id = gr20.id;
'''
"id"	"school2020"	"grades"
1	"Oak Street School"	"K-3"
2	"Roosevelt High School"	"9-12"
5	"Dover Middle School"	"6-8"
6	"Webutuck High School"	"9-12"
'''
select d20.id, d20.school2020, gr20.grades, en20.enrollment
from district2020 d20 join district2020grades gr20
on d20.id = gr20.id
join district2020enrollment en20
on d20.id = en20.id;
'''
"id"	"school2020"	"grades"	"enrollment"
1	"Oak Street School"	"K-3"	360
2	"Roosevelt High School"	"9-12"	1001
5	"Dover Middle School"	"6-8"	450
6	"Webutuck High School"	"9-12"	927
'''
select *
from district2020 d20
union
select *
from district2035 d35
order by id;  --RM order by district2020.id error message ERROR:  missing FROM-clause entry for table "district2020"
'''
"id"	"school2020"
1	"Oak Street School"
2	"Roosevelt High School"
3	"Morrison Elementary"
4	"Chase Magnet Academy"
5	"Dover Middle School"
6	"Webutuck High School"
'''
select *
from district2020 d20
union all
select *
from district2035 d35
order by id;
'''
"id"	"school2020"
1	"Oak Street School"
1	"Oak Street School"
2	"Roosevelt High School"
2	"Roosevelt High School"
3	"Morrison Elementary"
4	"Chase Magnet Academy"
5	"Dover Middle School"
6	"Webutuck High School"
6	"Webutuck High School"
'''
select '2020 value from district2020 table' as "column name year", school2020 as "column name school"
from district2020
union all
select '2035 value from district2035 table' as "column name year", school2035 as "column name school"
from district2035
order by 1, 2;
--assign value to a row or assign row value
'''
"column name year"	"column name school"
"2020 value from district2020 table"	"Dover Middle School"
"2020 value from district2020 table"	"Oak Street School"
"2020 value from district2020 table"	"Roosevelt High School"
"2020 value from district2020 table"	"Webutuck High School"
"2035 value from district2035 table"	"Chase Magnet Academy"
"2035 value from district2035 table"	"Morrison Elementary"
"2035 value from district2035 table"	"Oak Street School"
"2035 value from district2035 table"	"Roosevelt High School"
"2035 value from district2035 table"	"Webutuck High School"
'''
select *
from district2020
intersect
select *
from district2035;
'''
"id"	"school2020"
1	"Oak Street School"
2	"Roosevelt High School"
6	"Webutuck High School"
'''
select *
from district2020
except
select *
from district2035;
--all rows in the first query and not in the second query; in other words, rows in the first query which doesn't exist in the second query and no duplicates in the first query and the second query.
'''
"id"	"school2020"
5	"Dover Middle School"
'''
create table uscountiespopest2010
(statefips text, countyfips text, region smallint, statename text, countyname text, estimatesbase2010 integer, constraint counties2010key primary key (statefips, countyfips));
--RM all of the grant select didn't work.  Solution go to /home/mar/postgresql/ in Linux file explorer.  Open Properties.  Under Permissions press Change Permissions for Enclosed Files.  Under Others:  Select Read and Write for Files and Create and delete files for Folders.
copy uscountiespopest2010
from '/home/mar/postgresql/us_counties_pop_est_2010.csv'
with (format csv, header);
select *
from uscountiespopest2010;
'''
"statefips"	"countyfips"	"region"	"statename"	"countyname"	"estimatesbase2010"
"01"	"001"	3	"Alabama"	"Autauga County"	54597
"01"	"003"	3	"Alabama"	"Baldwin County"	182265
"01"	"005"	3	"Alabama"	"Barbour County"	27455
"01"	"007"	3	"Alabama"	"Bibb County"	22915
...
'''
select c2019.countyname, c2019.statename, c2019.popest2019 as pop2019, c2010.estimatesbase2010 as pop2010, c2019.popest2019-c2010.estimatesbase2010 as rawchange, round((c2019.popest2019::numeric-c2010.estimatesbase2010)/c2010.estimatesbase2010*100,1) as pctchange
from uscountiespopest2019 as c2019 join uscountiespopest2010 as c2010
on c2019.statefips = c2010.statefips
and c2019.countyfips = c2010.countyfips
order by pctchange desc
limit 20;
'''
"countyname"	"statename"	"pop2019"	"pop2010"	"rawchange"	"pctchange"
"McKenzie County"	"North Dakota"	15024	6359	8665	136.3
"Loving County"	"Texas"	169	82	87	106.1
"Williams County"	"North Dakota"	37589	22399	15190	67.8
"Hays County"	"Texas"	230191	157103	73088	46.5
"Wasatch County"	"Utah"	34091	23525	10566	44.9
"Comal County"	"Texas"	156209	108520	47689	43.9
"Trousdale County"	"Tennessee"	11284	7864	3420	43.5
"Kendall County"	"Texas"	47431	33384	14047	42.1
"Sumter County"	"Florida"	132420	93420	39000	41.7
"Dallas County"	"Iowa"	93453	66139	27314	41.3
"Hudspeth County"	"Texas"	4886	3476	1410	40.6
"Williamson County"	"Texas"	590551	422504	168047	39.8
"Osceola County"	"Florida"	375751	268685	107066	39.8
"St. Johns County"	"Florida"	264672	190038	74634	39.3
"Forsyth County"	"Georgia"	244252	175484	68768	39.2
"Fort Bend County"	"Texas"	811688	584699	226989	38.8
"Mountrail County"	"North Dakota"	10545	7663	2882	37.6
"Lincoln County"	"South Dakota"	61128	44823	16305	36.4
"Long County"	"Georgia"	19559	14344	5215	36.4
"Walton County"	"Florida"	74071	55046	19025	34.6
'''