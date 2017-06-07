/* Learning SQL A Step-by-Step Guide Using Access Sikha Bagui Richard Earp */
/* Access database student.mdb */
/* Should end SQL with a semicolon.  "" or '' is valid.  SQL comments invalid in Access.  If a date is entered in a text string, date is enclosed using the pound # sign; Access converts text string to date format.  */
/* string count begins at 1 */
/* Access data is handled as if it were all uppercase. */

/* Chapter 1 Getting Started with SQL in Access */
select *
from student
where class = 4;

select *
from room;

/* Chapter 2 Beginning SQL Commands in Access */
select sname, class
from student;

select sname, class
from student
order by class DESC; /* ascending ASC is default */

select sname, class
from student
order by class DESC, sname;

/* Comparisons > < <> = >= <= and or between */

select *
from student
where class = 4 and major = "acct";

select *
from student
where class = 3 or major = "cosc";

select sname, class
from student
where class between 1 and 3; /* class >= 1 and class <= 3 is valid */

select sname, class, bdate
from student
where bdate between #1/1/1980# and #7/1/1981#;

select count(*)
from student;

select count(class)
from student;

select sname, class
from student
where class is null;

select sname, class
from student
where class is not null;

select sname as [student name], major as "student major", class as student_class /* Access displays the quotes around headings */
from student
where class = 4;

select s.sname
from student s /* table alias */
where s.class = 4;

select student.sname
from student
where student.class = 4; /* table qualifier */

select bldg as [building], room, capacity
from room
order by capacity desc;

select course_num as [course number], instructor, bldg as [building number]
from section
where semester = 'fall' and year = '98'; /* year is a text field */

select grades.student_number
from grade_report as grades
where grades.grade = "c" or grades.grade = "d";

select course_name, course_number
from course
where credit_hours >3;

select count(*)
from department_to_major;

SELECT Count(bldg)
FROM room;
/* Answer above is 10; however, run the distinct bldg query below.  Four distinct buildings */
SELECT distinct bldg
FROM room;

/* Chapter 3 Creating and Populating Tables */
/* Access data types are text, char or varchar, integer, real, float or number, decimal, smallint, tinyint, money or currency, datetime, binary, bit, image, and uniqueidentifier. */

create table employee (name varchar(20), address varchar(20), employee_number number, salary currency);

create table names (name varchar(20));

insert into names
values ("Joe Smith");

insert into employee
values("Joe Smith", "123 4th St.", 101, 2500); /* insert a row values match column for column; e.g. first is name, second address, third employee number, fourth salary */

insert into employee(name, address)
values("R Mar","40 Main St.")  /* can insert values in selected columns.  Mention which columns inserted values match column for column */

insert into employee
values("B.H. Fran", null, 200, null)  /* can insert values in selected columns using null.  Columns inserted values match column for column */

insert into Names(name)
select name
from employee
where salary > 2600; /* insert into ... select insert many rows into a table.  insert data into name column in Names table name data from employee table salary greater than 2600.  insert into targettable(targettablecolumn) select sourcecolumn from sourcetable */

insert into emp1(addr, sal, empno)
select address, salary, employee_number
from employee;

insert into emp2
select *
from emp1
where employee_number >= 100; /* emp2 and emp1 have identical columns */

update emp2
set sal = 0; /* all sal is zero in emp2 table */

update employee
set salary = 0
where employee_number = 101; /* employee number 101 salary is zero in employee table*/

alter table employee
add balance currency; /* add new column balance in employee table */

alter table employee
alter column balance number /* change data type balance column from currency to number */

alter table employee
drop balance; /* delete column balance in employee table */

delete *
from employee
where salary < 100; /* delete rows from employee table salary less than 100 */

drop table names; /* delete table names */

/* Use format to change how a date is displayed.  format doesn't work for inserts. */
select format (birthdate, 'mm-dd-yyyy') as [date], name
from datetable;

select format (birthdate, 'dddd, dd mmmm, yyyy') as [date], name
from datetable;

