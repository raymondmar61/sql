#Chapter 09 Inspecting And Modifying Data (p 129)
/*Database table changes alter table to edit table, add column to insert column, alter column to edit column, drop column to delete column.
alter table tablename add column columname datatype;
alter table tablename drop column columnname;
alter table tablename alter column columname set data type datatype;  --change data type
alter table tablename alter column columname set not null;  --add column constraint not null
alter table tablename alter column columname drop not null;  --delete column constraint not null
update tablename set columnname = value;
update tablename set columnnamea = valuea, columnnameb = valueb;  --update values in multiple columns at a time
update tablename set columnnamea = value where criteria;  --restrcit updates to particular rows
update tablenamea
	set columnname = (select columnname from tablenameb where tablenamea.column = tablenameb.column)
	where exists (seelct columname from tablenameb where tablenamea.column = tablenameb.column);  --update one table with values from another table.  This is a subquery.
update tablename
	set column = tablenameb.column
	from tablenameb
	where tablename.column = tablenameb.column;  --simpler syntax update values across tables
create table tablenamecopy as
	select *
	from tablename;  --copy table or backup table
delete from tablename;  --delete all rows
delete from tablename where criteria;  --delete specific rows
drop tablename;  --delete table
*/

create table meat_poultry_egg_inspect (est_number varchar(50) constraint est_number_key primary key, company varchar(100), street varchar(100), city varchar(30), st varchar(2), zip varchar(5), phone varchar(14), grant_date date, activities text, dbas text);
copy meat_poultry_egg_inspect
from 'i:\program files\postgresql\MPI_Directory_by_Establishment_Name.csv'
with (format csv, header, delimiter ',');
create index company_idx on meat_poultry_egg_inspect (company);

select company, street, city, st, count(*) as address_count
from meat_poultry_egg_inspect
group by company, street, city, st
having count(*) > 1
order by company, street, city, st;  --show results more than one row has the same combination of values or duplicates valid or not
select st, count(*) as st_count
from meat_poultry_egg_inspect
group by st
order by st;
select *
from meat_poultry_egg_inspect
where st is null;  --find companies missing state field
select company, count(*) as company_count
from meat_poultry_egg_inspect
group by company
order by company asc;  --inspect company field searching for duplicates of any kind; e.g. Armour-Eckrich Meats also has Armour - Enrich Meats, LLC
select length(zip), count(*) as zipcode_length_count
from meat_poultry_egg_inspect
group by length(zip)
order by length(zip) asc;  --count length of zip codes.  Returned three rows 3 len zip code, 4 len zip code, and 5 len zip code.
select st, count(*) as st_count
from meat_poultry_egg_inspect
where length(zip) < 5;
select st, count(*) as st_count
from meat_poultry_egg_inspect
where length(zip) < 5
group by st
order by st asc;  --count states with zip codes less than five characters

create table meat_poultry_egg_inspect_backup as
	select *
	from meat_poultry_egg_inspect;  --copy table as a backup table.  Indexes are not copied when creating a table backup using create table.
select (select count(*) from meat_poultry_egg_inspect) as original, (select count(*) from meat_poultry_egg_inspect_backup) as backup;  --RM:  run select statements counts from a select statement
alter table meat_poultry_egg_inspect add column st_copy varchar(2);  --backup column
update meat_poultry_egg_inspect set st_copy = st;  --copy data from st column to st_copy column
select est_number, st, st_copy
from meat_poultry_egg_inspect;  --view data from st column and st_copy column
update meat_poultry_egg_inspect
set st = 'MN'
where est_number = 'V18677A';  --update row
update meat_poultry_egg_inspect
set st = 'AL'
where est_number = 'M45319+P45319';  --update row
update meat_poultry_egg_inspect
set st = 'WI'
where est_number = 'M263A+P263A+V263A';  --update row
update meat_poultry_egg_inspect
set company = 'Armour-Eckrich Meats'
where company like 'Armour%';
update meat_poultry_egg_inspect
set zip = '00' || zip
where st in ('PR','VI') and length(zip) = 3;  --zipcode column zip is a string.  Add 00 to three digit zip codes.
update meat_poultry_egg_inspect
set zip = '0' || zip
where st in ('CT','MA','ME','NH','NJ','RI','VT') and length(zip) = 4;  --zipcode column zip is a string.  Add 0 to four digit zip codes.

create table state_regions (st varchar(2) constraint st_key primary key, region varchar(20) not null);
copy state_regions
from 'i:\program files\postgresql\state_regions.csv'
with (format csv, header, delimiter ',');
alter table meat_poultry_egg_inspect add column inspection_date date;
update meat_poultry_egg_inspect
set inspection_date = '2019-12-01'
where exists (
	select state_regions.region
	from state_regions
	where state_regions.st=meat_poultry_egg_inspect.st
	and state_regions.region = 'New England');  --set inspection date 2019-12-01 where state has region New England

delete from meat_poultry_egg_inspect
where st in ('PR','VI');
alter table meat_poultry_egg_inspect drop column zip_copy;
drop table meat_poultry_egg_inspect_backup;  --delete table

--RM start page 149 06/13/18
#You can check your changes before finalizing them and cancel the change.  Wrap the SQl statements within a transaction block which is a group of statements you define using the following keywords at the beginning and end of the query:  start transaction, commit, rollback.
