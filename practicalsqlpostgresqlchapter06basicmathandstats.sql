#Practical SQL By Anthony DeBarros Second Edition Chapter 06 Basic Math And Stats With SQL
select 11 / 6; --return 1
select 11 % 6; --return 5
select 11.0 / 6; --return 1.8333...
select cast(11/6 as numeric(3,1)); --return 1.0
select cast(11/6 as numeric(3,2)); --return 1.00
select cast(11.0/6 as numeric(3,1)); --return 1.8
select cast(11.0/6 as numeric(3,2)); --return 1.83

select countyname as county, statename as state, popest2019 as pop, births2019 as births, deaths2019 as deaths, internationalmigr2019 as intmigr, domesticmigr2019 as dommigr, residual2019 as residual
from uscountiespopest2019
limit 5;
select countyname as county, statename as state, popest2019 as pop, births2019 as births, deaths2019 as deaths, births2019-deaths2019 as "natural increase"
from uscountiespopest2019
order by statename, countyname
limit 10;
-- "county"	"state"	"pop"	"births"	"deaths"	"natural increase"
-- "Autauga County"	"Alabama"	55869	624	541	83
-- "Baldwin County"	"Alabama"	223234	2304	2326	-22
-- "Barbour County"	"Alabama"	24686	256	312	-56
-- "Bibb County"	"Alabama"	22394	240	252	-12
-- "Blount County"	"Alabama"	57826	651	657	-6
-- "Bullock County"	"Alabama"	10101	109	109	0
-- "Butler County"	"Alabama"	19448	213	272	-59
-- "Calhoun County"	"Alabama"	113605	1269	1532	-263
-- "Chambers County"	"Alabama"	33254	354	441	-87
-- "Cherokee County"	"Alabama"	26196	222	343	-121
select countyname as county, statename as state, popest2019 as pop, popest2018+births2019-deaths2019+internationalmigr2019+domesticmigr2019+residual2019 as componentstotal, popest2019-(popest2018+births2019-deaths2019+internationalmigr2019+domesticmigr2019+residual2019) as difference
from uscountiespopest2019
order by difference desc
limit 10;
-- "county"	"state"	"pop"	"componentstotal"	"difference"
-- "Baldwin County"	"Alabama"	223234	223234	0
-- "Barbour County"	"Alabama"	24686	24686	0
-- "Bibb County"	"Alabama"	22394	22394	0
-- "Blount County"	"Alabama"	57826	57826	0
-- "Bullock County"	"Alabama"	10101	10101	0
-- "Butler County"	"Alabama"	19448	19448	0
-- "Calhoun County"	"Alabama"	113605	113605	0
-- "Chambers County"	"Alabama"	33254	33254	0
-- "Cherokee County"	"Alabama"	26196	26196	0
-- "Autauga County"	"Alabama"	55869	55869	0
select areawater
from uscountiespopest2019;

select countyname as county, statename as state, areawater::numeric/(arealand+areawater)*100 as pctwater
from uscountiespopest2019
order by pctwater desc
limit 10;  --convert areawater from integer to numeric to force decimal division.  cast function also works cast(areawater as numeric)/(arealand+areawater)*100.  No need for numeric(n,m) and the (n,m) becuase there are no decimals in areawater column.  areawater is bigint data type.
-- "county"	"state"	"pctwater"
-- "Keweenaw County"	"Michigan"	90.94723747453215452900
-- "Leelanau County"	"Michigan"	86.28858968116583102500
-- "Nantucket County"	"Massachusetts"	84.79692499185512352300
-- "St. Bernard Parish"	"Louisiana"	82.48371149202893908400
-- "Alger County"	"Michigan"	81.87221940647501072300
-- "Poquoson city"	"Virginia"	80.40389402657759344700
-- "San Francisco County"	"California"	79.77367709452497582300
-- "Milwaukee County"	"Wisconsin"	79.69909378165810708600
-- "Door County"	"Wisconsin"	79.66604636653490265300
-- "Ozaukee County"	"Wisconsin"	79.12386437929306125800

drop table percentchange;  --RM:  deleted table because initial table created spendnumbers entered incorrectly
create table percentchange (department text, spend2019 numeric(10,2), spend2022 numeric(10,2));
insert into percentchange values
('Assessor',178556,179500),
('Building',250000,289000),
('Clerk',451980,650000),
('Library',87777,90001),
('Parks',250000,223000),
('Water',199000,195000);
select department, spend2019, spend2022, round(((spend2022-spend2019)/spend2019)*100,1) as pctchange
from percentchange;
-- "department"	"spend2019"	"spend2022"	"pctchange"
-- "Assessor"	178556.00	179500.00	0.5
-- "Building"	25000.00	289000.00	1056.0
-- "Clerk"	451980.00	650000.00	43.8
-- "Library"	87777.00	90001.00	2.5
-- "Parks"	25000.00	223000.00	792.0
-- "Water"	199000.00	195000.00	-2.0

select sum(popest2019) as countysum2019, round(avg(popest2019),1) as countyaverage2019
from uscountiespopest2019;
-- "countysum2019"	"countyaverage2019"
-- 328239523	104468.3

create table percentiletest (numbers integer);
insert into percentiletest (numbers) values
(1),
(2),
(3),
(4),
(5),
(6);
select *
from percentiletest;
-- "numbers"
-- 1
-- 2
-- 3
-- 4
-- 5
-- 6
--Percentile function.  percentile_cont(n) calculates percentiles as continuous values or the result doesn't have to be one of the numbers in the dataset for which the result can be a decimal value in between two of the numbers; in other words, exact median definition.  percentile_disc(n) calculates percnetiles as discrete values or the result is rounded to one of the numbers.  n is the percentile in decimal format.
select percentile_cont(.5) within group (order by numbers), percentile_disc(.5) within group (order by numbers)
from percentiletest;  --percentile_disc is 3 which is the last value in the first 50 percent of the numbers.
-- "percentile_cont"	"percentile_disc"
-- 3.5	3
select sum(popest2019) as countysum2019, round(avg(popest2019),1) as countyaverage2019, percentile_cont(.5) within group (order by popest2019) as countymedian
from uscountiespopest2019;
-- "countysum2019"	"countyaverage2019"	"countymedian"
-- 328239523	104468.3	25726
--The percentile function can calculate other quantiles such as quartiles or four equal groups, quintiles or five equal groups, and deciles or ten equal groups.  first quartile use percentile_cont(.25).  Quartiles use an array percentile_cont(array[.25, .5, .75, 1.0]).
select percentile_cont(array[.25, .5, .75, 1.0]) within group (order by popest2019) as "population quartiles"
from uscountiespopest2019;  --10,902.5 is 25 percent counties population equal or lower, 25,726 is second quartile and the median, 68072.75 is the largest 25 percent of counties have at least 68,072.75.
-- "population quartiles"
-- {10902.5,25726,68072.75,10039107}
select unnest(percentile_cont(array[.25, .5, .75, 1.0]) within group (order by popest2019)) as "population quartiles separated rows"
from uscountiespopest2019;  --unnest function converts an array to rows
-- "population quartiles separated rows"
-- 10902.5
-- 25726
-- 68072.75
-- 10039107

select mode() within group (order by births2019) as "most common births in births2019 column"
from uscountiespopest2019;  --return 86
select mode() within group (order by deaths2019) as "most common deaths in deaths2019 column"
from uscountiespopest2019;  --return 57