/*chapter 3 exercise 1 */
create table Cust (customernumber integer, address varchar(20), balance currency);
insert into cust
values(105, "5 Apple Ave.",791);
select *
from cust
where customernumber = 103 or customernumber = 104;
select *
from cust
order by balance desc;
/*chapter 3 exercise 2 */
select sname, class, major
from student
where class <=2
order by major desc;
/*chapter 3 exercise 4 */
create table Cust1 (cnum integer, bal currency);
create table Cust2 (cnum integer, bal currency);
insert into cust1(cnum, bal)
select customernumber, balance
from cust;
insert into cust2(cnum, bal)
select customernumber, balance
from cust;
delete *
from cust2
where bal > 500;
/* chapter 3 exercise 5 */
alter table cust1
add date_opened date;
insert into cust1
values(106,1793,#1/1/2001#);
update cust1
set date_opened = #1/1/1991#;
update cust1
set bal = 0;
update cust1
set date_opened = #10/21/1960#
where cnum = 101;
select format (date_opened, 'yyyy mmmm dd dddd') as [date]
from cust1;
alter table cust1
alter column bal integer;
alter table cust1
drop date_opened;
drop table cust2;

/* Chapter 4 Joins */
select *
from course inner join prereq
on course.course_number=prereq.course_number; /* rows from course table without a matching row in prereq don't appears in results; likewise, null in the join attribute course_number */

select *
from course, prereq
where course.course_number=prereq.course_number; /* can use where clause for inner join.  Notice the comma in from statement line */

select course.course_name, course.course_number, course.credit_hours, course.offering_dept, prereq.prereq
from course inner join prereq
on course.course_number=prereq.course_number
order by course.course_number; /* order by 2; is valid.  2 indicates second column course.course_number */

select c.course_name, c.course_number, d2m.dname
from department_to_major d2m inner join
(course c inner join prereq p
on c.course_number=p.course_number)
on c.offering_dept=d2m.dcode; /* join multiple tables using a nested inner join */

select c.course_name, c.course_number, d.dname
from course c, prereq p, department_to_major d
where c.course_number=p.course_number and c.offering_dept=d.dcode /* can use where clause for nested inner join.  Notice the comm in from statement line */

select *
from course left join prereq
on course.course_number=prereq.course_number; /* include all records from thh left table even if there are no matching values in the right table. */

select *
from course right join prereq
on course.course_number=prereq.course_number; /* include all records from thh right table even if there are no matching values in the left table. */

select *
from prereq right join course
on prereq.course_number=course.course_number; /* prereq table columns appears first, course table columns appear second.  Compare to the from course left join prereq SQL query */

/* In Access, a left join or a right join can be nested inside an inner join.  An inner join can't be nested inside a left join or a right join. */

/*chapter 4 exercise 1 */
create table stu (name varchar(10), majorcode varchar(2));
create table major (majorcode varchar(2), majordesc varchar(20));
insert into stu 
values ("Jones","CS");
insert into stu 
values ("Sumon",null);
insert into stu (majorcode,name) 
values (null,"Sudip");
insert into major
values ("HI","History");
select *
from stu inner join major
on stu.majorcode=major.majorcode;
select *
from stu, major
where stu.majorcode=major.majorcode;
select count(*)
from stu inner join major
on stu.majorcode=major.majorcode;
select stu.name, stu.majorcode, major.majordesc
from stu left join major
on stu.majorcode=major.majorcode;
/* chapter 4 exercise 2 */
create table t1 (name varchar(20), jobno number);
create table t2 (jobno number, jobdesc varchar(20));
insert into t1
values ("name1",1);
insert into t2
values (1,"jobdesc1");
select count(*)
from t1 inner join t2
on t1.jobno=t2.jobno;
/* chapter 4 exercise 3 */
create table t3 (jobdesc varchar(20), minpay number);
insert into t3
values("jobdesc1",100);
select t1.name, t1.jobno, t2.jobdesc, t3.minpay
from t1 inner join 
(t3 inner join t2
on t3.jobdesc=t2.jobdesc)
on t1.jobno = t2.jobno;
select count(*)
from t1 inner join 
(t3 inner join t2
on t3.jobdesc=t2.jobdesc)
on t1.jobno = t2.jobno;
/* chapter 4 exercise 4 */
select p.prereq, c.course_name
from prereq p inner join course c
on p.prereq=c.course_number;
/* chapter 4 exercise 5 */
select s.instructor, s.course_num, c.course_name, s.semester, s.year
from course c inner join section s
on c.course_number=s.course_num;
select c.course_name, s.instructor, c.offering_dept
from course c inner join section s
on s.course_num=c.course_number;
/* chapter 4 exercise 6 */
select s.instructor, s.course_num, c.course_name, s.semester, s.year
from course c left join section s
on c.course_number=s.course_num
order by s.instructor desc;
select c.course_name, s.instructor, c.offering_dept
from course c left join section s
on s.course_num=c.course_number;
/* chapter 4 exercise 6 */
select s.instructor, s.course_num, c.course_name, s.semester, s.year
from course c right join section s
on c.course_number=s.course_num
order by s.instructor desc;
select c.course_name, s.instructor, c.offering_dept
from course c right join section s
on s.course_num=c.course_number;

/* Chapter 5 Functions */
/* Row level functions operate on single rows at a time.  There are numeric functions such as ROUND.  There are manipulative functions such as MID.  arithemtic calculations, round, string functions, 
/* Aggregate functions operate on multiple rows at once. There are numeric such as SUM or AVG.  There are manipulative functions such as TOP or DISTINCT.  count, sum, avg, min, max, first, last  */
select count (*) as count
from grade_report; 
select count(grade) as [count of grades]
from grade_report; /* count excludes null values */
select sum(hours)
from employee;
select avg(hours)
from employee; /* null values ignored */
select min(wage), max(wage), avg(wage), avg(hours)
from employee; /* null values ignored */
select first(name)
from employee; /* returns a value from the first row in the result set.  Can't use order by to sort. */
select last(name)
from employee; /* returns a value from the last row in the result set.  Can't use order by to sort. */

select wage, wage+5 as [wage + 5]
from employee; /* if wage field is null, there is no adding 5 */
select name, wage, round((wage/3), 2) as [wage/3 two decimal places]
from employee;
select name, nz(wage,0)*nz(hours,0) as [wage*hours, 0 if null]
from employee; /* nz returns a value if it's null initially.  In this case, if null, update to 0 in results.  nz works for numbers.  Not string */
select name, nz(wage,2)*nz(hours,40) as [wage*hours, 80 if null]
from employee; /* if null, update wage to 2 and hours to 40.  2*40=80 in results */
select abs(-999.99)
as [absolute value];
select top 2 name, wage
from employee
order by wage asc; /* top two employees with lowest wages, top two as in first two rows.  nulls appears first.  No order by means query returns rows based on the order rows appear in table.  All ties are returned in results.  top 
must be immediately after select */
select top 2 name, wage
from employee
order by wage desc; /* top two employees with highest wages, top two as in first two rows.  All ties are returned in results.  top must be immediately after select */
select top 10 percent sname
from student
order by sname asc; /* top ten percent by count of student names.  All ties are returned in results */
select top 10 percent sname
from student; /* top ten percent by number of rows.  All ties are returned in results */
select distinct grade
from grade_report; /* omits records containing duplicate data in selected fields.  Values returned are unique.  distinct must be immediately after select because want distinct rows in results.  Null is included */
/* To count the number of distinct grades, two steps are required.  First, create a temporary table such as temp1.  Second, count the distinct grades from temp1. We're not summing the total grades.  We're not summing the number of grades broken down by A, B, C, D, F, null.  */
select distinct grade into temp1
from grade_report;
select count(grade)
from temp1; /* count ignores null */
select distinctrow prereq, course_number
from prereq; /* omits rows based on entire duplicate records, not just duplicate fields.  distinctrow effects only when you select fields from some, but not all, of the tables used in the query */
select distinctrow *
from prereq;

select name&", Esq." as [Concatenate name field with & inside ""]
from employee;
select ("....."+name) as [Concatenate name field]
from employee;
select (name&".....") as [Concatenate name field]
from employee;
select name, mid(name,2,4) as [mid name start 2, display 4 characters], mid(name,6) as [mid name start 6, display rest]
from employee; /* string counts begin at 1 */
select name, instr(1, name, " ") as [start at 1 position in name return position of blank]
from employee; /* instr or in-string finds the position of what's being searched.  0 is returned if nothing found. */
select name, left(name,3) as [display the first 3 characters in name]
from employee;
select name, right(name,5) as [display the last 5 characters in name]
from employee;
select ltrim("     ranu") as name; /* removes blank space left of ranu */
select rtrim("ranu     ") as name; /* removes blank space right of ranu */
select name, ucase(name) as [name field all upper case]
from employee;
select name, lcase(name) as [name field all lower case]
from employee;
select name, len(name) as [length of name field includes spaces]
from employee; /* if name field defined as char field or text field, len(name) returns 20 because the fixed size was defined as 20 */
select *
from student
where sname like "*Smith*"; /* wildcard wild card like search */
select student_number, grade
from grade_report
where grade like "[c-f]"; /* find a range of characters c, d, e, f grade field in grade_report tablle */
select student_number, grade
from grade_report
where grade like "[!c-f]"; /* find a range of characters not c, d, e, f grade field in grade_report table */
select student_number, grade
from grade_report
where student_number like "[!0-9]"; /* find a character that's not a digit */
select *
from employee
where name like "*b?g*"; /* find records name has b*any one character*g */
select *
from grade_report
where student_number like "13#"; /* find all student numbers beginning with 13 and ending with a single digit */
/* like "x[!c-m]#" find records start with x, second character excludes character between c and m, and third character is a number */

select k5date, year(k5date) as [display year for k5date], name
from datetable;
select k5date, birthdate, year(k5date)-year(birthdate) as [calculate year difference subtraction], name
from datetable;
select birthdate, month(birthdate) as [display month for birthdate], (month(birthdate)+6) as [add six months to month], name
from datetable;
select birthdate, day(birthdate) as [display number day for birthdate], name
from datetable;
select birthdate, weekday(birthdate) as [display day of week for birthdate], name
from datetable; /* 1 is Sunday, 7 is Saturday */
/* the function date() gives the current date.  Can be used to insert values with today's date automatically */
/* the function now() gives the current date and time.  Can be used to insert values with today's date automatically */
/* the function time() gives the current time.  Can be used to insert values with today's time automatically */

/* chapter 5 exercise 1 */
select count(*)
from grade_report;
/* chapter 5 exercise 2 */
/* To count the number of distinct section_id, two steps are required.  First, create a temporary table such as temp2.  Second, count the distinct section_id from temp2. We're not summing the total section_id.  We're not summing the number of section_id broken down by.  */
select distinct section_id into temp2
from grade_report;
select count(section_id)
from temp2;
/* chapter 5 exercise 3 */
select st.sname, g.grade
from section se inner join
(student st inner join grade_report g
on st.stno=g.student_number)
on se.section_id=g.section_id;
select st.sname, g.grade
from section se inner join
(student st inner join grade_report g
on st.stno=g.student_number)
on se.section_id=g.section_id
where g.grade in ("A","B") and se.course_num like"acct*";
/* chapter 5 exercise 4 */
select count(*)
from student
where sname like "*smith*";
/* chapter 5 exercise 5 */
select *
from course
where course_number like "cosc3###";
/* chapter 5 exercise 9 */
select avg(capacity), min(capacity), max(capacity)
from room;
/* chapter 5 exercise 10 */
select sname, mid(sname,(len(sname)/2+1),1), sname&", " &ucase(mid(sname,(len(sname)/2+1),1))&"."
from student;
/* chapter 5 exercise 11 */
select top 50 percent s.sname, g.grade
from student s inner join grade_report g
on s.stno = g.student_number
order by g.grade desc;
select top 25 percent s.sname, g.grade
from student s inner join grade_report g
on s.stno = g.student_number
where s.class = 4 and grade is not null
order by g.grade;
/* chapter 5 exercise 14 */
select *
from student
where len(sname) < 5;
/* chapter 5 exercise 15 */
select *
from student
where stno >= 140 and stno <=149;
/* chapter 5 exercise 16 */
select distinct s.sname
from student s inner join grade_report g
on s.stno = g.student_number
where grade In ("A","B");
/* chapter 5 exercise 18 */
select distinct st.sname, g.grade, st.sname&"*"
from section se inner join
(student st inner join grade_report g
on st.stno=g.student_number)
on se.section_id=g.section_id
where st.class in (3,4) and grade = "A";

/* Chapter 6 Query Development and Derived Structures */
/* Derived structures is a pseudo-table.  In Access SQL, derived structures include real views, inline views, and temporary tables. Derived structures help us build queries on top of other queries.  */
select *
from student
where major = 'cosc';
select *
from student stu, grade_report as g
where stu.major = 'cosc'
and stu.stno = g.student_number;
/* btw, using inner join and on works, too */
/* select *
from student stu inner join grade_report as g
on stu.stno = g.student_number
where stu.major="cosc"; */
select stu.sname, stu.major, g.section_id, g.grade
from student stu, grade_report as g
where stu.major = 'cosc'
and stu.stno = g.student_number;
select stu.sname, stu.major, g.section_id, g.grade
from student stu, grade_report as g
where stu.major = 'cosc'
and stu.stno = g.student_number
and g.grade = "B";
/* The point of this process is user tests as we go verifying the query works and ensures a reasonable result before moving to the next enhanced query */
/* In Access SQL, you can't create a view as a SQL command. */
/*save query as a file namemaj */
select sname, major
from student; /* query saved as namemaj */
select *
from namemaj;
select n.major as [Major], n.sname as [Student Name]
from namemaj n, department_to_major d
where n.major = d.dcode
and d.dname like "comp*";

/* temporary tables */
select s.sname, s.stno, d.dname, s.class into temp3
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2)
and s.major = "cosc"; /* create temporary table temp3 */
select *
from temp3;

