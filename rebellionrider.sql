--Ctrl + Enter or F9 runs a query
--Shift + F4 cursor on table name opens table object window
--Ctrl + F7 automatic formatting
--Alt + F10 create new SQL worksheet

show user;
desc tablename; --shows column names and column types.  Describe table.

select *
from tab;  --show tables?
select *
from employees;
select employee_id, first_name, last_name, salary, salary + 1000
from employees;
select first_name ||' '||last_name  --concatenate.  Remember single quotes only.
from employees; 
--The Employee id of Mr. Steven King is 100
select 'The Employee id of Mr. '||first_name||' '||last_name||' is '||employee_id as "Detail"
from employees;
select distnct job_id
from job_history;
--case-manipulation functions: lower(), upper(), initcap().  e.g. insert into tablename values(upper(value)) converts value to caps uppercase
select first_name, lower(first_name), upper(first_name)
from employees;
--character-manipulation functions: concat() two parameters only, substr() works with strings numbers dates, length(), instr(), lpad() or rpad(), trim(), replace().  Concatenation operator is || infinite parameters only.
select concat(first_name, last_name)
from employees;  --there is no space between first_name and last_name
select first_name||last_name
from employees;  --there is no space between first_name and last_name
select first_name||' '||last_name
from employees;  --there is a space between first_name and last_name
select concat(concat(first_name, ' '),last_name)
from employees;  --there is a space between first_name and last_name.  Nested concat()
select department_name, substr(department_name,3,5)
from departments;  --start at third character, print next five characters 3-7 including third character

--create table tablename (columnname1 datatype1(size) constraint1, columnname2 datatype2(size) constraint2, columnname3 datatype3(size) constraint3, ...)
--You can create a table using the Oracle GUI.  Instructor suggests create table in Schema Browser.
--Two types of primary key.  Simple primary key involves one column.  Composite primary key involves more than one column.
create table product_master (product_id number(3) primary key, product_name varchar2(15), product_price number(5));
--give a constraint name to a primary key
create table product_master (product_id number(3) constraint prdmstr_pid_pk primary key, product_name varchar2(15), product_price number(5));  --prdmstr_pid_pk is the constraint name for the primary key
create table order_master (order_id number(3), order_date date, order_qnty number(5), constraint ordmstr_oi_pk primary key (order_id));  --primary key constraint at table level using create table
create table customer (cust_id number(3), cust_name varchar2(15), phone_no number(10)); --no primary key in create table.  It's created in alter table.
alter table customer add constraint cust_cid_pk primary key (cust_id);
create table customer (cust_id number(3), cust_name varchar2(15), phone_no number(10), constraint cust_cid_pk primary key (cust_id, phone_no)); --composite primary key
alter table customer drop constraint cust_cid_pk;  --delete primary key constraint named cust_cid_pk
alter table customer add constraint cust_cid_pk primary key (cust_id, phone_no); --define composite primary key using alter table

--foreign key constraint.
create table authors (author_id number(3) constraint athr_aid_pk primary key, author_name varchar2(30));
create table books (book_id number(3), book_title varchar2(30), book_author_id number(3) constraint bok_ai_fk references authors(author_id));  --define foreign key creating a table.  bok_ai_fk is the name of the foreign key constraint
create table books (book_id number(3), book_title varchar2(30), book_author_id number(3), constraint bok_ai_fk foreign key (book_author_id) references authors(author_id)); --define foreign key on table level
alter table books add constraint bok_ai_fk foreign key (book_author_id) references authors(author_id); --define foreign key using alter table

update authors set author_name='Nick' where author_id = 1;  --edit record, update record
delete from authors where author_id = 1;  --delete record.  In this case, author_id is a foreign key which can't be deleted.
alter table books rename to book;  --rename table alter table oldtablename rename to newtablename;
alter table books add genre varchar2(20); --add column alter table tablename add columnname columnnametype(size);
alter table books drop column genre; --delete column alter table tablename drop column columnname;
alter table books rename column book_title to booktitle; --rename column alter table tablename rename column oldcolumnname to newcolumnname;
alter table books modify book_author_id number(10);  --modify column change datatype change data type and columnsize alter table tablename modify columnname columnnamenewtype(newsize);  In this case, modify book_author_id from number(3) to number(10).

--Joins join.  Four joins:  inner, outer, cross, and self.  Outer has right, left, and full.  There are equi join and non-equi join.
--Source table is the table which comes after from clause in the select statement.  Target table is all the tables which come after join clause in the query.
--natural join no need to specify join columns explicitly.  All common columns in source table and target table are associated automatically.
select department_name, city
from departments natural join locations;  --location_id is the only common column between departments table and locations table or source table and target table.  department_name.location_id=locations.location_id.  department_name is from departments table.  city is from locations table.
select first_name, department_name
from employees natural join departments;  --department_id and manager_id columns are automatically associated.
select first_name, department_name
from employees join departments
on (employees.manager_id = departments.manager_id and employees.department_id=departments.department_id);  --department_id and manager_id columns are manually associated.
select first_name, department_name
from employees natural join departments;  --department_id and manager_id columns are automatically associated.
select first_name, department_name
from employees join departments
using(manager_id);  --manager_id column only is manually associated.  Results are different than department_id and manager_id columns are automatically associated.  We have equal values of manager_id in employees table and departments table.
--right outer join the target table is on the left of right outer join and the source table is on the right of right outer join.
select first_name, last_name, e.department_id, d.department_id, department_name
from employees e right outer join departments d
on e.department_id = d.department_id;  --same results below.  join condition.  on uses expressions
-- or
select first_name, last_name, department_id, department_name
from employees right outer join departments
using(department_id);  --same results above.  join condition.  using uses column name.
select first_name, last_name, department_id, department_name
from employees right outer join departments
using(department_id)
where (salary > 5000);  --include a where clause
--left outer join the target table is on the right of left outer join and the source table is on the left of left outer join.
select e.first_name, e.last_name, d.department_name
from employees e left outer join departments d
on e.department_id=d.department_id;  --same results below.  join condition.  on uses expressions
--or
select first_name, last_name, department_name
from employees left outer join departments
using (department_id); /* must have parantheses */  --same results above.  join condition.  using uses column name.
select first_name, last_name, department_name
from employees left outer join departments
using (department_id)
where (salary > 5000);  --include a where clause