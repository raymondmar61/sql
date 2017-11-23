#find duplicates in a column
select cust_name
from customers
group by cust_name
having count(cust_name) > 1;

#find duplicates in a row
select trim(vend_id), trim(prod_price)
from products;
select trim(vend_id), trim(prod_price)
from products
group by vend_id, prod_price
having count(*) > 1;

#insert data from one table to another table
insert into tabletobecopiedortargettable
select * from tablecopysource;
insert into tabletobecopiedortargettable (column1, column2)
select (column1, column2) from tablecopysource;
insert into tabletobecopiedortargettable (column1, column2)
select (column1, column2) from tablecopysource
where column1 = 5;

#CASE expression which is if then else in select statement
--There are two CASE expression.  1 simple case and 2 search case.
/* 1 simple case
(case searchexpression
	when inputexpression1 then result1
	when inputexpression2 then result2
	when inputexpression3 then result3
	when inputexpressionn then resultn
	else elseresult
end)
*/
select name, (case name
  when 'Modern Science' then '001'
  when 'Chemistry' then '002'
  else '005'
end) as "case alias", price
from products;
select (case 'dog'
	when 'cat' then '1 False'
	when 'dog' then '2 True'
	when 'cow' then '3 False'
	when 'dog' then '4 True'
	else 'sorry'
end)
from dual; --returns 2 True
select (case 'dog'
	when 'cat' then '1 False'
	when 'Monkey' then '2 True'
	when 'cow' then '3 False'
	when 'Frog' then '4 True'
	else 'sorry'
end)
from dual; --returns sorry
/* 2 search case
(case 
	when condition1 then result1
	when condition2 then result2
	when condition3 then result3
	when conditionn then resultn
	else elseresult
end)
*/
select firstname, lastname, (case 
	when firstname = 'Tony' and lastname = 'Stark' then 'Ironman',
	when firstname = 'Bruce' and lastname = 'Wayne' then 'Batman',
	when firstname = 'Clark' and lastname = 'Kent' then 'Superman',
	when firstname = 'Peter' and lastname = 'Parker' then 'Spiderman'
	else 'sorry'
end) as "superhero", bornonearthyorn
from superheroestable;
select first_name, salary, (case
	when salary <=9000 then 'case 1'
	when last_name = 'King' and manager_id is null then 'case 2'
	when salary between 10000 and 13500 then 'case 3'
	when salary in (14000,17000,24000) then 'case 4'
	else 'sorry'
end) as "cases comparsion operations", last_name
from employees
where salary >= 8500;

#Import data from Excel to Oracle SQL Developer
create table jobsearchlog (dateapplied date, wherejobfound varchar(100), applyjobat varchar(100), company varchar(100), position varchar(100), jobid varchar(50), comments varchar(250), userid varchar(50), password varchar(50));  --RM create table at hrpdborcl
drop table jobsearchlog; --RM: needed increase varchar length.  delete table and update create table sql statement