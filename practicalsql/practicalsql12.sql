#Chapter 12 Advanced Query Techniques (p 191)

#Subqueries is like the subquery returns multiple rows and treat the results as a table in the from clause of the main query.  A scalar subquery that returns a single value and use it as part of an expression to filter rows via where, in, and having clauses.  An update table query can be a subquery.

--use subquery in where clause
--find USA counties above 90th percentile or top 10% for population sorted by population p0010001 highest to lowest
select geo_name, state_us_abbreviation, p0010001
from us_counties_2010
where p0010001 >= (
	select percentile_cont(.9) within group (order by p0010001)
	from us_counties_2010)
order by p0010001 desc;  --the subquery returns 197444.6 which means all counties population greater than or equal to 197444.6

--create a top 10% population table
create table us_counties_2010_top10 as
	select *
	from us_counties_2010;
delete from us_counties_2010_top10
where p0010001 < (
	select percentile_cont(.9) within group (order by p0010001)
	from us_counties_2010_top10);
select *
from us_counties_2010_top10
order by p0010001 desc;
drop table us_counties_2010_top10;

--use subqery in from clause.  Give the subquery in from clause an alias derivedtable.  Derived table is a subquery returns rows and columns of data converted to a table by placing it in a from clause.
select avg(p0010001) as "average population 98232.751511294941", percentile_cont(.5) within group (order by p0010001)::numeric(10,1) as "median population 25857.0"
from us_counties_2010;
select round(derivedtable."average population 98232.751511294941", 0) as "average 98233", derivedtable."median population 25857.0" as "median 25857.0", round(derivedtable."average population 98232.751511294941" - derivedtable."median population 25857.0", 0) as "subtract average population from median population 72367"
from (
     select avg(p0010001) as "average population 98232.751511294941", percentile_cont(.5) within group (order by p0010001)::numeric(10,1) as "median population 25857.0"
     from us_counties_2010)
as derivedtable;

--RM:  Begin page 195 Joining Derived Tables 06/18/18.