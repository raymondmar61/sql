select *
from employee;
/*
# emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id
'100', 'David', 'Wallace', '1967-11-17', 'M', '250000', NULL, '1'
'101', 'Jan', 'Levinson', '1961-05-11', 'F', '110000', '100', '1'
'102', 'Michael', 'Scott', '1964-03-15', 'M', '75000', '100', '2'
'103', 'Angela', 'Martin', '1971-06-25', 'F', '63000', '102', '2'
'104', 'Kelly', 'Kapoor', '1980-02-05', 'F', '55000', '102', '2'
'105', 'Stanley', 'Hudson', '1958-02-19', 'M', '69000', '102', '2'
'106', 'Josh', 'Porter', '1969-09-05', 'M', '78000', '100', '3'
'107', 'Andy', 'Bernard', '1973-07-22', 'M', '65000', '106', '3'
'108', 'Jim', 'Halpert', '1978-10-01', 'M', '71000', '106', '3'
*/
select *
from branch;
/*
'1', 'Corporate', '100', '2006-02-09'
'2', 'Scranton', '102', '1992-04-06'
'3', 'Stamford', '106', '1998-02-13'
*/
select *
from client;
/*
# client_id, client_name, branch_id
'400', 'Dunmore Highschool', '2'
'401', 'Lackawana Country', '2'
'402', 'FedEx', '3'
'403', 'John Daly Law, LLC', '3'
'404', 'Scranton Whitepages', '2'
'405', 'Times Newspaper', '3'
'406', 'FedEx', '2'
*/
select *
from works_with;
/*
# emp_id, client_id, total_sales
'102', '401', '267000'
'102', '406', '15000'
'105', '400', '55000'
'105', '404', '33000'
'105', '406', '130000'
'107', '403', '5000'
'107', '405', '26000'
'108', '402', '22500'
'108', '403', '12000'
*/
select *
from branch_supplier;
/*
'2', 'Hammer Mill', 'Paper'
'2', 'J.T. Forms & Labels', 'Custom Forms'
'2', 'Uni-ball', 'Writing Utensils'
'3', 'Hammer Mill', 'Paper'
'3', 'Patriot Paper', 'Paper'
'3', 'Stamford Lables', 'Custom Forms'
'3', 'Uni-ball', 'Writing Utensils'
*/
select emp_id, first_name as firstname, last_name, salary as "annual salary"
from employee
where salary < 100000
order by sex, first_name desc, last_name
limit 5;
/*
# emp_id, firstname, last_name, annual salary
'104', 'Kelly', 'Kapoor', '55000'
'103', 'Angela', 'Martin', '63000'
'105', 'Stanley', 'Hudson', '69000'
'102', 'Michael', 'Scott', '75000'
'106', 'Josh', 'Porter', '78000'
*/
select distinct supply_type
from branch_supplier;
/*
# supply_type
'Paper'
'Custom Forms'
'Writing Utensils'
*/
select count(emp_id)
from employee
where sex = 'F' and birth_day > '1970-01-15';
/*
# count(emp_id)
'2'
*/
select avg(salary)
from employee
where sex = 'M'; #return 101333.3333
select sum(salary)
from employee; #return 836000
select count(sex), sex
from employee
group by sex;
/*
# count(sex), sex
6, M
3, F
*/
select emp_id, sum(total_sales)
from works_with
group by emp_id;
/*
# emp_id, sum(total_sales)
102, 282000
105, 218000
107, 31000
108, 34500
*/
select *
from client
where client_name like '%LLC'; #use % wild card instead of * wild card in MySQL.  Underscore _ is wild card one character.
/*
# client_id, client_name, branch_id
'403', 'John Daly Law, LLC', '3'
*/
select *
from employee
where birth_day like '____-02%';
#or
select *
from employee
where birth_day like '%-02-%';
/*
# emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id
'104', 'Kelly', 'Kapoor', '1980-02-05', 'F', '55000', '102', '2'
'105', 'Stanley', 'Hudson', '1958-02-19', 'M', '69000', '102', '2'
*/
select first_name, last_name
from employee
union
select branch_name, branch_id
from branch
union
select client_name, client_id
from client; #number of columns must be equal in both select statements and same data types, yet sql statement ran because the id columns data types are integers
/*
# first_name, last_name
'David', 'Wallace'
'Jan', 'Levinson'
'Michael', 'Scott'
'Angela', 'Martin'
'Kelly', 'Kapoor'
'Stanley', 'Hudson'
'Josh', 'Porter'
'Andy', 'Bernard'
'Jim', 'Halpert'
'Corporate', '1'
'Scranton', '2'
'Stamford', '3'
'Dunmore Highschool', '400'
'Lackawana Country', '401'
'FedEx', '402'
'John Daly Law, LLC', '403'
'Scranton Whitepages', '404'
'Times Newspaper', '405'
'FedEx', '406'
*/
select client_name as "Client And Supplier Names", branch_id
from client
union
select supplier_name, branch_id
from branch_supplier;
/*
# Client And Supplier Names, branch_id
'Dunmore Highschool', '2'
'Lackawana Country', '2'
'FedEx', '3'
'John Daly Law, LLC', '3'
'Scranton Whitepages', '2'
'Times Newspaper', '3'
'FedEx', '2'
'Hammer Mill', '2'
'J.T. Forms & Labels', '2'
'Uni-ball', '2'
'Hammer Mill', '3'
'Patriot Paper', '3'
'Stamford Lables', '3'
'Uni-ball', '3'
*/
select salary as "Company spent and earned"
from employee
union
select total_sales
from works_with;
/*
# Company spent and earned
250000
110000
75000
63000
55000
69000
78000
65000
71000
267000
15000
33000
130000
5000
26000
22500
12000
*/