/* Step 1 Develop a query step by step */
select s.sname, s.stno, d.dname, s.class
from student s, department_to_major d
where s.major = d.dcode;
select s.sname, s.stno, d.dname, s.class
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2);
select s.sname, s.stno, d.dname, s.class
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2)
and s.major = "cosc";

/* Step 2 Using a Derived Structure option 1 turning your query into a view */
select s.sname, s.stno, d.dname, s.class
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2)
and s.major = "cosc"; /* save query as vustu */
select *
from vustu
where sname like "br*";
/* Step 2 Using a Derived Structure option 2 using an inline view */
select inlinev.["name"], inlinev.["dname"], inlinev.class
from [
select s.sname as "name", s.stno, d.dname as "dname", s.class 
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2)
and s.major = "cosc"]. as inlinev;
/* Step 2 Using a Derived Structure option 3 using a temporary table*/
select s.sname, s.stno, d.dname, s.class into temp4
from student s, department_to_major d
where s.major = d.dcode
and (s.class = 1 or s.class = 2)
and s.major = "cosc";
select *
from temp4;

/* chapter 6 exercise 1 */
select *
from section
where instructor = "hermano";
select *
from section s, grade_report g
where s.section_id = g.section_id
and s.instructor = "hermano"; /*save as query61 */
select s.sname, g.grade
from query61 q, student s
where q.student_number = s.stno
and g.grade In ("A","B");
/* chapter 6 exercise 2 */
create table Stutab (STNO Number, SNAME Text, MAJOR Text, CLASS Number, BDATE Date);
insert into stutab
select *
from student;
select sname, major
from stutab
where class In (3,4);
select sname, major
from stutab
where major = "cosc";
select sname, major
from stutab
where major = "cosc"; /* save view as vstu */
select sname, major into vstutemp
from stutab
where major = "cosc"; /* create temporary table vstutemp */
select sname, major
from vstutemp
where major = "cosc"
order by sname;
select invstu.["name"], invstu.major
from [
select sname as "name", major
from vstutemp]. as invstu;
/* chapter 6 exercise 4 */
select *
from section
where course_num like "cosc*"
order by instructor;
select *
from section
where course_num like "cosc*"
order by instructor; /* save query as query64 convering query into a view */
select inlineview64.instructor, inlineview64.course_num 
from [
select *
from query64]. as inlineview64; /* inline view.  I ignored the column alias. */
select inlineview64.["professor"], inlineview64.course_num 
from [
select instructor as "professor", *
from query64]. as inlineview64; /* inline view.  I created the column alias professor for the instructor column. */

