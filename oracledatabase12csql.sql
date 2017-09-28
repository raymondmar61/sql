--Oracle Database 12c SQL by Jason Price
--Five types of SQL statements.  Query statements; Data Manipulation Language (DML) such as insert, update, delete; Data Definition Language (DDL) such as create, alter, drop, rename, truncate, Transaction Control (TC) such as commit, rollback, savepoint, and Data Control Language (DCL) such as grant and revoke.
--Foreign key references a column in another table.  The table containing the foreign key is known as the detail or child table.  The table that is referenced is known as the master or parent table. This type of relationship is known as a master-detail or parentchild relationship.
--Composite primary key when a primary key consists of multiple columns.  The combination of the multiple columns must be unique for each row.

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