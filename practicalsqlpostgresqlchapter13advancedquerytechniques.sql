--Practical SQL By Anthony DeBarros Second Edition Chapter 13 Advanced Query Techniques

--Which US counties at or greater than 90th percentile or top 10 percent in population?  An uncorrelated subquery.  The inner query returns 213707.3.
select countyname, statename, popest2019
from uscountiespopest2019
where popest2019 >= (
    select percentile_cont(.9) within group (order by popest2019)
    from uscountiespopest2019)
order by popest2019 desc;
'''
"countyname"	"statename"	"popest2019"
"Los Angeles County"	"California"	10039107
"Cook County"	"Illinois"	5150233
"Harris County"	"Texas"	4713325
"Maricopa County"	"Arizona"	4485414
"San Diego County"	"California"	3338330
"Orange County"	"California"	3175692
"Miami-Dade County"	"Florida"	2716940
"Dallas County"	"Texas"	2635516
"Kings County"	"New York"	2559903
"Riverside County"	"California"	2470546
"Clark County"	"Nevada"	2266715
...
'''
--A subquery returns rows and columns.  Use a subquery in the from clause.
select avg(popest2019) as averagepopulation2019, percentile_cont(.5) within group (order by popest2019)::numeric as medianpopulation2019
from uscountiespopest2019;
'''
"averagepopulation2019"	"medianpopulation2019"
104468.339592616168	25726
'''
select round(referencederivedtablecalcs.averagepopulation2019) as averageouterquery, referencederivedtablecalcs.medianpopulation2019, round(referencederivedtablecalcs.averagepopulation2019-referencederivedtablecalcs.medianpopulation2019,0) as medianaveragedifference
from (
    select avg(popest2019) as averagepopulation2019, percentile_cont(.5) within group (order by popest2019)::numeric as medianpopulation2019
from uscountiespopest2019) as referencederivedtablecalcs;
'''
"averageouterquery"	"medianpopulation2019"	"medianaveragedifference"
104468	25726	78742
'''
--A subquery returns rows and columns.  Join multiple tables as derived tables subquery in the from clause.  Find the top tourism-related businesses per 1,000 population by state.
select st, sum(establishments) as establishmentcount
from cbpnaics72establishments
group by st;
'''
"st"	"establishmentcount"
"Oklahoma"	8429
"North Carolina"	21756
"Colorado"	14307
"Mississippi"	5645
"Florida"	42949
"Vermont"	1991
"Delaware"	2240
"Nevada"	6943
"Louisiana"	9921
"New York"	55033
...
'''
select statename, sum(popest2018) as populationestimate2018
from uscountiespopest2019
group by statename;
'''
"statename"	"populationestimate2018"
"Oklahoma"	3940235
"North Carolina"	10381615
"Colorado"	5691287
"Mississippi"	2981020
"Florida"	21244317
"Vermont"	624358
"Delaware"	965479
"Nevada"	3027341
"Louisiana"	4659690
"New York"	19530351
...
'''
select census.statename as state, census.populationestimate2018, establishments.establishmentcount, round((establishments.establishmentcount/census.populationestimate2018::numeric)*1000,1) as establishmentsperthounsand
from (
    select st, sum(establishments) as establishmentcount
    from cbpnaics72establishments
    group by st) as establishments
    join
    (select statename, sum(popest2018) as populationestimate2018
    from uscountiespopest2019
    group by statename) as census
    on establishments.st = census.statename
order by establishmentsperthounsand desc;
'''
"state"	"populationestimate2018"	"establishmentcount"	"establishmentsperthounsand"
"District of Columbia"	701547	2754	3.9
"Montana"	1060665	3569	3.4
"Vermont"	624358	1991	3.2
"Maine"	1339057	4282	3.2
"Wyoming"	577601	1808	3.1
"Rhode Island"	1058287	3152	3.0
"Alaska"	735139	2186	3.0
"New Hampshire"	1353465	3841	2.8
"Oregon"	4181886	11796	2.8
"South Dakota"	878698	2504	2.8
...
'''
--Use a subquery in the column list after the select statement to generate a value for the column in the query result.  The subquery must generate one row.  The query below includes the median of all counties for each row in the column usmedianpopulation.
select countyname, statename as state, popest2019, (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019) as usmedianpopulation
from uscountiespopest2019;
'''
"countyname"	"state"	"popest2019"	"usmedianpopulation"
"Autauga County"	"Alabama"	55869	25726
"Baldwin County"	"Alabama"	223234	25726
"Barbour County"	"Alabama"	24686	25726
"Bibb County"	"Alabama"	22394	25726
"Blount County"	"Alabama"	57826	25726
"Bullock County"	"Alabama"	10101	25726
"Butler County"	"Alabama"	19448	25726
"Calhoun County"	"Alabama"	113605	25726
"Chambers County"	"Alabama"	33254	25726
"Cherokee County"	"Alabama"	26196	25726
"Chilton County"	"Alabama"	44428	25726
"Choctaw County"	"Alabama"	12589	25726
"Clarke County"	"Alabama"	23622	25726
"Clay County"	"Alabama"	13235	25726
"Cleburne County"	"Alabama"	14910	25726
...
'''
--Use a subquery in the column list after the select statement to generate a value for the column in the query result.  The subquery must generate one row.  The query below calculates the differences between the population and the median.
select countyname, statename as state, popest2019, popest2019 - (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019) as populationminusmedian
from uscountiespopest2019
where (popest2019 - (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019)) between -1000 and 1000;
'''
"countyname"	"state"	"popest2019"	"populationminusmedian"
"Cherokee County"	"Alabama"	26196	470
"Geneva County"	"Alabama"	26271	545
"Cleburne County"	"Arkansas"	24919	-807
"Johnson County"	"Arkansas"	26578	852
"St. Francis County"	"Arkansas"	24994	-732
...
'''
create table retirees (id int, firstname text, lastname text);
insert into retirees
values (2, 'Janet', 'King'), (4, 'Michael', 'Taylor');
select *
from employees;
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"
1	"Julia"	"Reyes"	115300.00	1
2	"Janet"	"King"	98000.00	1
3	"Arthur"	"Pappas"	72700.00	2
4	"Michael"	"Taylor"	89500.00	2
'''
--The subquery expression in works like the in operator.  The subquery provides a list of values to check.  Uncorrelated subquery which generate id values from the retirees table.  The values are used as a list for the in operator in the where clause.
select *
from employees
where empid in (
    select id
    from retirees)
order by empid;
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"
2	"Janet"	"King"	98000.00	1
4	"Michael"	"Taylor"	89500.00	2
'''
--The subquery expression exists returns a value of true if the subquery returns at least one row.  If it returns no rows, exists evalulates to false.
select *
from employees
where exists (
    select id
    from retirees
    where retirees.id = employees.empid);
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"
2	"Janet"	"King"	98000.00	1
4	"Michael"	"Taylor"	89500.00	2
'''
select *
from employees
where not exists (
    select id
    from retirees
    where retirees.id = employees.empid);
'''
"empid"	"firstname"	"lastname"	"salary"	"deptid"
1	"Julia"	"Reyes"	115300.00	1
3	"Arthur"	"Pappas"	72700.00	2
'''