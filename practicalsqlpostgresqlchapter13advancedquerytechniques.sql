--Practical SQL By Anthony DeBarros Second Edition Chapter 13 Advanced Query Techniques

--Which US counties at or greater than 90th percentile or top 10 percent in population?  An uncorrelated subquery.  The inner query returns 213707.3.
select countyname, statename, popest2019
from uscountiespopest2019
where popest2019 >= (
    select percentile_cont(.9) within group (order by popest2019)
    from uscountiespopest2019)
order by popest2019 desc;
'''
"countyname"    "statename" "popest2019"
"Los Angeles County"    "California"    10039107
"Cook County"   "Illinois"  5150233
"Harris County" "Texas" 4713325
"Maricopa County"   "Arizona"   4485414
"San Diego County"  "California"    3338330
"Orange County" "California"    3175692
"Miami-Dade County" "Florida"   2716940
"Dallas County" "Texas" 2635516
"Kings County"  "New York"  2559903
"Riverside County"  "California"    2470546
"Clark County"  "Nevada"    2266715
...
'''
--A subquery returns rows and columns.  Use a subquery in the from clause.
select avg(popest2019) as averagepopulation2019, percentile_cont(.5) within group (order by popest2019)::numeric as medianpopulation2019
from uscountiespopest2019;
'''
"averagepopulation2019" "medianpopulation2019"
104468.339592616168 25726
'''
select round(referencederivedtablecalcs.averagepopulation2019) as averageouterquery, referencederivedtablecalcs.medianpopulation2019, round(referencederivedtablecalcs.averagepopulation2019-referencederivedtablecalcs.medianpopulation2019,0) as medianaveragedifference
from (
    select avg(popest2019) as averagepopulation2019, percentile_cont(.5) within group (order by popest2019)::numeric as medianpopulation2019
from uscountiespopest2019) as referencederivedtablecalcs;
'''
"averageouterquery" "medianpopulation2019"  "medianaveragedifference"
104468  25726   78742
'''
--A subquery returns rows and columns.  Join multiple tables as derived tables subquery in the from clause.  Find the top tourism-related businesses per 1,000 population by state.
select st, sum(establishments) as establishmentcount
from cbpnaics72establishments
group by st;
'''
"st"    "establishmentcount"
"Oklahoma"  8429
"North Carolina"    21756
"Colorado"  14307
"Mississippi"   5645
"Florida"   42949
"Vermont"   1991
"Delaware"  2240
"Nevada"    6943
"Louisiana" 9921
"New York"  55033
...
'''
select statename, sum(popest2018) as populationestimate2018
from uscountiespopest2019
group by statename;
'''
"statename" "populationestimate2018"
"Oklahoma"  3940235
"North Carolina"    10381615
"Colorado"  5691287
"Mississippi"   2981020
"Florida"   21244317
"Vermont"   624358
"Delaware"  965479
"Nevada"    3027341
"Louisiana" 4659690
"New York"  19530351
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
"state" "populationestimate2018"    "establishmentcount"    "establishmentsperthounsand"
"District of Columbia"  701547  2754    3.9
"Montana"   1060665 3569    3.4
"Vermont"   624358  1991    3.2
"Maine" 1339057 4282    3.2
"Wyoming"   577601  1808    3.1
"Rhode Island"  1058287 3152    3.0
"Alaska"    735139  2186    3.0
"New Hampshire" 1353465 3841    2.8
"Oregon"    4181886 11796   2.8
"South Dakota"  878698  2504    2.8
...
'''
--Use a subquery in the column list after the select statement to generate a value for the column in the query result.  The subquery must generate one row.  The query below includes the median of all counties for each row in the column usmedianpopulation.
select countyname, statename as state, popest2019, (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019) as usmedianpopulation
from uscountiespopest2019;
'''
"countyname"    "state" "popest2019"    "usmedianpopulation"
"Autauga County"    "Alabama"   55869   25726
"Baldwin County"    "Alabama"   223234  25726
"Barbour County"    "Alabama"   24686   25726
"Bibb County"   "Alabama"   22394   25726
"Blount County" "Alabama"   57826   25726
"Bullock County"    "Alabama"   10101   25726
"Butler County" "Alabama"   19448   25726
"Calhoun County"    "Alabama"   113605  25726
"Chambers County"   "Alabama"   33254   25726
"Cherokee County"   "Alabama"   26196   25726
"Chilton County"    "Alabama"   44428   25726
"Choctaw County"    "Alabama"   12589   25726
"Clarke County" "Alabama"   23622   25726
"Clay County"   "Alabama"   13235   25726
"Cleburne County"   "Alabama"   14910   25726
...
'''
--Use a subquery in the column list after the select statement to generate a value for the column in the query result.  The subquery must generate one row.  The query below calculates the differences between the population and the median.
select countyname, statename as state, popest2019, popest2019 - (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019) as populationminusmedian
from uscountiespopest2019
where (popest2019 - (select percentile_cont(.5) within group (order by popest2019) from uscountiespopest2019)) between -1000 and 1000;
'''
"countyname"    "state" "popest2019"    "populationminusmedian"
"Cherokee County"   "Alabama"   26196   470
"Geneva County" "Alabama"   26271   545
"Cleburne County"   "Arkansas"  24919   -807
"Johnson County"    "Arkansas"  26578   852
"St. Francis County"    "Arkansas"  24994   -732
...
'''
create table retirees (id int, firstname text, lastname text);
insert into retirees
values (2, 'Janet', 'King'), (4, 'Michael', 'Taylor');
select *
from employees;
'''
"empid" "firstname" "lastname"  "salary"    "deptid"
1   "Julia" "Reyes" 115300.00   1
2   "Janet" "King"  98000.00    1
3   "Arthur"    "Pappas"    72700.00    2
4   "Michael"   "Taylor"    89500.00    2
'''
--The subquery expression in works like the in operator.  The subquery provides a list of values to check.  Uncorrelated subquery which generate id values from the retirees table.  The values are used as a list for the in operator in the where clause.
select *
from employees
where empid in (
    select id
    from retirees)
