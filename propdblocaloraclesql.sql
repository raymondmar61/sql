--Oracel SQL oracledatabase12csql.sql Oracle Database 12c SQL by Jason Price
--Tables:  availablelease, availablesale, building, comparables, streetdirection, subtypes.  Comps 2004 and later.
--Ctrl+Shift+V opens Paste window or Edit-->Extended Paste.  It's like Excel Clipboard.
--Ctrl+Up arrow or Ctrl+Down arrow replaces contents of SQL with lines of code from SQL History.  Step up or step down throughout SQL History.

--template building type
select b.buildingid, s.subtypename
from subtypes s join building b
on s.typechar = b.type
and s.subtypenumber = b.subtype;
--template building type comparables
select c.comparableid, s.subtypename
from subtypes s join building b
on s.typechar = b.type
and s.subtypenumber = b.subtype
join comparables c
on c.buildingid = b.buildingid;

select *
from tab;  --show table names?
select *
from tabs;  --show table names and more information
describe availablelease;  --returns column names, null y or n, data type
desc availablesale;  --desc is short for describe
describe building;
describe comparables;
describe streetdirection;
describe subtypes;

insert into availablelease
values (40247,222,200,4.50,'FS',8000,8000,2000,'1/1/2019','N');
insert into availablelease (buildingid, availableid, suite, leaserate, leasetype, availablesf, contiguoussf, divisiblesf, dateavailable, sublease)
values (40247,223,300,4.50,'FS',8000,8000,2000,'12/1/2018','N');
update availablelease
set leaserate = 5.00
where availableid = 222;
delete from availablelease
where availableid = 223;

select rownum buildingid, buildingid as "no alias rownum", askingprice, askingprice*1.10 as "10% increase"
from availablesale
where askingprice is not null;  --rownumber returns the row number
select buildingid, dateavailable, dateavailable+7 as "one week late"
from availablelease
where dateavailable is not null;
select buildingid, nvl(dateavailable,'1/1/1999') as "null date is 01/01/1999"
from availablelease;  --null value nvl(columname, value returned if columnname is null)
select buildingid, streetnumber || ' ' || streetname || ' ' || city || ', ' || zipcode as "address"
from building
where streetnumber is not null and streetname is not null; --concatenate
select distinct streetname
from building
where city in('San Jose','Santa Clara')
order by streetname asc;
select distinct owner
from building
where owner like '_e%'
order by owner desc;
select leaserate, leasetype, availablesf
from availablelease
where leaserate between 2 and 3;  --between is inclusive
select comparableid, comparabletype, tenantbuyer, landlordseller
from comparables
where comparabletype = 'L' and landlordseller = 'DivcoWest';
select comparableid, comparabletype, tenantbuyer, landlordseller
from comparables
where comparabletype = 'S' or landlordseller = 'DivcoWest';

select availableid, streetnumber, streetname, city, suite, availablesf, leaserate, leasetype
from building, availablelease
where building.buildingid = availablelease.buildingid
and availablelease.leaserate is not null
and availablelease.leasetype in ('FS','NNN')
and building.city in ('Palo Alto','Menlo Park');  --returns 220 rows
--use table alias
select a.availableid, b.streetnumber, b.streetdirection, b.streetname, b.city, a.suite, a.availablesf, a.leaserate, a.leasetype
from building b, availablelease a
where b.buildingid = a.buildingid
and a.leaserate is not null
and a.leasetype in ('FS','NNN')
and b.city in ('Palo Alto','Menlo Park')
order by availableid;  --returns 220 rows
--add street direction.  Need third table streetdirection.
select a.availableid, b.streetnumber, s.streetdirection, b.streetname, b.city, a.suite, a.availablesf, a.leaserate, a.leasetype
from building b, availablelease a, streetdirection s
where b.buildingid = a.buildingid and b.streetdirection = s.streetdirectionnumber(+)
and a.leaserate is not null
and a.leasetype in ('FS','NNN')
and b.city in ('Palo Alto','Menlo Park')
order by a.availableid; --returns 220 rows.  building table street direction returns numbers.
--The Oracle proprietary outer join operator is a plus character in parentheses (+).  You place the outer join operator (+) on the opposite side of the equality operator = from the column that contains the null value.  RM:  The query is like a left outer join query everything in building b table and whatever matches streetdirection s table.  Oracle: In a left outer join, the outer join operator (+) is actually on the right of the equality operator =.

