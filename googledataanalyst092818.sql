create table employees
(employeeid integer, startdate date);
create table promotions
(employeeid integer, startdate date);
alter table promotions rename column startdate to promotiondate;  --edit column name alter column name
alter table promotions
add promotion varchar2(1);  --add column insert column
delete from promotions
where promotion = 'N';  --delete rows.  RM:  employees not promoted shouldn't be in the table.  promotion column added when I created the Excel table.

--How many employees were not promoted?   Answer is 29.
select count(*)
from employees;  --returns 60
select count(*)
from promotions;  --returns 31

select count(e.employeeid) as "Count employees", count(p.employeeid) as "Count promotions", count(e.employeeid)-count(p.employeeid) as "difference"
from promotions p full outer join employees e
on e.employeeid = p.employeeid;  --returns 60, 31, 29
--also
select employeeid
from employees
minus
select employeeid
from promotions;  --returns 29 rows

/* full outer join retrives all the columns or matching rows from both tables and nulls for the unmatched rows of both tables.  The union of left and router outer joins and unmatched rows of both tables are returned.  */
select *
from employees e full outer join promotions p
on e.employeeid = p.employeeid;  --if employee id in employees table is in promotions table, then all columns populated; otherwise columns in employees table are populated only
select e.employeeid as "employeeid employees", p.employeeid as "employeeid promotions"
from promotions p full outer join employees e
on e.employeeid = p.employeeid;  --returns 60 rows.  employeeid promotions not in employeeid employees cell is null
select e.employeeid as "employeeid employees", p.employeeid as "employeeid promotions"
from employees e full outer join promotions p
on e.employeeid = p.employeeid;  --returns 60 rows.  employeeid employees in employeeid promotions cell promotions cell is populated with same id number

create table items
(item varchar2(20), weight number, confidence float);

--How many items have the maximum confidence number?  Answer is 4.
select max(confidence)
from items;  --return 10

select count(*)
from items
where confidence = max(confidence);  --error message group function is not allowed here

select count(*)
from items
where confidence = 
  (select max(confidence)
  from items);  --return 4