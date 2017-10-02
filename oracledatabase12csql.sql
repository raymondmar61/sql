--Oracle Database 12c SQL by Jason Price
--Five types of SQL statements.  Query statements; Data Manipulation Language (DML) such as insert, update, delete; Data Definition Language (DDL) such as create, alter, drop, rename, truncate, Transaction Control (TC) such as commit, rollback, savepoint, and Data Control Language (DCL) such as grant and revoke.
--Foreign key references a column in another table.  The table containing the foreign key is known as the detail or child table.  The table that is referenced is known as the master or parent table. This type of relationship is known as a master-detail or parentchild relationship.
--Composite primary key when a primary key consists of multiple columns.  The combination of the multiple columns must be unique for each row.

--BONUS
select *
from tab;  --show tables and more tables?
select *
from tabs;  --show tables?

--CHAPTER 1 INTRODUCTION
describe customers;  --describe tablename.  Returns columns
insert into customers (customer_id, first_name, last_name, dob, phone)
values (6, 'Fred', 'Brown', 'Jan-01-1970', '800-555-1215');
update customers
set last_name = 'Orange'
where customer_id = 2;
delete from customers
where customer_id = 6;
rollback; --undo the changes.  It didn't work when I deleted customer_id = 6.

--CHAPTER 2 RETRIEVING INFORMATION FROM DATABASE TABLES.  Also arithmetic, math.
select customer_id, first_name, last_name, dob, phone
from customers;
select *
from customers
where customer_id=2;
select rowid, customer_id
from customers;  --Each row has an 18 digit unique row identifier or rowid.  Retrieves the ROWID and customer_id.
describe customers;
select rownum customer_id, first_name, last_name, dob, phone
from customers;  --ROWNUM returns the row number
select 2+6, 2-6, 2*6, 2/6, to_date('10/2/2017')+2, to_date('10/2/2017')-3, to_date('10/2/2017')-to_date('9/15/2017')
from dual;  --display 8, -4, 12, 0.33333..., 10/04/2017, 09/29/2017, 17
select name, price, price + 2, (price*3)+1
from products;
select price, price*2 as doubleprice, price*2 as "Double Price"
from products;  --column alias doubleprice replace price*2 in column name.  as keyword is optional.  Double quotation for sentences.
select first_name, last_name, first_name || ' ' || last_name as "Customer Name"
from customers;  --concatenation operator || combine column values
select customer_id, first_name, last_name, dob, phone
from customers
where dob is null;
select customer_id, first_name, last_name, nvl(dob,'01/01/2000') as "null dates replace with a date", phone
from customers;  --use the nvl() function to determine a null value and a blank value.  nvl(columname, value returned if columnname is null)
select customer_id, first_name, last_name, nvl(phone, 'Unknown phone number') as phone_number
from customers;  --use the nvl() function to determine a null value and a blank value.  nvl(columname, value returned if columnname is null)
select distinct customer_id
from purchases;  --distinct suppresses the duplicate rows
--stop page 38