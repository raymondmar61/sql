--Practical SQL By Anthony DeBarros Second Edition Chapter 10 Inspecting And Modifying Data

create table meatpoultryeggestablishments
(establishmentnumber text constraint estnumberkey primary key, company text, street text, city text, st text, zip text, phone text, grantdate date, activities text, dbas text);
copy meatpoultryeggestablishments
from '/home/mar/postgresql/MPI_Directory_by_Establishment_Name.csv'
with (format csv, header);
create index companyidx on meatpoultryeggestablishments (company);
select count(*)
from meatpoultryeggestablishments;  --return 6287
select company, street, city, st, count(*) as "Count addresses check distinct addresses duplicates"
from meatpoultryeggestablishments
group by company, street, city, st
having count(*) > 1
order by company, street, city, st;
'''
"company"	"street"	"city"	"st"	"Count addresses check distinct addresses duplicates"
"Acre Station Meat Farm"	"17076 Hwy 32 N"	"Pinetown"	"NC"	2
"Beltex Corporation"	"3801 North Grove Street"	"Fort Worth"	"TX"	2
"Cloverleaf Cold Storage"	"111 Imperial Drive"	"Sanford"	"NC"	2
"Crete Core Ingredients, LLC"	"2220 County Road I"	"Crete"	"NE"	2
"Crider, Inc."	"1 Plant Avenue"	"Stillmore"	"GA"	3
"Dimension Marketing & Sales, Inc."	"386 West 9400 South"	"Sandy"	"UT"	2
"Foster Poultry Farms, A California Corporation"	"6648 Highway 15 North"	"Farmerville"	"LA"	2
...
'''
select st, count(*) as "Check missing state codes null value bottom row"
from meatpoultryeggestablishments
group by st
order by st;
'''
"st"	"Check missing state codes"
"AK"	17
"AL"	93
"AR"	87
"AS"	1
"AZ"	37
"CA"	666
"CO"	121
"CT"	55
...
"WI"	184
"WV"	23
"WY"	1
	3
'''
select establishmentnumber, company, city, st, zip as "find company with null state"
from meatpoultryeggestablishments
where st is null;
'''
"establishmentnumber"	"company"	"city"	"st"	"find company with null state"
"V18677A"	"Atlas Inspection, Inc."	"Blaine"		"55449"
"M45319+P45319"	"Hall-Namie Packing Company, Inc"			"36671"
"M263A+P263A+V263A"	"Jones Dairy Farm"			"53538"
'''
select company, count(*) as "Count companies search duplicate company entires"
from meatpoultryeggestablishments
group by company
order by company asc;
'''
...
"company"	"Count companies search duplicate company entires"
"Armour - Eckrich Meats, LLC"	1
"Armour-Eckrich Meats LLC"	3
"Armour-Eckrich Meats, LLC"	2
"Arnold''s & Eddies Foods Inc."	1
...
'''
select length(zip), count(*) as "Count zip code incorect data entry"
from meatpoultryeggestablishments
group by length(zip)
order by length(zip) asc;
'''
"length"	"Count zip code incorect data entry"
3	86
4	496
5	5705
'''
select st, zip, length(zip) as "Find zip code zip code length is 3"
from meatpoultryeggestablishments
where length(zip) = 3;
'''
"st"	"zip"	"Find zip code zip code length is 3"
"PR"	"680"	3
"PR"	"956"	3
"PR"	"968"	3
"PR"	"646"	3
"PR"	"962"	3
"PR"	"907"	3
...
'''
create table meatpoultryeggestablishmentsbackup as
select *
from meatpoultryeggestablishments;
select establishmentnumber, company, city, st, zip as "find company with null state"
from meatpoultryeggestablishments
where st is null;
'''
"establishmentnumber"	"company"	"city"	"st"	"find company with null state"
"V18677A"	"Atlas Inspection, Inc."	"Blaine"		"55449"
"M45319+P45319"	"Hall-Namie Packing Company, Inc"			"36671"
"M263A+P263A+V263A"	"Jones Dairy Farm"			"53538"
'''
update meatpoultryeggestablishments
set st = 'MN'
where establishmentnumber = 'V18677A';
update meatpoultryeggestablishments
set st = 'AL'
where establishmentnumber = 'M45319+P45319';
update meatpoultryeggestablishments
set st = 'WI'
where establishmentnumber = 'M263A+P263A+V263A'
returning establishmentnumber, company, city, st, zip;  --View the update while updating.  Preview update and actual update.
'''
"establishmentnumber"	"company"	"city"	"st"	"zip"
"M263A+P263A+V263A"	"Jones Dairy Farm"		"WI"	"53538"
'''
update meatpoultryeggestablishments
set company = 'Armour-Eckrich Meats'
where company like 'Armour%'
returning establishmentnumber, company;
'''
"establishmentnumber"	"company"
"M222+P5535+V222"	"Armour-Eckrich Meats"
"M1168+P19415"	"Armour-Eckrich Meats"
"M19+P19"	"Armour-Eckrich Meats"
"M3M+P8908"	"Armour-Eckrich Meats"
"M3JC+P3JC"	"Armour-Eckrich Meats"
"M3+P5636+V3"	"Armour-Eckrich Meats"
"M6863+P6863"	"Armour-Eckrich Meats"
'''
update meatpoultryeggestablishments
set zip = '00' || zip
where st in ('PR','VI') and length(zip) = 3
returning establishmentnumber, st, zip;  --update column append data concatenate data
'''
"establishmentnumber"	"st"	"zip"
"M6714+P6714"	"PR"	"00680"
"M44941+P44941"	"PR"	"00956"
"M40232+P40232"	"PR"	"00968"
"I630"	"PR"	"00646"
"I319"	"PR"	"00962"
"M896+P896"	"PR"	"00907"
"M32038+P32038"	"PR"	"00976"
"M44065"	"PR"	"00718"
...
'''
update meatpoultryeggestablishments
set zip = '0' || zip
where st in ('CT','MA','ME','NH','NJ','RI','VT') and length(zip) = 4
returning establishmentnumber, st, zip;  --update column append data concatenate data
'''
"establishmentnumber"	"st"	"zip"
"M45790"	"VT"	"05065"
"M45743+P45743"	"VT"	"05363"
"M2136+P2136"	"NJ"	"07202"
"M40009+P40009"	"NJ"	"07504"
"M46867+P46867"	"NJ"	"07739"
"M17074+P17074"	"NJ"	"07438"
...
'''
--Update values across tables.  Upload table data from .csv file.
create table stateregions
(st text constraint stkey primary key, region text not null);
copy stateregions
from '/home/mar/postgresql/state_regions.csv'
with (format csv, header);
select *
from stateregions;
'''
"st"	"region"
"AK"	"Pacific"
"AL"	"East South Central"
"AR"	"West South Central"
"AS"	"Outlying Area"
"AZ"	"Mountain"
"CA"	"Pacific"
"CO"	"Mountain"
"CT"	"New England"
"DC"	"South Atlantic"
"DE"	"South Atlantic"
...
'''
alter table meatpoultryeggestablishments
add column inspectiondeadline timestamp with time zone;
select establishmentnumber, st, inspectiondeadline
from meatpoultryeggestablishments;
'''
"establishmentnumber"	"st"	"inspectiondeadline"
"M46712+P46712"	"NY"	
"M13561+P13561"	"TX"	
"M46724+P46724"	"PA"	
"M7067+P7067"	"TX"	
"M48225"	"TX"	
"M17530+P17530"	"PA"	
"M19035+P19035"	"IA"	
"M45377"	"OH"	
"M22017+P22017+V22017"	"WA"	
"M19789+P19789"	"TX"	
"M634"	"MI"	
...
'''
update meatpoultryeggestablishments establishmentsalias
set inspectiondeadline = '2022-12-01 00:00 EST'
where exists (
    select stateregions.region
    from stateregions
    where establishmentsalias.st = stateregions.st
    and stateregions.region = 'New England');