select a.availableid, b.streetnumber, b.streetdirection, b.streetname, b.city, a.suite, a.availablesf, a.leaserate, a.leasetype
from building b inner join availablelease a
on b.buildingid = a.buildingid
and a.leaserate is not null
and a.leasetype in ('FS','NNN')
and b.city in ('Palo Alto','Menlo Park')
order by availableid;  --returns 220 rows
--add street direction.  Need third table streetdirection.
select a.availableid, b.streetnumber, s.streetdirection, b.streetname, b.city, a.suite, a.availablesf, a.leaserate, a.leasetype
from building b inner join availablelease a
on (b.buildingid = a.buildingid)
and a.leaserate is not null
and a.leasetype in ('FS','NNN')
and b.city in ('Palo Alto','Menlo Park')
left outer join streetdirection s
on (b.streetdirection = s.streetdirectionnumber)
and a.leaserate is not null
and a.leasetype in ('FS','NNN')
and b.city in ('Palo Alto','Menlo Park')
order by availableid;  --returns 220 rows.  nested joins or multiple joins
select b.city, s.subtypename, to_char(round(avg(c.salepricesf),2),999.99)
from building b inner join comparables c 
on (b.buildingid = c.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.leasesoldsf between 10000 and 30000 and salepricesf > 0
group by b.city, s.subtypename
order by 1 asc, 2 asc, 3 desc;

select concat (startrate, leasetype), concat (effectiverate, leasetype)
from comparables
where startrate is not null and effectiverate is not null;  --The concatenation operator does not permit spaces.  Two fields only.  Returns as a string
select tenantbuyer
from comparables
where tenantbuyer like '%west%';  --returns west only 7 rows.  No West or no WEST.
select tenantbuyer
from comparables
where tenantbuyer like '%west%' or tenantbuyer like '%West%';  --returns west and West 66 records.  No WEST
select tenantbuyer
from comparables
where lower(tenantbuyer) like '%west%';  --returns all wests 66 rows
select tenantbuyer, instr(tenantbuyer,'west')  --instring returns starting position
from comparables
where tenantbuyer like '%west%';  --returns west only 7 rows.  No West or no WEST.
select tenantbuyer, instr(lower(tenantbuyer),'west')  --instring returns starting position
from comparables
where lower(tenantbuyer) like '%west%';  --returns all wests 66 rows
select tenantbuyer, instr(tenantbuyer,'e',1,2) as "start at first e find second e"
from comparables
where leasesoldsf >= 100000 and tenantbuyer is not null and comparabletype = 'L';
select tenantbuyer, instr(tenantbuyer,'e',-1,2) as "start at last e find second e"
from comparables
where leasesoldsf >= 100000 and tenantbuyer is not null and comparabletype = 'L';
select tenantbuyer, instr(lower(tenantbuyer),'e',-1,2) as "start at last e or E find second e or E"
from comparables
where leasesoldsf >= 100000 and tenantbuyer is not null and comparabletype = 'L';
select tenantbuyer, length(tenantbuyer) as "number of characters"
from comparables
where leasesoldsf >= 100000 and tenantbuyer is not null and comparabletype = 'L';
--LTRIM(x [, trim_string]) and RTRIM(x [, trim_string]) removes characters from the left or right of x. You can provide an optional trim_string, which specifies the characters to remove. If no trim_string is provided, spaces are removed by default.
SELECT LTRIM(' Hello Kathy Lindsey!')
FROM dual;  --returns Hello Kathy Lindsey!
SELECT RTRIM('Hi Doreen Oakley!abcabc', 'abc')
FROM dual;  --returns Hi Doreen Oakley!
--TRIM([trim_char FROM] x) removes characters from the left and right of x. You can provide an optional trim_char, which specifies the characters to remove. If no trim_ char is provided, spaces are removed by default.
SELECT TRIM('0' FROM '000Hey Steve Button!00000')
FROM dual;  --returns Hey Steve Button!
select buildingid, nvl(projectname,'NO NAME') as "projectname null NO NAME", city, totalsf
from building
where totalsf >=100000;
select buildingid, nvl2(projectname,'YES NAME','NO NAME') as "projectname YES NAME NO NAME", city, totalsf
from building
where totalsf >=100000;  --nvl2 if projectname is not null YES NAME. if projectname is null NO NAME.
select buildingid, city, replace(city,'Mt. View','Mtn. View') as "replace Mt. View w/ Mtn. View"
from building
where totalsf >=100000 and city in ('Menlo Park','Mt. View');
select owner, substr(owner,1,10) as "first 10 characters"
from building
where owner is not null and city in ('San Jose');
select owner, substr(owner,5,10) as "10 characters at 5th position"
from building
where owner is not null and city in ('San Jose');
select owner, substr(owner,instr(owner,' ')+1) as "all characters after 1st space"
from building
where owner is not null and city in ('San Jose');
select owner, substr(owner,instr(owner,' ')+1,10) as "10 characters after 1st space"
from building
where owner is not null and city in ('San Jose');
select owner, substr(owner,instr(owner,' ')+1,instr(owner,' ',1,2)-instr(owner,' ',1,1)) as "2nd word"
from building
where owner is not null and city in ('San Jose');
select owner, substr(owner,-5,3) as "start 5th from end, 3 forward"
from building
where owner is not null and city in ('San Jose');
select comparableid, startrate, round(startrate) as "round", round(startrate,1) as "round 1 decimal", ceil(startrate) as "go up whole", floor(startrate) as "go down whole"
from comparables
where comparabletype in ('L') and startrate > 0;
select comparableid, salepricesf, trunc(salepricesf) as "whole number only", trunc(salepricesf,1) as "one decimal only no round"
from comparables
where salepricesf > 0;
select abs(10), abs(-10), greatest(3,4,1) as "4", least(3,4,1) as "1", power(2,3) as "8"
from dual;
select to_char(12345.67) as "12345.67", to_char(12345.67,'99,999.99') as "12,345.67", to_char(8712345.675, '99,999,999.99') as "8,712,345.68"
from dual;  --to_char(x [, format]) converts x to a string convert number to string
select to_number('970.13') as "970.13", to_number('970.13')+25.5 as "995.63", to_number('-$12,345.67', '$99,999.99') as "-12345.67 no comma", to_number('12,345.67','99999.99') as "12345.67"
from dual;  --to_number(x [, format]) converts x to a number convert string to number

--Regular expressions and their associated Oracle database functions allow you to search for a pattern of characters in a string. For example, let’s say you want to obtain the years 1965 through 1968 from the following list of years.  Regular expression is ^196[5-8]$.  ^ matches the beginning position of a string.  [5-8] matches characters between 5 and 8.  $ matches the end position of a string.
--RM:  There are many regular expressions formats starting on page 119.
SELECT customer_id, first_name, last_name, dob
FROM customers
WHERE REGEXP_LIKE(TO_CHAR(dob, 'YYYY'), '^196[5-8]$');  --retrieves customers whose date of birth is between 1965 and 1968
SELECT customer_id, first_name, last_name, dob
FROM customers
WHERE REGEXP_LIKE(first_name, '^j', 'i');  --retrieves customers whose first name starts with J or j.  ^j and the match option is i (i indicates case-insensitive matching)

select avg(salepricesf), round(avg(salepricesf),2), count(salepricesf), max(salepricesf), min(salepricesf), sum(saleprice)
from comparables
where salepricesf > 0;  --nulls are ignored, no need for salepricesf > 0
select b.city, to_char(round(avg(c.salepricesf),2),999.99)
from comparables c inner join building b
on c.buildingid = b.buildingid
where b.type = 'O' and c.leasesoldsf between 10000 and 30000
group by city
order by 2 desc;   --calculate average sale price per sf grouped by city office buildings between 10,000 and 30,000 SF inclusive
select b.city, s.subtypename, to_char(round(avg(c.salepricesf),2),999.99)
from building b inner join comparables c 
on (b.buildingid = c.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.leasesoldsf between 10000 and 30000 and salepricesf > 0
group by b.city, s.subtypename
order by 1 asc, 2 asc, 3 desc;  --calculate average sale price per sf grouped by city and by buildings between 10,000 and 30,000 SF inclusive
select b.city, s.subtypename, to_char(round(avg(c.salepricesf),2),999.99)
from building b inner join comparables c 
on (b.buildingid = c.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.leasesoldsf between 10000 and 30000 and salepricesf>0
group by b.city, s.subtypename
having avg(c.salepricesf) between 150 and 250
order by 1 asc, 2 asc, 3 desc;  --You can use the WHERE, GROUP BY, and HAVING clauses together in the same query. WHERE clause filters the rows, GROUP BY clause groups the remaining rows into blocks, and HAVING clause filters the row groups.  HAVING clause filters groups of rows placed after the GROUP BY clause.

select comparableid, datesigned, to_char(datesigned, 'Month DD, YYYY') as "June      14, 2005"
from comparables
where comparabletype in ('L');
select comparableid, datesigned, add_months(datesigned,4) as "add 4 months", add_months(datesigned,-3) as "subtract 3 months"
from comparables
where comparabletype in ('L');
select comparableid, datesigned, last_day(datesigned) as "last day in month datesigned", last_day(datesigned)+1 as "first day next datesigned"
from comparables
where comparabletype in ('L');
select comparableid, datesigned, dateoccupied, months_between(dateoccupied, datesigned) as "months between occupied signed", round(months_between(dateoccupied, datesigned),2) as "round up months 2 decimal"
from comparables
where comparabletype in ('L');
select comparableid, datesigned, trunc(datesigned,'YYYY') as "first day of year datesigned", to_char(datesigned,'YYYY') as "year datesigned"
from comparables
where comparabletype in ('L');

select projectname
from building
where buildingid = 40247; --return The Triangle Building
select *
from comparables
where comparabletype in ('L')
and buildingid =
  (select buildingid
  from building
  where projectname = 'The Triangle Building');  --return comparables, return 40247
select round(avg(startrate),2)
from comparables
where comparabletype in ('L')
and buildingid = 40247;  --return 1.99
select *
from comparables
where comparabletype in ('L')
and leasesoldsf between 1000 and 3000
and startrate >=
  (select round(avg(startrate),2)
  from comparables
  where comparabletype in ('L')
  and buildingid = 40247);  --return comparables, return 1.99
--start line 488 chapter 6 subqueries 09/24/18
select round(avg(startrate),2)
from comparables
where comparabletype = 'L'
and startrate > 0;  --returns 1.32
select b.city, round(avg(c.startrate),2) as "Average Start Rate"
from comparables c left join building b
on c.buildingid = b.buildingid
where c.comparabletype = 'L'
and c.startrate > 0
group by b.city
order by b.city;  --returns Average Start Rate grouped by b.city
select b.city, round(avg(c.startrate),2) as "Average Start Rate"
from comparables c left join building b
on c.buildingid = b.buildingid
where c.comparabletype = 'L'
and c.startrate > 0
group by b.city
having round(avg(c.startrate),2) >
  (select round(avg(startrate),2)
   from comparables
   where comparabletype = 'L'
  and startrate > 0)
order by b.city;  --returns Average Start Rate grouped by b.city greater than 1.32
select round(avg(startrate),2)
from comparables c inner join building b
on (c.buildingid = b.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.comparabletype = 'L'
and c.startrate > 0
and s.subtypename = 'Office';  --return 1.85
select b.city, s.subtypename, round(avg(c.startrate),2) as "Average Start Rate"
from comparables c left join building b
on (c.buildingid = b.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.comparabletype = 'L'
and c.startrate > 0
and s.subtypename = 'Office'
group by b.city, s.subtypename
having round(avg(c.startrate),2) >
  (select round(avg(startrate),2)
   from comparables
   where comparabletype = 'L'
  and startrate > 0
  and s.subtypename = 'Office')
order by b.city;  --return Office comparables grouped by City
select b.city, s.subtypename, round(avg(c.startrate),2) as "Average Start Rate"
from comparables c left join building b
on (c.buildingid = b.buildingid)
inner join subtypes s
on (b.subtype = s.subtypenumber)
where c.comparabletype = 'L'
and c.startrate > 0
and s.subtypename = 'Office'
group by b.city, s.subtypename
having round(avg(c.startrate),2) >
  (select round(avg(startrate),2)
  from comparables c left join building b
  on (c.buildingid = b.buildingid)
  inner join subtypes s
  on (b.subtype = s.subtypenumber)
  where c.comparabletype = 'L'
  and c.startrate > 0
  and s.subtypename = 'Office')
order by b.city;  --return Office comparables grouped by City greater than 1.85
--start line 522 chapter 6 subqueries 09/26/18
--A multiple-row subquery returns one or more rows to an outer SQL statement. To process the multiple rows returned by a subquery, an outer query can use the IN, ANY, or ALL operators.
select tenantbuyer
from comparables
where comparabletype = 'L'
and tenantbuyer like 'Apple%';  --return Apple
select tenantbuyer, comparableid
from comparables
where comparabletype = 'L'
and tenantbuyer like 'Apple%';  --return Apple
select tenantbuyer, comparableid
from comparables
where tenantbuyer in
  (select tenantbuyer
  from comparables
  where comparabletype = 'L'
  and tenantbuyer like 'Apple%');  --return Apple
select buildingid
from building
where owner like ('Equity Office%');  --buildingids owned by Equity Office
select buildingid, tenantbuyer
from comparables
where comparabletype = 'S'
and buildingid not in
  (select buildingid
  from building
  where owner like ('Equity Office%'));  --return sale comparables buildingids not owned by Equity Office in building table
select startrate
from comparables
where startrate >= 5;
select availableid, leaserate
from availablelease
where leaserate >= 5;
select availableid, leaserate
from availablelease
where leaserate >= any
  (select startrate
  from comparables
  where startrate >= 5);  --The ANY operator compares one value with any value in a list. You must place an =, <>, <, >, <=, or >= operator before ANY in your query.
  select startrate
from comparables
where startrate >= 5;
select availableid, leaserate
from availablelease
where leaserate >= 5;
select availableid, leaserate
from availablelease
where leaserate >= all
  (select startrate
  from comparables
  where startrate >= 5);  --The ALL operator compares one value with all values in a list. You must place an =, <>, <, >, <=, or >= operator before ALL in your query.  RM:  returned no rows because none of the leaserate in availablelease table is greater than or equal to all the startrate in comparables table.
--16045720 5.75 original 40.25 temporary
update availablelease
set leaserate = 40.25
where availableid = 16045720;
select availableid, leaserate
from availablelease
where leaserate >= all
  (select startrate
  from comparables
  where startrate >= 5);  --The ALL operator compares one value with all values in a list. You must place an =, <>, <, >, <=, or >= operator before ALL in your query.  RM:  returned one row because availableid 16045720 lease rate is 40.25.  40.25 is greater than or equal to all the startrate in comparables table.
--16045720 40.25 temporary back to 5.75 original
update availablelease
set leaserate = 5.75
where availableid = 16045720;
--A subquery can return multiple columns.
select s.subtypename as "Bldg Type", min(c.startrate) as "Low Start Rate Bldg Type >.5"
from subtypes s join building b
on s.typechar = b.type
and s.subtypenumber = b.subtype
join comparables c
on c.buildingid = b.buildingid
where comparabletype = 'L'
and c.startrate > .50
group by s.subtypename;  --lowest starting rate above $.50 grouped by building
select s.subtypename as "Bldg Type", c.tenantbuyer as "Tenant", c.startrate as "Start Rate"
from subtypes s join building b
on s.typechar = b.type
and s.subtypenumber = b.subtype
join comparables c
on c.buildingid = b.buildingid
where comparabletype = 'L'
and c.startrate > .50;  --tenant starting rate and its building type
select s.subtypename as "Bldg Type", c.tenantbuyer as "Tenant", c.startrate as "Start Rate"
from subtypes s join building b
on s.typechar = b.type
and s.subtypenumber = b.subtype
join comparables c
on c.buildingid = b.buildingid
where (s.subtypename, c.startrate) in
  (select s.subtypename as "Bldg Type", min(c.startrate) as "Low Start Rate Bldg Type >.5"
  from subtypes s join building b
  on s.typechar = b.type
  and s.subtypenumber = b.subtype
  join comparables c
  on c.buildingid = b.buildingid
  where comparabletype = 'L'
  and c.startrate > .50
  group by s.subtypename)
order by s.subtypename;  --lowest starting rate above $.50 grouped by building with the tenant.  Ties are included.
--start line 576 chapter 6 subqueries 10/03/18
--start line 703 chapter 7 Advanced Queries 10/04/18
select buildingid
from availablelease;
select buildingid
from availablesale;
select buildingid
from availablelease
union all
select buildingid
from availablesale;  --return 4,961 records.  UNION ALL Returns all the rows retrieved by the queries, including duplicate rows
select buildingid
from availablelease
union
select buildingid
from availablesale;  --return 3,084 records.  UNION Returns all non-duplicate rows retrieved by the queries.  RM:  availablesale doesn't have availableid field
select buildingid
from availablesale;  --return 686 records.  INTERSECT Returns rows that are retrieved by both queries
select buildingid
from availablelease
minus
select buildingid
from availablesale;  --return 1,979 records.  MINUS Returns the remaining rows when the rows retrieved by the second query are subtracted from the rows retrieved by the first query
select buildingid
from availablesale
minus
select buildingid
from availablelease;  --return 419 records.  MINUS Returns the remaining rows when the rows retrieved by the second query are subtracted from the rows retrieved by the first query

--The CASE expression performs if then else or if else or if-then-else logic.  Simple CASE expressions, which use expressions to determine the returned value.  Searched CASE expressions, which use conditions to determine the returned value.
select buildingid
from availablelease
intersectselect buildingid, case concat(type, subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type"
from building
where city = 'San Jose';
--start line 757 chapter 7 Advanced Queries 10/08/18
select a.availableid, a.leaserate, case when a.leaserate < 1 then 'Cheap' when a.leaserate < 2 then 'Moderate' when a.leaserate < 3 then 'Expensive' else 'Out Of Range' end as "Lease Rating"
from availablelease a left outer join building b
on a.buildingid = b.buildingid
where b.city = 'Palo Alto'
and a.leaserate > 0
and b.type = 'O'
and b.subtype in (4,5);
select b.city, case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", round(avg(a.leaserate),2)
from availablelease a left outer join building b
on a.buildingid = b.buildingid
group by b.city, concat(b.type, b.subtype)
order by city, concat(b.type, b.subtype);
select b.city, case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", round(avg(a.leaserate),2) as "Avg Lease Rate"
from availablelease a left outer join building b
on a.buildingid = b.buildingid
group by rollup(b.city, concat(b.type, b.subtype))
order by city, concat(b.type, b.subtype);  --ROLLUP returns a row with the avg lease rate for each city and building type and the avg for the each entire city and a grand average for all cities at the end of the result set.  In this case, "Other" denoted at the end of each city and the last row is the averages.
select b.city, case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", sum(a.availablesf) as "Avail SF"
from availablelease a left outer join building b
on a.buildingid = b.buildingid
group by rollup(b.city, concat(b.type, b.subtype))
order by city, concat(b.type, b.subtype);  --ROLLUP returns a row with the sum available sf for each city and building type and the sum for the each entire city and a grand sum for all cities at the end of the result set.  In this case, "Other" denoted at the end of each city and the last row is the grand sum.
select b.city, case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", sum(a.availablesf) as "Avail SF"
from availablelease a left outer join building b
on a.buildingid = b.buildingid
group by cube(b.city, concat(b.type, b.subtype))
order by city, concat(b.type, b.subtype);  --The CUBE clause extends GROUP BY to return rows containing a subtotal for all combinations of columns, plus a row containing the grand total.  RM: order by makes query easier to read.  The additional subtotals for all combinations appear at the end of the results.  The grand total is the last row.
--The GROUPING() function accepts a column and returns 0 or 1. GROUPING() returns 1 when the column value is null and returns 0 when the column value is non-null. GROUPING() is used only in queries that use ROLLUP or CUBE. GROUPING() is useful when you want to display a value when a null would otherwise be returned.
select grouping(b.city), b.city, case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", sum(c.leasesoldsf) as "SF Sold"
from comparables c left outer join building b
on c.buildingid = b.buildingid
where c.comparabletype  = 'S'
group by rollup(b.city, concat(b.type, b.subtype));  --GROUPING() returns 0 for the rows that have non-null division_id values and returns 1 for the last row that has a null division_id.
select case grouping(b.city) when 1 then 'Total SF Sold row label' else b.city end as "City column name", case concat(b.type, b.subtype) when 'I17' then 'R&'||'D' when 'O5' then 'OFC' when 'L30' then 'LAND' when 'O4' then 'OFC/R&'||'D' when 'I18' then 'R&'||'D/'||'OFC' when 'I31' then 'WHS' when 'I19' then 'IND' when 'R20' then 'RETAIL' else 'Other' end as "Bldg Type", sum(c.leasesoldsf) as "SF Sold"
from comparables c left outer join building b
on c.buildingid = b.buildingid
where c.comparabletype  = 'S'
group by rollup(b.city, concat(b.type, b.subtype));  --Label the total SF sold all cities row "Total SF Sold"
select case grouping(b.city) when 1 then 'Total SF Sold row label' else b.city end as "City column name", case grouping(concat(b.type, b.subtype)) when 1 then 'Subtotal SF Sold by city row label' else concat(b.type, b.subtype) end as "Bldg Type column name", sum(c.leasesoldsf) as "SF Sold"
from comparables c left outer join building b
on c.buildingid = b.buildingid
where c.comparabletype  = 'S'
group by rollup(b.city, concat(b.type, b.subtype));  --Subtotal SF sold by city and Total SF sold all cities.  RM:  I can't use a case in the else clause to make it easier to read the bulding types; e.g. OFC, IND, R&D, WSE.
select case grouping(b.city) when 1 then 'Total SF Sold row label' else b.city end as "City column name", case grouping(s.subtypename) when 1 then 'Subtotal SF Sold by city row label' else s.subtypename end as "Bldg Type column name", sum(c.leasesoldsf) as "SF Sold"
from building b right outer join comparables c
on c.buildingid = b.buildingid
left outer join subtypes s
on b.type = s.typechar and b.subtype = s.subtypenumber
where c.comparabletype  = 'S'
group by rollup(b.city, s.subtypename);  --Subtotal SF sold by city and Total SF sold all cities.  RM:  I can't use a case in the else clause to make it easier to read the bulding types; e.g. OFC, IND, R&D, WSE.  Solution is link building table and subtypes table.
select case grouping(b.city) when 1 then 'Total SF Sold row label' else b.city end as "City column name", 
case grouping(s.subtypename) when 1 then 'Subtotal SF Sold by city row label' else s.subtypename end as "Bldg Type column name",
sum(c.leasesoldsf) as "SF Sold"
from building b left outer join comparables c
on c.buildingid = b.buildingid
right outer join subtypes s
on b.type = s.typechar and b.subtype = s.subtypenumber
where c.comparabletype  = 'S'
group by cube(b.city, s.subtypename)
order by city;  --Subtotal SF sold by city and Total SF sold all cities.  Also, using CUBE subtotal SF by building type.
select case grouping(b.city) when 1 then 'Total SF Sold row label' else b.city end as "City column name", 
case grouping(s.subtypename) when 1 then 'Subtotal SF Sold by city row label' else s.subtypename end as "Bldg Type column name",
sum(c.leasesoldsf) as "SF Sold"
from building b left outer join comparables c
on c.buildingid = b.buildingid
right outer join subtypes s
on b.type = s.typechar and b.subtype = s.subtypenumber
where c.comparabletype  = 'S'
and s.subtypename in ('Office', 'R&'||'D','Industrial','Warehouse','R&'||'D/'||'Office','Office/'||'R&'||'D')
group by cube(b.city, s.subtypename)
order by b.city;  --Subtotal SF sold by city and Total SF sold all cities four main building types.  Also, using CUBE subtotal SF by building type.
--start line 851 chapter 7 Advanced Queries 10/10/18