#Chapter 06 Joining Tables In A Relational Database (p 73)
#join or inner join RM:  both are the same, left join, right join, full outer join returns every row from both tables and matches row then joins the rows where values in the joined columns match and if there's no match for a value in either the left or right table the query result contains an empty row for the other table or see all rows regardless of any match, cross join returns every possible combination of rows from both tables.
#An example of many-to-many relationships is a table of baseball players could be joined to a table of field positions.  Each player can be assigned to multiple positions, and each position can be played by multiple people.

create table departments (dept_id bigserial, dept varchar(100), city varchar(100), constraint dept_key primary key (dept_id), constraint dept_city_unique unique (dept, city));
create table employees (emp_id bigserial, first_name varchar(100), last_name varchar(100), salary integer, dept_id integer references departments (dept_id), constraint emp_key primary key (emp_id), constraint emp_dept_unique unique (emp_id, dept_id));
insert into departments(dept, city)
values ('Tax','Atlanta'), ('IT','Boston');
insert into employees(first_name, last_name, salary, dept_id)
values ('Nancy','Jones',62500,1), ('Lee','Smith',59300,1),('Soo','Nguyen',83000,2),('Janet','King',95000,2);
#The unique constraint, briefly, guarantees that values in a column, or a combination of values in more than one column, are unique.  For example, in departments table, each row must have a unique pair of values for dept column and city column.  In employees table, each row must have a unique pair of values for emp_id column and dept_id column.  Add these individual constraints to avoid duplicate data.

select *
from employees join departments
on employees.dept_id = departments.dept_id;
select *
from employees e join departments d
on e.dept_id = d.dept_id;

create table schools_left (id integer constraint left_id_key primary key, left_school varchar(30));  --RM declared constraint while creating column instead of declared constraint at the end of the create table statement
create table schools_right (id integer constraint right_id_key primary key, right_school varchar(30));
insert into schools_left
values (1, 'Oak Street School'), (2, 'Roosevelt High School'), (5, 'Washington Middle School'), (6, 'Jefferson High School');
insert into schools_right
values (1, 'Oak Street School'), (2, 'Roosevelt High School'), (3, 'Moorison Elementary'), (4, 'Chase Magnet Academy'), (6, 'Jefferson High School');
select *
from schools_left join schools_right
on schools_left.id = schools_right.id;  --returned schools 1, 2, 6
select *
from schools_left left join schools_right
on schools_left.id = schools_right.id;  --returned schools 1, 2, 5, 6
select *
from schools_left left join schools_right
on schools_left.id = schools_right.id
where schools_right.id is null;  --returned schools 5 because there is a 5 in left school and no 5 in right school.
select *
from schools_left right join schools_right
on schools_left.id = schools_right.id;  --returned schools 1, 2, 3, 4, 6
select *
from schools_left full outer join schools_right
on schools_left.id = schools_right.id;  --returned schools 1, 2, 3, 4, 5, 6.  Returns every row from left table and every row from right table including matching rows and blanks for missing rows from the right table and blanks for missing rows from the left table.  Useful to merge two data sources or visualize the degree which the tables share matching values.
select *
from schools_left cross join schools_right;  --returned the cartesian product.  Rows in left table multiplied by rows in right table.
select schools_left.id as "id", schools_left.left_school, schools_right.right_school
from schools_left left join schools_right
on schools_left.id = schools_right.id;
select lt.id as "id", lt.left_school, rt.right_school
from schools_left lt left join schools_right rt
on lt.id = rt.id;

#Joining multiple tables
create table schools_enrollment (id integer, enrollment integer);
create table schools_grades (id integer, grades varchar(10));
insert into schools_enrollment
values (1, 360), (2, 1001), (5, 450), (6, 927);
insert into schools_grades
values (1, 'K-3'), (2, '9-12'), (5, '6-8'), (6, '9-12');
select lt.id, lt.left_school, en.enrollment, gr.grades
from schools_left lt left join schools_enrollment en
on lt.id = en.id
	left join schools_grades gr
	on en.id = gr.id;