order by empid;
'''
"empid" "firstname" "lastname"  "salary"    "deptid"
2   "Janet" "King"  98000.00    1
4   "Michael"   "Taylor"    89500.00    2
'''
--The subquery expression exists returns a value of true if the subquery returns at least one row.  If it returns no rows, exists evalulates to false.
select *
from employees
where exists (
    select id
    from retirees
    where retirees.id = employees.empid);
'''
"empid" "firstname" "lastname"  "salary"    "deptid"
2   "Janet" "King"  98000.00    1
4   "Michael"   "Taylor"    89500.00    2
'''
select *
from employees
where not exists (
    select id
    from retirees
    where retirees.id = employees.empid);
'''
"empid" "firstname" "lastname"  "salary"    "deptid"
1   "Julia" "Reyes" 115300.00   1
3   "Arthur"    "Pappas"    72700.00    2
'''
--The keyword lateral before subqueries in a from clause adds functionality to simply complicated queries
select countyname, statename, popest2018, popest2019, rawchange, round(percentagechange*100,2) as percentagechangecolumn
from uscountiespopest2019, (select popest2019-popest2018 as rawchange) rc, (select rawchange/popest2018::numeric as percentagechange) pc
order by percentagechange desc;  --ERROR:  column "popest2019" does not exist LINE 2: from uscountiespopest2019, (select popest2019-popest2018 as ...
--The first lateral rc takes the popest2019 and stract popest2018 as rawchange alias.  The lateral subquery reference a table listed before in the from clause without needing to specify its name.  Subqueries in the from must have an alias which is rc.  Likewise for the second lateral pc which calculates the percentage change in population from 2018 to 2019 referencing rawchange from the first subquery.
select countyname, statename, popest2018, popest2019, rawchange, round(percentagechange*100,2) as percentagechangecolumn
from uscountiespopest2019, lateral (select popest2019-popest2018 as rawchange) rc, lateral (select rawchange/popest2018::numeric as percentagechange) pc
order by percentagechange desc;
'''
"countyname"    "statename" "popest2018"    "popest2019"    "rawchange" "percentagechangecolumn"
"Loving County" "Texas" 148 169 21  14.19
"McKenzie County"   "North Dakota"  13594   15024   1430    10.52
"Loup County"   "Nebraska"  617 664 47  7.62
"Kaufman County"    "Texas" 128279  136154  7875    6.14
"Williams County"   "North Dakota"  35469   37589   2120    5.98
"Esmeralda County"  "Nevada"    827 873 46  5.56
"Comal County"  "Texas" 148141  156209  8068    5.45
"Lee County"    "Kentucky"  7052    7403    351 4.98
"Kent County"   "Texas" 726 762 36  4.96
"Walton County" "Florida"   70732   74071   3339    4.72
...
'''
--Combine lateral with join creates functionality similar to a for loop.  For each row generated by the query in front of the lateral join, a subquery or function after the lateral join is evalulated once.
alter table teachers add constraint id_key primary key (id);
create table teacherslabaccess (accessid bigint primary key generated always as identity, accesstime timestamp with time zone, labname text, teacherid bigint references teachers (id));
insert into teacherslabaccess (accesstime, labname, teacherid)
values ('2022-11-30 08:59:00-05', 'Science A', 2),
('2022-12-01 08:58:00-05', 'Chemistry B', 2),
('2022-12-21 09:01:00-05', 'Chemistry A', 2),
('2022-12-02 11:01:00-05', 'Science B', 6),
('2022-12-07 10:02:00-05', 'Science A', 6),
('2022-12-17 16:00:00-05', 'Science B', 6);
select *
from teacherslabaccess;
'''
"accessid"  "accesstime"    "labname"   "teacherid"
1   "2022-11-30 05:59:00-08"    "Science A" 2
2   "2022-12-01 05:58:00-08"    "Chemistry B"   2
3   "2022-12-21 06:01:00-08"    "Chemistry A"   2
4   "2022-12-02 08:01:00-08"    "Science B" 6
5   "2022-12-07 07:02:00-08"    "Science A" 6
6   "2022-12-17 13:00:00-08"    "Science B" 6
'''
--In the select statement, we left join teachers with teacherslabaccess with the lateral keyword which means for each row returned in teachers, the subquery executes returning to the most recent labs accessed by the teacher and the times accessed.  Left join returns all rows in teachers table regardless whether the subquery aliaslab finds a matching teacher in teacherslabaccess table.  The true in the on keyword creates the join without naming specific columnd to join upon.
select t.firstname, t.lastname, aliaslab.accesstime, aliaslab.labname
from teachers t left join lateral (select * from teacherslabaccess where teacherid=t.id order by accesstime desc limit 2) aliaslab
on true
order by t.id;
'''
"firstname" "lastname"  "accesstime"    "labname"
"Janet" "Smith"     
"Lee"   "Reynolds"  "2022-12-21 06:01:00-08"    "Chemistry A"
"Lee"   "Reynolds"  "2022-12-01 05:58:00-08"    "Chemistry B"
"Samuel"    "Cole"      
"Samanta"   "Bush"      
"Betty" "Diaz"      
"Kathleen"  "Roush" "2022-12-17 13:00:00-08"    "Science B"
"Kathleen"  "Roush" "2022-12-07 07:02:00-08"    "Science A"
'''
--Common table expression used for temporary tables define using a with as statement.
with largecountiestemporarytable (countyname, statename, popest2019) as (
    select countyname, statename, popest2019
    from uscountiespopest2019
    where popest2019 >=100000)
select statename, count(*)
from largecountiestemporarytable
group by statename
order by count(*) desc;
'''
"statename" "count"
"Texas" 40
"Florida"   36
"California"    35
"Pennsylvania"  31
"New York"  28
"North Carolina"    28
"Ohio"  27
"Georgia"   25
"Michigan"  20
"Illinois"  20
...
'''
with countiestemporarytable (st, popest2018) as (
    select statename, sum(popest2018)
    from uscountiespopest2019
    group by statename),
establishmentstemporarytable (st, establishmentcount) as (
    select st, sum(establishments) as establishmentcountsum
    from cbpnaics72establishments
    group by st)
select countiestemporarytable.st, popest2018, establishmentstemporarytable.establishmentcount, round((establishmentstemporarytable.establishmentcount/countiestemporarytable.popest2018::numeric(10,1))*1000,1) as establishmentsperthousand
from countiestemporarytable join establishmentstemporarytable
on countiestemporarytable.st=establishmentstemporarytable.st
order by establishmentsperthousand desc;
'''
"st"    "popest2018"    "establishmentcount"    "establishmentsperthousand"
"District of Columbia"  701547  2754    3.9
"Montana"   1060665 3569    3.4
"Vermont"   624358  1991    3.2
"Maine" 1339057 4282    3.2
"Wyoming"   577601  1808    3.1
"Rhode Island"  1058287 3152    3.0
"Alaska"    735139  2186    3.0
"New Hampshire" 1353465 3841    2.8
"Oregon"    4181886 11796   2.8
"South Dakota"  878698  2504    2.8
...
'''
--Use a common table expression for a temporary table used in the select statement.
with usmediantemporarytable as (
    select percentile_cont(.5) within group (order by popest2019)as usmedianpopulation
    from uscountiespopest2019)
select countyname, statename as st, popest2019, usmedianpopulation, popest2019 - usmedianpopulation as differencefrommedian
from uscountiespopest2019 cross join usmediantemporarytable
where (popest2019 - usmedianpopulation) between -1000 and 1000;
'''
"countyname"    "st"    "popest2019"    "usmedianpopulation"    "differencefrommedian"
"Cherokee County"   "Alabama"   26196   25726   470
"Geneva County" "Alabama"   26271   25726   545
"Cleburne County"   "Arkansas"  24919   25726   -807
"Johnson County"    "Arkansas"  26578   25726   852
"St. Francis County"    "Arkansas"  24994   25726   -732
"Montezuma County"  "Colorado"  26183   25726   457
"Routt County"  "Colorado"  25638   25726   -88
"Teller County" "Colorado"  25388   25726   -338
"Washington County" "Florida"   25473   25726   -253
"Butts County"  "Georgia"   24936   25726   -790
...
'''
--Case statement as conditional expression if then.
select maxtemp, case when maxtemp >=90 then 'Hot' when maxtemp >=70 and maxtemp <90 then 'Warm' when maxtemp>=50 and maxtemp<70 then 'Pleasant' when maxtemp>=33 and maxtemp<50 then 'Cold' when maxtemp>=20 and maxtemp<33 then 'Frigid' when maxtemp <20 then 'Inhumane' else 'No reading' end as temperaturegroupcolumnname
from temperaturereadingstabledoesntexist
order by stationname, observationdate;
with temperaturecollapsedtemporarytable (stationname, maxtemperaturegroup) as (
    select stationname, ase when maxtemp >=90 then 'Hot' when maxtemp >=70 and maxtemp <90 then 'Warm' when maxtemp>=50 and maxtemp<70 then 'Pleasant' when maxtemp>=33 and maxtemp<50 then 'Cold' when maxtemp>=20 and maxtemp<33 then 'Frigid' when maxtemp <20 then 'Inhumane' else 'No reading' end
    from temperaturereadingstabledoesntexist)
select stationname, maxtemperaturegroup, count(*)
from temperaturecollapsedtemporarytable
group by stationname, maxtemperaturegroup
order by stationname, count(*) desc;