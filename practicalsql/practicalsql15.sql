#Chapter 15 Saving Time With Views, Fuctions, and Triggers (p 267)
#views are reusable database queries.  A view is a virtual table you can create dynamically using a saved query.  You can query a view, join a view to regular tables or other views, and use the view to update or insert data into the table it's based on with some caveats.  A regular view don't store data.  A materialized view caches data created by the view for which you can update.
#triggers run functions automatically when certain events occur on a table.

select geo_name, state_fips, county_fips, p0010001 as pop_2010
from us_counties_2010
where state_us_abbreviation = 'NV'
order by county_fips;
create or replace view nevade_counties_pop_2010viewname as  --the or replace keywords means if the view exists, replace it.  If replacing, the columns the same names and same data types must be in the same order and new columns must be at the end of the column list.
	select geo_name, state_fips, county_fips, p0010001 as pop_2010
	from us_counties_2010
	where state_us_abbreviation = 'NV'
	order by county_fips;
#to find the view, refresh database.  Then database name-->Schemas-->public-->Views.
select *
from nevade_counties_pop_2010viewname;  --run a view is running a select statement from a table.
--RM:  The view above with the select statement saves time running the same query.  Instead of typing the select geo_name, state_fips, county_fips, p0010001 as pop_2010 ..., run the view query.
drop view nevade_counties_pop_2010viewname;  --delete view or remove view

select c2010.geo_name, c2010.state_us_abbreviation as st, c2010.state_fips, c2010.county_fips, c2010.p0010001 as pop_2010, c2000.p0010001 as pop_2000, round((cast(c2010.p0010001 as numeric(8,1)) - c2000.p0010001) / c2000.p0010001 * 100, 1) as pct_change_2010_2000
from us_counties_2010 c2010 inner join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
and c2010.county_fips = c2000.county_fips
order by c2010.state_fips, c2000.county_fips;  --us_counties_2000 table doesn't exist
create or replace view county_pop_change_2010_2000viewname as
	select c2010.geo_name, c2010.state_us_abbreviation as st, c2010.state_fips, c2010.county_fips, c2010.p0010001 as pop_2010, c2000.p0010001 as pop_2000, round((cast(c2010.p0010001 as numeric(8,1)) - c2000.p0010001) / c2000.p0010001 * 100, 1) as pct_change_2010_2000
	from us_counties_2010 c2010 inner join us_counties_2000 c2000
	on c2010.state_fips = c2000.state_fips
	and c2010.county_fips = c2000.county_fips
	order by c2010.state_fips, c2000.county_fips;  --us_counties_2000 table doesn't exist
select geo_name, st, pop_2010, pct_change_2010_2000
from county_pop_change_2010_2000viewname
where st = 'NV';  --us_counties_2000 table doesn't exist.  No county_pop_change_2010_2000viewname view.

--You can update or insert data in the underlying table that a view queries as long as the view meets certain conditions.  One requirement is that the view must reference a single table.  If the view's query joins tables, then you can't perform inserts or updates directly.  The view's query can't contain distinct, group by, or other clauses.
select *
from employees;
select emp_id, first_name, last_name, dept_id  --excluded salary column
from employees
where dept_id = 1;
create or replace view employees_tax_deptviewname as
	select emp_id, first_name, last_name, dept_id
	from employees
	where dept_id = 1
	order by emp_id
	with local check option;  --restrict inserts or updates which doesn't meet the criteria in where clause; e.g. no insert or update a row where the dept_id is 3.  Also, can't insert or update salary because salary column excluded from view query
insert into employees_tax_deptviewname (first_name, last_name, dept_id)
values ('Suzanne', 'Legere', 1);  --successful
insert into employees_tax_deptviewname (first_name, last_name, dept_id)
values ('Jamil', 'White', 3);  --unsuccessful because dept_id is not 1 from where clause where dept_id = 1
update employees_tax_deptviewname
set last_name = 'Le Gere'
where emp_id = 5;  --if we update employees_tax_deptviewname the employee's dept_id is not 1, the update query fails.  Likewise salary because salary column excluded from view query.
delete from employees_tax_deptviewname
where emp_id = 5;  --if we delete employees_tax_deptviewname the employee's dept_id is not 1, the delete query fails.

--Functions.  Create a function.
--percent change = (new number - old number)/old number
create or replace function percent_changefunctionname(new_value numeric, old_value numeric, decimal_places integer default 1)
returns numeric as
	'select round(((new_value - old_value)/old_value) * 100, decimal_places);'
language sql
immutable  --no changes to the database
returns null on null input;  --function returns null if any input not supplied
select percent_changefunctionname(110, 108, 2);  --print 1.85
select geo_name, state_fips, county_fips, percent_changefunctionname(cast(state_fips as integer), cast(county_fips as integer), 3) as "poor percent change example"
from us_counties_2010
where state_us_abbreviation = 'NV'
order by county_fips;
--update data with a function.  Add data to a new column.
alter table teachers add column personal_days integer;
select first_name, last_name, hire_date, personal_days
from teachers;
create or replace function update_personal_daysfunctionname()  --no arguments because no user input required
returns void as $$  --function returns no data; it updates the personal_days column.  The $$ marks the start and end of the string containing the function's commands.  It's PostgreSQL non-ANSI SQL convention.
begin
	update teachers
	set personal_days =
		case when (now() - hire_date) between '5 years'::interval and '10 years'::interval then 4
		when (now() - hire_date) > '10 years'::interval then 5
		else 3
		end;
	raise notice 'personal_days updated';
end;
$$ language plpgsql;  --function written using PL/pgSQL
select update_personal_daysfunctionname();  --run the function

#RM:  skipped Using the Python Language in a Function p 281-282
#RM:  skipped Automating Database Actions With Triggers p 282-289
