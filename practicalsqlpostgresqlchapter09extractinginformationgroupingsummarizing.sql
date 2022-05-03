--Practical SQL By Anthony DeBarros Second Edition Chapter 09 Extracting Information By Grouping And Summarizing

create table plsfy2018libraries
(stabr text not null, fscskey text constraint fscskey2018pkey primary key, libid text not null, libname text not null, address text not null, city text not null, zip text not null, county text not null, phone text not null, crelatn text not null, clegbas text not null, cadmin text not null, cfscs text not null, geocode text not null, lsabound text not null, startdate text not null, enddate text not null, populsa integer not null, popuund integer not null, centlib integer not null, branlib integer not null, bkmob integer not null, totstaff numeric(8,2) not null, bkvol integer not null, ebook integer not null, audioph integer not null, audiodl integer not null, videoph integer not null, videodl integer not null, ecloot integer not null, subscrip integer not null, hrsopen integer not null, visits integer not null, reference integer not null, regbor integer not null, totcir integer not null, kidcircl integer not null, totpro integer not null, gpterms integer not null, pitusr integer not null, wifisess integer not null, obereg text not null, statstru text not null, statname text not null, stataddr text not null, longitude numeric(10,7) not null, latitude numeric(10,7) not null);  --startdate and enddate columns data type set to text because columns include nondate values
copy plsfy2018libraries
from '/home/mar/postgresql/pls_fy2018_libraries.csv'
with (format csv, header);
create index libname2018idx on plsfy2018libraries (libname);  --index created for faster results
create table plsfy2017libraries
(stabr text not null, fscskey text constraint fscskey2017pkey primary key, libid text not null, libname text not null, address text not null, city text not null, zip text not null, county text not null, phone text not null, crelatn text not null, clegbas text not null, cadmin text not null, cfscs text not null, geocode text not null, lsabound text not null, startdate text not null, enddate text not null, populsa integer not null, popuund integer not null, centlib integer not null, branlib integer not null, bkmob integer not null, totstaff numeric(8,2) not null, bkvol integer not null, ebook integer not null, audioph integer not null, audiodl integer not null, videoph integer not null, videodl integer not null, ecloot integer not null, subscrip integer not null, hrsopen integer not null, visits integer not null, reference integer not null, regbor integer not null, totcir integer not null, kidcircl integer not null, totpro integer not null, gpterms integer not null, pitusr integer not null, wifisess integer not null, obereg text not null, statstru text not null, statname text not null, stataddr text not null, longitude numeric(10,7) not null, latitude numeric(10,7) not null);  --startdate and enddate columns data type set to text because columns include nondate values
copy plsfy2017libraries
from '/home/mar/postgresql/pls_fy2017_libraries.csv'
with (format csv, header);
create index libname2017idx on plsfy2017libraries (libname);  --index created for faster results
create table plsfy2016libraries
(stabr text not null, fscskey text constraint fscskey2016pkey primary key, libid text not null, libname text not null, address text not null, city text not null, zip text not null, county text not null, phone text not null, crelatn text not null, clegbas text not null, cadmin text not null, cfscs text not null, geocode text not null, lsabound text not null, startdate text not null, enddate text not null, populsa integer not null, popuund integer not null, centlib integer not null, branlib integer not null, bkmob integer not null, totstaff numeric(8,2) not null, bkvol integer not null, ebook integer not null, audioph integer not null, audiodl integer not null, videoph integer not null, videodl integer not null, ecloot integer not null, subscrip integer not null, hrsopen integer not null, visits integer not null, reference integer not null, regbor integer not null, totcir integer not null, kidcircl integer not null, totpro integer not null, gpterms integer not null, pitusr integer not null, wifisess integer not null, obereg text not null, statstru text not null, statname text not null, stataddr text not null, longitude numeric(10,7) not null, latitude numeric(10,7) not null);  --startdate and enddate columns data type set to text because columns include nondate values
copy plsfy2016libraries
from '/home/mar/postgresql/pls_fy2016_libraries.csv'
with (format csv, header);
create index libname2016idx on plsfy2016libraries (libname);  --index created for faster results