/* Chapter 7 Set Operations */
/* Data can be retried from multiple tables using set operations.  Not all SQL set operations are available in Access.  We look at the IN and NOT IN predicates to work around the explicit set operations. */
/* Three explicit set operations are used in SQL:  union, intersect, and minus.  Access allows union only.  We must use IN and NOT IN to accomplish the same result using intersect and minus. */
/* Union compatibility means both sets have to match in the number of items and compatible data types. */
/* Union removes duplicates in the results */

select sname
from student
where major = "cosc"
union
select sname
from student
where major = "math";
select sname
from student
where major = "cosc"
union all
select sname
from student
where major = "math"; /* includes duplicates */
select c.*, null
from course c
where c.credit_hours = 4
union all
select null, p.course_number, null, null, p.prereq
from prereq p /* use null values in some of the field places a place holders to run union or union all unequal number of fields.  course table fields: course_name, course_number, credit_hours, offering_dept.  prereq table fields: course_number,  prereq.  query fields: course_name, course_number, credit_hours, offering_dept, Expr1001 which is prereq.  In some SQL versions, UNION JOIN is run. */

select sname, class
from student
where class in (3,4);
select sname, class
from student
where class = 3 or class =4;
select sname, class
from student
where class not in (2);
select sname, major
from student
where major not in ("cosc","math");
/* In union, all rows in the resulting tables or sets be unioned must be compatible.  Join only the fields or rows of the table being joined have to be compatible.  The other fields may be different. */
/* In union, no new columns can be added to the final result.  Join new columns can be added to the final result.
/* In union, the number of columns in the result set has be to the same as the number of columns in the sets being unioned.  Join number of oclumns in the result set may vary. */