select establishmentnumber, st, inspectiondeadline
from meatpoultryeggestablishments
where inspectiondeadline is not null;
'''
"establishmentnumber"	"st"	"inspectiondeadline"
"M45790"	"VT"	"2022-11-30 21:00:00-08"
"M8804+P8804"	"MA"	"2022-11-30 21:00:00-08"
"M4075+P4075"	"MA"	"2022-11-30 21:00:00-08"
"V40027"	"RI"	"2022-11-30 21:00:00-08"
"P9378+V9378"	"RI"	"2022-11-30 21:00:00-08"
"M31787+P31787"	"ME"	"2022-11-30 21:00:00-08"
"M664"	"RI"	"2022-11-30 21:00:00-08"
"M686"	"RI"	"2022-11-30 21:00:00-08"
"M45564"	"ME"	"2022-11-30 21:00:00-08"
"M45564A"	"ME"	"2022-11-30 21:00:00-08"
"M6363"	"MA"	"2022-11-30 21:00:00-08"
...
'''
alter table meatpoultryeggestablishments
drop column inspectiondeadline;
'''
Safeguards delete data and safeguard update tables.  Check changes and cancel changes.  Enclose the SQL statement within a transaction.  The transaction includes keywords to commit changes if successful or roll back changes if unsuccessful.  The keywords are start transaction, commit, and rollback.  Start transaction signals the start of the transaction block.  PostgreSQL can use the keyword begin .  Commit signals the end of the block and saves all changes.  Rollback signals the end of the block and reverts all changes.
'''
select establishmentnumber, company as "A comma in the AGRO I540"
from meatpoultryeggestablishments
where company like 'AGRO%';
'''
"establishmentnumber"	"A comma in the AGRO I540"
"M19190+P19190+V19190"	"AGRO Merchants Oakland LLC"
"M44102+P44102+V44102"	"AGRO Merchants Oakland LLC"
"I540"	"AGRO Merchants Oakland, LLC"
'''
start transaction;  --Shortcut key is Ctrl+Shift+M
update meatpoultryeggestablishments
set company = 'AGRO Merchantss Oakland, LLC'
where company = 'AGRO Merchants Oakland, LLC';
select establishmentnumber, company as "No comma in the AGRO I540 two s Merchants"
from meatpoultryeggestablishments
where company like 'AGRO%';
'''
"establishmentnumber"	"No comma in the AGRO I540 two s Merchants"
"M19190+P19190+V19190"	"AGRO Merchants Oakland LLC"
"M44102+P44102+V44102"	"AGRO Merchants Oakland LLC"
"I540"	"AGRO Merchantss Oakland LLC"
'''
rollback;  --Shortcut key is Ctrl+Shift+R
commit;  --Highlight and Execute press F5 to confirm by commit
select establishmentnumber, company as "A comma in the AGRO I540"
from meatpoultryeggestablishments
where company like 'AGRO%';
'''
"establishmentnumber"	"A comma in the AGRO I540"
"M19190+P19190+V19190"	"AGRO Merchants Oakland LLC"
"M44102+P44102+V44102"	"AGRO Merchants Oakland LLC"
"I540"	"AGRO Merchants Oakland, LLC"
'''