select count(*)
from plsfy2018libraries;  --return 9261
select count(*)
from plsfy2017libraries;  --return 9245
select count(*)
from plsfy2016libraries;  --return 9252
select count(libname)
from plsfy2018libraries;  --return 9261
select count(distinct libname)
from plsfy2018libraries;  --return 8478  RM:  count(distinct columnname) is valid in Oracle SQL
select max(visits), min (visits)
from plsfy2018libraries;  --return 16686945; -3.  -1 indicates nonresponse to the question.  -3 indicates not applicable.
--Use Group By to eliminate duplicate results like Distinct
select stabr
from plsfy2018libraries
group by stabr
order by stabr;  --return the state abbreviations no duplicates ascending order
select city, stabr
from plsfy2018libraries
group by city, stabr
order by city, stabr;
select stabr, count(*)
from plsfy2018libraries
group by stabr
order by count(*) desc;
'''
"stabr"
"NY"	756
"IL"	623
"TX"	560
"IA"	544
"PA"	451
"MI"	398
...
'''
select stabr, stataddr, count(*)
from plsfy2018libraries
group by stabr, stataddr
order by stabr, stataddr;
'''
"stabr"	"stataddr"	"count"
"AK"	"00"	82
"AL"	"00"	220
"AL"	"07"	3
"AL"	"15"	1
"AR"	"00"	58
"AR"	"07"	1
"AR"	"15"	1
...
'''
select sum(visits) as "visits column must be positive number"
from plsfy2018libraries
where visits >=0;  --return 1292348697
--Library agencies must exist in all three tables use joins and positive number.
select sum(pls2018.visits) as "second join 2018 and 2016", sum(pls2017.visits), sum(pls2016.visits)
from plsfy2018libraries pls2018 join plsfy2017libraries pls2017
on pls2018.fscskey = pls2017.fscskey
join plsfy2016libraries pls2016
on pls2018.fscskey = pls2016.fscskey
where pls2018.visits>=0 and pls2017.visits>=0 and pls2016.visits>=0;
'''
"second join 2018 and 2016"	"sum"	"sum"
1278148838	1319325387	1355078384
'''
select sum(pls2018.visits) "second join 2017 and 2016", sum(pls2017.visits), sum(pls2016.visits)
from plsfy2018libraries pls2018 join plsfy2017libraries pls2017
on pls2018.fscskey = pls2017.fscskey
join plsfy2016libraries pls2016
on pls2017.fscskey = pls2016.fscskey
where pls2018.visits>=0 and pls2017.visits>=0 and pls2016.visits>=0;
'''
"second join 2017 and 2016"	"sum"	"sum"
1278148838	1319325387	1355078384
'''
select pls2018.stabr, sum(pls2018.visits) as "2018 visits", sum(pls2017.visits) as "2017 visits", round((sum(pls2018.visits::numeric)-sum(pls2017.visits))/sum(pls2017.visits)*100,1) as "percenteage change 2018 and 2017", sum(pls2016.visits) as "2016 visits"
from plsfy2018libraries pls2018 join plsfy2017libraries pls2017
on pls2018.fscskey = pls2017.fscskey
join plsfy2016libraries pls2016
on pls2018.fscskey = pls2016.fscskey
where pls2018.visits>=0 and pls2017.visits>=0 and pls2016.visits>=0
group by pls2018.stabr;
'''
"stabr"	"2018 visits"	"2017 visits"	"percenteage change 2018 and 2017"	"2016 visits"
"CA"	146656984	151056672	-2.9	155613529
"NH"	7045010	7028800	0.2	7236567
"OR"	19592295	20244499	-3.2	20391927
"TX"	66168387	70514138	-6.2	70975901
"ND"	2216377	2162189	2.5	2201730
"NV"	9334070	9684935	-3.6	9733359
"OH"	68176967	71895854	-5.2	74119719
...
'''
select pls2018.stabr, sum(pls2018.visits) as "2018 visits", sum(pls2017.visits) as "2017 visits", round((sum(pls2018.visits::numeric)-sum(pls2017.visits))/sum(pls2017.visits)*100,1) as "percenteage change 2018 and 2017 2018 visits greater than 50M", sum(pls2016.visits) as "2016 visits"
from plsfy2018libraries pls2018 join plsfy2017libraries pls2017
on pls2018.fscskey = pls2017.fscskey
join plsfy2016libraries pls2016
on pls2018.fscskey = pls2016.fscskey
where pls2018.visits>=0 and pls2017.visits>=0 and pls2016.visits>=0
group by pls2018.stabr
having sum(pls2018.visits)>5000000;
'''
"stabr"	"2018 visits"	"2017 visits"	"percenteage change 2018 and 2017 2018 visits greater than 50M"	"2016 visits"
"CA"	146656984	151056672	-2.9	155613529
"NH"	7045010	7028800	0.2	7236567
"OR"	19592295	20244499	-3.2	20391927
"TX"	66168387	70514138	-6.2	70975901
"NV"	9334070	9684935	-3.6	9733359
"OH"	68176967	71895854	-5.2	74119719
...
'''