/* Chapter 8 Joins versus Subqueries */
select st.stno, st.sname
from student st
where stno in (select gr.student_number
    from grade_report gr
    where gr.grade="A" or gr.grade="B")
order by st.stno; /* find students with A or B in student and grade_report tables SQL subquery.  student numbers are the joins.  31 rows. */
select st.sname
from student st, grade_report gr
where st.stno = gr.student_number
and (gr.grade="A" or gr.grade="B");  /* find students with A or B in student and grade_report tables SQL join.  student numbers are the joins.  67 rows because there are duplicates */
/*which is more efficient?  Join or subquery?  Depends on which SQL you're using.  To get results without duplicates using join, use distinct below. */
select distinct st.sname
from student st, grade_report gr
where st.stno = gr.student_number
and (gr.grade="A" or gr.grade="B");
select st.stno, st.sname, gr.grade, gr.section_id
from student st, grade_report gr
where st.stno = gr.student_number
and (gr.grade="A" or gr.grade="B"); /* duplicates are okay in SQL join query because we list all A's and B's and each student's classes earning A's and B's */
select distinct st.sname, gr.grade
from student st, grade_report gr
where st.stno = gr.student_number
and (gr.grade="A" or gr.grade="B"); /* want list of students who earn A, B, and A and B.  Use SQL join query and distinct.  We don't need to see a student earning multiple A's and/or multiple B's grades. */
select d2m.dname
from department_to_major d2m
where d2m.dcode in (select course.offering_dept
    from course
    where course.course_name like "*intro*"); /* find deparments offering classes with "intro" in the title.  d2m.dcode and course.offering_dept are the links between department_to_major table and course table */
