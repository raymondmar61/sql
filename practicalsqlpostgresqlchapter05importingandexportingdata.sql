create table uscountiespopest2019 (statefips text, countyfips text, region smallint, statename text, countyname text, arealand bigint, areawater bigint, internalpointlat numeric(10,7), internalpointlon numeric(10,7), popest2018 integer, popest2019 integer, births2019 integer, deaths2019 integer, internationalmigr2019 integer, domesticmigr2019 integer, residual2019 integer, constraint counties2019key primary key (statefips, countyfips));  --columns statefips and countyfips combined are the primary key identified as counties2019key

select *
from uscountiespopest2019;

copy uscountiespopest2019
from '/home/mar/postgresql/us_counties_pop_est_2019.csv'
with (format csv, header, delimiter ',');  --ERROR:  could not open file "/home/mar/postgresql/us_counties_pop_est_2019.csv" for reading: Permission denied HINT:  COPY FROM instructs the PostgreSQL server process to read a file. You may want a client-side facility such as psql's \copy.  SQL state: 42501

grant select on uscountiespopest2019 to PUBLIC;  --https://bobcares.com/blog/postgresql-error-42501/
GRANT SELECT ON uscountiespopest2019 TO postgres;  --https://bobcares.com/blog/postgresql-error-42501/ and https://chartio.com/resources/tutorials/how-to-set-the-default-user-password-in-postgresql/
grant all privileges on table uscountiespopest2019 to PUBLIC;
--RM all of the grant select didn't work.  Solution go to /home/mar/postgresql/ in Linux file explorer.  Open Properties.  Under Permissions press Change Permissions for Enclosed Files.  Under Others:  Select Read and Write for Files and Create and delete files for Folders.
copy uscountiespopest2019
from '/home/mar/postgresql/us_counties_pop_est_2019.csv'
with (format csv, header, delimiter ',');

select *
from uscountiespopest2019;

select countyname, statename, arealand
from uscountiespopest2019
order by arealand desc
limit 3;  --return the top three rows, not necessarily top three arealand

create table supervisorsalaries (id integer generated always as identity primary key, town text, county text, supervisor text, startdate date, salary numeric(10,2),benefits numeric(10,2));  --Generated always as identity primary key type exactly for id as a primary key integer.  Generated always as identity is a keyword combination.
copy supervisorsalaries
from '/home/mar/postgresql/supervisor_salaries.csv'
with (format csv, header);  --error message supervisor_salaries.csv doesn't have first column id
copy supervisorsalaries (town, supervisor, salary)
from '/home/mar/postgresql/supervisor_salaries.csv'
with (format csv, header);  --correct copy mention the column order in csv file from left to right
select *
from supervisorsalaries;
-- "id"	"town"	"county"	"supervisor"	"startdate"	"salary"	"benefits"
-- 11	"Anytown"		"Jones"		67000.00	
-- 12	"Bumblyburg"		"Larry"		74999.00	
-- 13	"Moetown"		"Smith"		52100.00	
-- 14	"Bigville"		"Kao"		81500.00	
-- 15	"New Brillig"		"Carroll"		102690.00	
delete from supervisorsalaries;  --Delete rows only.  Delete data only.  Table remains.
copy supervisorsalaries (town, supervisor, salary)
from '/home/mar/postgresql/supervisor_salaries.csv'
with (format csv, header)
where town='New Brillig';  --correct copy New Brillig town mention the column order in csv file from left to right

create temporary table supervisorsalariestemporarytable (like supervisorsalaries including all);  --including all keywords copy rows, columns, and components such as indexes and the identity settings
copy supervisorsalariestemporarytable (town, supervisor, salary)
from '/home/mar/postgresql/supervisor_salaries.csv'
with (format csv, header);
select *
from supervisorsalariestemporarytable;
-- "id"	"town"	"county"	"supervisor"	"startdate"	"salary"	"benefits"
-- 1	"Anytown"		"Jones"		67000.00	
-- 2	"Bumblyburg"		"Larry"		74999.00	
-- 3	"Moetown"		"Smith"		52100.00	
-- 4	"Bigville"		"Kao"		81500.00	
-- 5	"New Brillig"		"Carroll"		102690.00	
insert into supervisorsalaries (town, county, supervisor, salary)
select town, 'add Mills all rows in county column', supervisor, salary
from supervisorsalariestemporarytable; --insert rows from supervisorsalariestemporarytable to supervisorsalaries including new county column
select *
from supervisorsalaries;
-- "id"	"town"	"county"	"supervisor"	"startdate"	"salary"	"benefits"
-- 26	"Anytown"	"add Mills all rows in county column"	"Jones"		67000.00	
-- 27	"Bumblyburg"	"add Mills all rows in county column"	"Larry"		74999.00	
-- 28	"Moetown"	"add Mills all rows in county column"	"Smith"		52100.00	
-- 29	"Bigville"	"add Mills all rows in county column"	"Kao"		81500.00	
-- 30	"New Brillig"	"add Mills all rows in county column"	"Carroll"		102690.00	
drop table supervisorsalariestemporarytable;  --delete table or remove table

copy uscountiespopest2019
to '/home/mar/postgresql/exporttotextfile.txt'
with (format csv, header, delimiter '|');  --export table as a csv text file with a header separated by |
copy uscountiespopest2019 (countyname, internalpointlat, internalpointlon)
to '/home/mar/postgresql/exportselectedcolumnstotextfile.txt'
with (format csv, header, delimiter '|');
copy (
    select countyname, statename
    from uscountiespopest2019
    where countyname ilike '%mill%')
to '/home/mar/postgresql/exportlikemillcountynametotextfile.txt'
with (format csv, header);