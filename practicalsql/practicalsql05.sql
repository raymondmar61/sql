#Chapter 05 Basic Math And Stats With SQL (p 55)
#Modulo or remainder is %, exponent is ^, square root is |/ , cube root is ||/, factorial is !
#array[], unnest()
#PostreSQL has a built-in median() function at http://wiki.postgresql.org/wiki/Aggregate_median

select 11 / 6;  --return 1 as integer
select cast (11 / 6 as numeric(3,1));  --return 1.0 as numeric
#convert an integer to a decimal or integer to decimal
select cast (11 as numeric(3,1)), cast (11 as numeric(3,1)) / 6;  --return 11.0 as numeric, 1.8 as numeric
select 11.0 / 6;  --return 1.83333333 as numeric
select cast(11.0 / 6 as integer);  --return 2 as integer
select 11 % 6;  --return 5 as integer

select geo_name, state_us_abbreviation as "st", p0010003 as "white alone", p0010004 as "black alone", p0010003 + p0010004 as "total white and black"
from us_counties_2010;
select geo_name, state_us_abbreviation as "st", cast(p0010006 as numeric(8,1)) as "convert integer to numeric with .0", (cast (p0010006 as numeric(8,1))/p0010001) * 100 as "pct_asian"
from us_counties_2010
order by "pct_asian" desc;  --RM:  convert the numerator p0010006 to a numeric with .0 one decimal place to return result as a decimal; otherwise, return as an integer

create table percent_change (department varchar(20), spend_2014 numeric(10,2), spend_2017 numeric(10,2));
insert into percent_change
values ('building', 250000, 289000), ('assessor', 178556, 179500), ('library', 87777, 90001), ('clerk', 451980, 650000), ('police', 250000, 223000), ('recreation', 199000, 195000);
select department, spend_2014, spend_2017, spend_2017-spend_2014 as "difference", (spend_2017-spend_2014)/spend_2014, cast(((spend_2017-spend_2014)/spend_2014) as numeric(10,3)), round(((spend_2017-spend_2014)/spend_2014)*100,1) as "round", (spend_2017/spend_2014)-1 as "excelisfun"
from percent_change;  --round(number, decimal places)

select sum(p0010001) as "sum()", avg(p0010001) as "avg()", round(avg(p0010001),2), cast(avg(p0010001) as numeric(10,2))
from us_counties_2010;

create table percentile_test (numbers integer);
insert into percentile_test (numbers) values (1), (2), (3), (4), (5), (6);
#Calculate median use percentile_cont()
select percentile_cont(.5) within group (order by numbers), percentile_disc(.5) within group (order by numbers)
from percentile_test;

select sum(p0010001) as "county sum", avg(p0010001) as "county avg", round(avg(p0010001),0) as "county avg round", percentile_cont(.5) within group (order by p0010001) as "county median"
from us_counties_2010;

#quartiles or four equal groups, quintiles or five equal groups, and deciles or 10 equal groups
select percentile_cont(.25) within group (order by p0010001) as "first quartile or lowest 25%"
from us_counties_2010;
#using an array to calculate all four quartiles at once:
select percentile_cont(array[.25,.5,.75,1]) within group (order by p0010001) as "quartiles"
from us_counties_2010;  --RM:  I added 1.  .50 is the second quartile same as median.
select unnest(percentile_cont(array[.25,.5,.75,1]) within group (order by p0010001) as "quartiles")
from us_counties_2010;  --unnest() return results in separate rows or convert an array to rows

#mode
select mode() within group (order by p0010001)
from us_counties_2010;