select s.sname, s.major, g.section_id
from Student s, grade_report g
where g.student_number = s.stno
and g.grade = "C"
and g.section_id in (select t.section_id
    from section t
    where t.instructor like "hermano"); /* find students earned C's taught by professor hermano.  grade report table section_id and section table section_id are the link */

select *
from room
where capacity = 25;
select *
from room
where capacity < (select avg(capacity)
	from room);
select *
from room
where capacity < (select avg(capacity)
	from room
	where bldg = 99); /* Using subqueries in this fashion the subquery must return one row.  Where operators are used, only single values are acceptable from the subquery. */

/* Chapter 9 Aggregation and GROUP BY */
/* An aggregate function is one that extracts information by operating on multiple rows such as count, average, minimum, or maximum. */
/* group by is a must when aggregation */
select class, count(*) as [count]
from student
group by class; /* count the number of class groups */
select class, major, count(*) as [count by class then major]
from student
group by class, major;  /* count all students by class and by major like a pivot table. */
select class, major, count(*) as [count by class then major]
from student
group by class, major
order by count(*) desc, class;
/* distinct unnecessary because group by clause groups rows for which the column(s) that are grouped don't have duplicate values */
/* Having clause is a final filter on the output of a select statement.  It's like a pivot table filter. */
select class, count(*) as [count]
from student
group by class
having count(*) > 9;
select class, major, count(*) as [count by class then major cosc majors 2 or greater]
from student
where major = "cosc"
group by class, major
having count(*) > 2;

select min(count(stno))
from student;
group by class; /*error message appears in SQL in Access.  Min function is an aggregate function.  Aggregate functions operate on tables that contain rows.  There are no rows.  SQL in Access can't handle a mismatch of aggretation and grouping.  SQL in Access create temporary tables, inline views, or regular views.  Best use a temporary table or an inline view */
select count(stno) as [temporary table count of students]
from student
group by class;
select count(stno) as [temporary table temp91 count of students] into temp91
from student
group by class;
select min([temporary table temp91 count of students])
from temp91;
select count(stno) as [count of stno], class
from student
group by class
having count(stno) = (select min([temporary table temp91 count of students]) as [minimum count]
    from temp91); /* use temporary table temp91 to find the class with the minimum or lowest count students */
