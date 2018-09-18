--Oracel SQL oracledatabase12csql.sql Oracle Database 12c SQL by Jason Price
--Tables:  availablelease, availablesale, building, comparables, streetdirection, subtypes.  Comps 2004 and later.
--Ctrl+Shift+V opens Paste window or Edit-->Extended Paste.  It's like Excel Clipboard.

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