select min(c) as [minimum students inline view]
from (select count(stno) as [c]
from student
group by class);
select class, count(*) as [write query in subquery with having clause]
from student
group by class
having count(*) =
    (select min(c) as [minimum students inline view]
    from (select count(stno) as [c]
    from student
    group by class));

/* Nulls are never equal, less than, greater than, or not equal to any value.  Aggregates by themselves on columns containing nulls ignore null values.  */
select count(*) as [count], avg(salary) as [average], sum(salary) as [sum], max(salary) as [max], min(salary) as [min]
from sal;
select count(name) as [count all four names]
from sal;  /* four of the four rows contains a name.  count(name) returns 4 */
select count(salary) as [count all three salary]
from sal; /* three of the four rows contains a salary.  count(salary) returns 3 */
select name, nz(salary,0) as [salary is zero when null]
from sal;
select count(nz(salary,0)) as [count salary including zero salary; salary is zero when null]
from sal;
select avg(nz(salary,0)) as [average salary including zero salary; salary is zero when null]
from sal;

/* Chapter 10 Correlated Subqueries skipped */

/* Chapter 11 Indexes and Constraints on Tables */
/* Indexes and contraints can be added to tables to make tables more efficient and to increase data integrity.  Index speeds up queries and searches and facilitates sorting and grouping operations; however indexes slows down updates on indexed fields.  A constraint is similar to an index, but a constraint can also be used to establish relationships with other tables. */
create table test1 (name varchar(20), ssn char(9), dept_number integer, acct_balance currency);
create index ssn_ndx
on test1 (ssn desc); /* create index called ssn_ndx on ssn in descending order */
create unique index ssn_ndx1
on test1 (ssn desc); /* create index called ssn_ndx on ssn in descending order no duplicates.  The unique options can be used on fields no duplicates allowed even thought it's not a primary key. */
create index ssn_ndx2
on test1 (ssn desc) with primary; /* make ssn the primary key of test1 */
create index ssn_ndx3
on test1 (name) with disallow null; /* disallow null in name field */
/* Click on the Access Indexes button to view all the indexes created.  Design-->Indexes. */
drop index ssn_ndx1
on test1; /* delete an index */

/* constraints can be added to tables for more integrity. */
create table test2 (name varchar(20), ssn char(9), dept_number integer not null, acct_balance currency); /* dept_number attribute has a not null constraint.  dept_number can't be null */
alter table test2
alter column dept_number integer not null; /* if test2 dept_number wasn't null, we can alter table or edit table for dept_number to be not null.  Column type and size must be included. */
create table xxx (ssn char(9) constraint ssn_pk primary key, name varchar(20)); /* primary key constraint added to create table new table.  ssn_pk is the name of the primary key constraint for ssn.  */
alter table test2
add constraint ssn_pk primary key (ssn); /*add a primary key after create table.  Use alter table */
create table xxx2 (ssn char(9), salary number, constraint ssn_pk primary key (ssn, salary)); /* two primary key concatenated primary key concatenate primary key multiple primary key */
create table xxx3 (ssn char(9), salary number);
alter table xxx3
add constraint ssn_salary_pk primary key (ssn, salary); /* create table xx3, then alter table adding ssn and salary primary keys */

/* unique constraint.  Unique can have null values.  More than one column can be unique. */
create table emp (empno number, name varchar(20), title varchar(20), constraint empno_pk primary key(empno), constraint title_uk unique (title)); /* employee number empno field empno_pk constraint name is the primary key.  title title field title_uk constraint name is unique */

/* delete constraint remove constraint */
alter table xxx3
drop constraint ssn_salary_pk;

/* to enable a referential integrity constraint for two interrelated tables.  We can enforce a referential integrity constraint.  A foreign key and primary key constraint.  A row in one table foreign key can't exist if a value in the table referring to a value in another table primary key doesn't exist. */
create table department (deptno number, deptname varchar(20), constraint deptno_pk primary key (deptno));
create table employee2 (empno number constraint empno_pk primary key, empname varchar(20), dept number constraint dept_fk references department(deptno)); /* dept column is a foreign key references department table.  deptno is reference to table department which must be a primary key in department table */
alter table xxx4
add constraint dept_fk foreign key (dept) references department(deptno); /* the foreign key constraint can be added after tables are created.  The primary key table must be created before the alter table. */