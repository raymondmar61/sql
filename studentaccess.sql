--insert tables and data
create table cap (name varchar2(20), langu varchar2(20));
insert into cap values ('Brenda','Chinese');
insert into cap values ('Brenda','French');
insert into cap values ('Brenda','Spanish');
insert into cap values ('Joe','Chinese');
insert into cap values ('Kent','Chinese');
insert into cap values ('Lujack','Chinese');
insert into cap values ('Lujack','French');
insert into cap values ('Lujack','German');
insert into cap values ('Lujack','Spanish');
insert into cap values ('Mary Jo','Chinese');
insert into cap values ('Mary Jo','French');
insert into cap values ('Mary Jo','German');
insert into cap values ('Melanie','Chinese');
insert into cap values ('Melanie','French');
insert into cap values ('Richard','Chinese');
insert into cap values ('Richard','French');
insert into cap values ('Richard','German');
insert into cap values ('Richard','Spanish');
create table course (course_name varchar2(50),course_number varchar2(10),credit_hours integer, offering_dept varchar2(4));
insert into course values ('ACCOUNTING I','ACCT2020',3,'ACCT');
insert into course values ('ACCOUNTING II','ACCT2220',3,'ACCT');
insert into course values ('MANAGERIAL FINANCE','ACCT3333',3,'ACCT');
insert into course values ('ACCOUNTING INFO SYST','ACCT3464',3,'ACCT');
insert into course values ('INTRO TO CHEMISTRY','CHEM2001',3,'CHEM');
insert into course values ('ORGANIC CHEMISTRY','CHEM3001',3,'CHEM');
insert into course values ('INTRO TO COMPUTER SC','COSC1310',4,'COSC');
insert into course values ('TURBO PASCAL','COSC2025',3,'COSC');
insert into course values ('ADVANCED COBOL','COSC2303',3,'COSC');
insert into course values ('DATA STRUCTURES','COSC3320',4,'COSC');
insert into course values ('DATABASE','COSC3380',3,'COSC');
insert into course values ('OPERATIONS RESEARCH','COSC3701',3,'COSC');
insert into course values ('ADVANCED ASSEMBLER','COSC4301',3,'COSC');
insert into course values ('SYSTEM PROJECT','COSC4309',3,'COSC');
insert into course values ('ADA - INTRODUCTION','COSC5234',4,'COSC');
insert into course values ('NETWORKS','COSC5920',3,'COSC');
insert into course values ('ENGLISH COMP I','ENGL1010',3,'ENGL');
insert into course values ('ENGLISH COMP II','ENGL1011',3,'ENGL');
insert into course values ('FUND. TECH. WRITING','ENGL3401',3,'ENGL');
insert into course values ('TECHNICAL WRITING','ENGL3402',2,'ENGL');
insert into course values ('WRITING FOR NON MAJO','ENGL3520',2,'ENGL');
insert into course values ('CALCULUS 1','MATH1501',4,'MATH');
insert into course values ('CALCULUS 2','MATH1502',3,'MATH');
insert into course values ('CALCULUS 3','MATH1503',3,'MATH');
insert into course values ('ALGEBRA','MATH2333',3,'MATH');
insert into course values ('DISCRETE MATHEMATICS','MATH2410',3,'MATH');
insert into course values ('MATH ANALYSIS','MATH5501',3,'MATH');
insert into course values ('AMERICAN CONSTITUTIO','POLY1201',1,'POLY');
insert into course values ('INTRO TO POLITICAL S','POLY2001',3,'POLY');
insert into course values ('AMERICAN GOVERNMENT','POLY2103',2,'POLY');
insert into course values ('SOCIALISM AND COMMUN','POLY4103',4,'POLY');
insert into course values ('POLITICS OF CUBA','POLY5501',4,'POLY');
create table department_to_major (dcode varchar2(4), dname varchar2(20));
insert into department_to_major values ('ACCT','Accounting');
insert into department_to_major values ('ART','Art');
insert into department_to_major values ('CHEM','Chemistry');
insert into department_to_major values ('COSC','Computer Science');
insert into department_to_major values ('ENGL','English');
insert into department_to_major values ('MATH','Mathematics');
insert into department_to_major values ('POLY','Political Science');
insert into department_to_major values ('UNKN','');  --null is denoted with blank ''
create table grade_report (student_number integer, section_id float, grade varchar2(1));
insert into grade_report values ('2',85,'D');
insert into grade_report values ('2',102,'B');
insert into grade_report values ('2',126,'B');
insert into grade_report values ('2',127,'A');
insert into grade_report values ('2',145,'B');
insert into grade_report values ('3',85,'A');
insert into grade_report values ('3',87,'B');
insert into grade_report values ('3',90,'B');
insert into grade_report values ('3',91,'B');
insert into grade_report values ('3',92,'B');
insert into grade_report values ('3',96,'B');
insert into grade_report values ('3',101,'');
insert into grade_report values ('3',133,'');
insert into grade_report values ('3',134,'');
insert into grade_report values ('3',135,'');
insert into grade_report values ('5',90,'C');
insert into grade_report values ('5',94,'C');
insert into grade_report values ('5',95,'B');
insert into grade_report values ('6',94,'C');
insert into grade_report values ('6',95,'B');
insert into grade_report values ('6',201,'');
insert into grade_report values ('7',90,'C');
insert into grade_report values ('7',94,'C');
insert into grade_report values ('7',95,'B');
insert into grade_report values ('8',85,'A');
insert into grade_report values ('8',92,'A');
insert into grade_report values ('8',94,'C');
insert into grade_report values ('8',95,'B');
insert into grade_report values ('8',96,'C');
insert into grade_report values ('8',102,'B');
insert into grade_report values ('8',133,'');
insert into grade_report values ('8',134,'');
insert into grade_report values ('8',135,'');
insert into grade_report values ('8',201,'');
insert into grade_report values ('9',90,'F');
insert into grade_report values ('9',94,'F');
insert into grade_report values ('9',95,'F');
insert into grade_report values ('10',101,'');
insert into grade_report values ('10',112,'');
insert into grade_report values ('10',119,'');
insert into grade_report values ('10',126,'C');
insert into grade_report values ('10',127,'A');
insert into grade_report values ('10',145,'C');
insert into grade_report values ('13',85,'B');
insert into grade_report values ('13',95,'B');
insert into grade_report values ('13',99,'');
insert into grade_report values ('13',109,'');
insert into grade_report values ('13',119,'');
insert into grade_report values ('13',133,'');
insert into grade_report values ('13',134,'');
insert into grade_report values ('13',135,'');
insert into grade_report values ('14',91,'A');
insert into grade_report values ('14',102,'B');
insert into grade_report values ('14',112,'');
insert into grade_report values ('14',135,'');
insert into grade_report values ('14',145,'B');
insert into grade_report values ('14',158,'B');
insert into grade_report values ('15',85,'F');
insert into grade_report values ('15',92,'B');
insert into grade_report values ('15',99,'');
insert into grade_report values ('15',102,'B');
insert into grade_report values ('15',135,'');
insert into grade_report values ('15',145,'B');
insert into grade_report values ('15',158,'C');
insert into grade_report values ('17',112,'');
insert into grade_report values ('17',119,'');
insert into grade_report values ('17',135,'');
insert into grade_report values ('19',102,'B');
insert into grade_report values ('19',119,'');
insert into grade_report values ('19',133,'');
insert into grade_report values ('19',158,'D');
insert into grade_report values ('20',87,'A');
insert into grade_report values ('20',94,'C');
insert into grade_report values ('24',90,'B');
insert into grade_report values ('24',95,'B');
insert into grade_report values ('24',96,'B');
insert into grade_report values ('24',97,'');
insert into grade_report values ('24',98,'');
insert into grade_report values ('24',99,'');
insert into grade_report values ('24',100,'');
insert into grade_report values ('31',90,'C');
insert into grade_report values ('34',90,'B');
insert into grade_report values ('34',93,'A');
insert into grade_report values ('34',97,'');
insert into grade_report values ('34',98,'');
insert into grade_report values ('49',90,'C');
insert into grade_report values ('49',93,'A');
insert into grade_report values ('49',94,'C');
insert into grade_report values ('49',97,'');
insert into grade_report values ('49',98,'');
insert into grade_report values ('62',90,'C');
insert into grade_report values ('62',94,'C');
insert into grade_report values ('70',90,'C');
insert into grade_report values ('70',94,'C');
insert into grade_report values ('121',90,'B');
insert into grade_report values ('121',94,'B');
insert into grade_report values ('121',95,'B');
insert into grade_report values ('122',90,'B');
insert into grade_report values ('122',94,'B');
insert into grade_report values ('122',95,'B');
insert into grade_report values ('123',90,'B');
insert into grade_report values ('123',93,'A');
insert into grade_report values ('123',94,'B');
insert into grade_report values ('123',95,'B');
insert into grade_report values ('123',97,'');
insert into grade_report values ('123',98,'');
insert into grade_report values ('125',90,'C');
insert into grade_report values ('125',93,'A');
insert into grade_report values ('125',94,'C');
insert into grade_report values ('125',95,'B');
insert into grade_report values ('125',97,'');
insert into grade_report values ('125',98,'');
insert into grade_report values ('126',90,'C');
insert into grade_report values ('126',93,'A');
insert into grade_report values ('126',94,'C');
insert into grade_report values ('126',95,'B');
insert into grade_report values ('126',97,'');
insert into grade_report values ('126',98,'');
insert into grade_report values ('127',90,'C');
insert into grade_report values ('127',93,'A');
insert into grade_report values ('127',94,'C');
insert into grade_report values ('127',95,'B');
insert into grade_report values ('127',97,'');
insert into grade_report values ('127',98,'');
insert into grade_report values ('128',90,'F');
insert into grade_report values ('128',94,'F');
insert into grade_report values ('128',95,'F');
insert into grade_report values ('129',90,'A');
insert into grade_report values ('129',94,'A');
insert into grade_report values ('129',95,'B');
insert into grade_report values ('130',90,'C');
insert into grade_report values ('130',94,'C');
insert into grade_report values ('130',95,'C');
insert into grade_report values ('131',90,'C');
insert into grade_report values ('132',90,'B');
insert into grade_report values ('142',88,'');
insert into grade_report values ('142',89,'A');
insert into grade_report values ('142',90,'A');
insert into grade_report values ('142',100,'');
insert into grade_report values ('142',107,'');
insert into grade_report values ('142',202,'');
insert into grade_report values ('143',88,'');
insert into grade_report values ('143',89,'B');
insert into grade_report values ('143',90,'B');
insert into grade_report values ('143',100,'');
insert into grade_report values ('143',107,'');
insert into grade_report values ('143',202,'');
insert into grade_report values ('144',88,'');
insert into grade_report values ('144',89,'B');
insert into grade_report values ('144',90,'B');
insert into grade_report values ('144',100,'');
insert into grade_report values ('144',107,'');
insert into grade_report values ('144',202,'');
insert into grade_report values ('145',88,'');
insert into grade_report values ('145',89,'F');
insert into grade_report values ('145',90,'F');
insert into grade_report values ('145',100,'');
insert into grade_report values ('145',107,'');
insert into grade_report values ('145',202,'');
insert into grade_report values ('146',88,'');
insert into grade_report values ('146',89,'B');
insert into grade_report values ('146',90,'B');
insert into grade_report values ('146',100,'');
insert into grade_report values ('146',107,'');
insert into grade_report values ('146',202,'');
insert into grade_report values ('147',88,'');
insert into grade_report values ('147',89,'B');
insert into grade_report values ('147',90,'C');
insert into grade_report values ('147',100,'');
insert into grade_report values ('147',107,'');
insert into grade_report values ('147',202,'');
insert into grade_report values ('148',88,'');
insert into grade_report values ('148',89,'B');
insert into grade_report values ('148',90,'C');
insert into grade_report values ('148',100,'');
insert into grade_report values ('148',107,'');
insert into grade_report values ('148',202,'');
insert into grade_report values ('151',90,'C');
insert into grade_report values ('151',97,'');
insert into grade_report values ('151',109,'');
insert into grade_report values ('151',201,'');
insert into grade_report values ('153',90,'C');
insert into grade_report values ('153',97,'');
insert into grade_report values ('153',109,'');
insert into grade_report values ('153',201,'');
insert into grade_report values ('155',90,'B');
insert into grade_report values ('155',97,'');
insert into grade_report values ('155',109,'');
insert into grade_report values ('155',201,'');
insert into grade_report values ('157',90,'B');
insert into grade_report values ('157',97,'');
insert into grade_report values ('157',109,'');
insert into grade_report values ('157',201,'');
insert into grade_report values ('158',90,'C');
insert into grade_report values ('158',97,'');
insert into grade_report values ('158',109,'');
insert into grade_report values ('158',201,'');
insert into grade_report values ('160',90,'C');
insert into grade_report values ('160',97,'');
insert into grade_report values ('160',109,'');
insert into grade_report values ('160',201,'');
insert into grade_report values ('161',90,'C');
insert into grade_report values ('161',97,'');
insert into grade_report values ('161',109,'');
insert into grade_report values ('161',201,'');
insert into grade_report values ('163',90,'C');
insert into grade_report values ('163',97,'');
insert into grade_report values ('163',109,'');
insert into grade_report values ('163',201,'');
alter table grade_report modify section_id integer;  --modify column or edit column.  ORA-01440: column to be modified must be empty to decrease precision or scale
delete from grade_report;  --delete data only
create table prereq (course_number varchar2(8), prereq varchar2(8));
insert into prereq values ('ACCT3333','ACCT2220');
insert into prereq values ('CHEM3001','CHEM2001');
insert into prereq values ('COSC3320','COSC1310');
insert into prereq values ('COSC3380','COSC3320');
insert into prereq values ('COSC3380','MATH2410');
insert into prereq values ('COSC5234','COSC3320');
insert into prereq values ('ENGL1011','ENGL1010');
insert into prereq values ('ENGL3401','ENGL1011');
insert into prereq values ('ENGL3520','ENGL1011');
insert into prereq values ('MATH5501','MATH2333');
insert into prereq values ('POLY2103','POLY1201');
insert into prereq values ('POLY5501','POLY4103');
create table section (section_id integer, course_num varchar2(8), semester varchar2(7), year integer, instructor varchar2(30), bldg integer, room integer);
insert into section values (85,'MATH2410','FALL',98,'KING',36,123);
insert into section values (86,'MATH5501','FALL',98,'EMERSON',36,123);
insert into section values (87,'ENGL3401','FALL',98,'HILLARY',13,101);
insert into section values (88,'ENGL3520','FALL',99,'HILLARY',13,101);
insert into section values (89,'ENGL3520','SPRING',99,'HILLARY',13,101);
insert into section values (90,'COSC3380','SPRING',99,'HARDESTY',79,179);
insert into section values (91,'COSC3701','FALL',98,'',79,179);
insert into section values (92,'COSC1310','FALL',98,'ANDERSON',79,179);
insert into section values (93,'COSC1310','SPRING',99,'RAFAELT',79,179);
insert into section values (94,'ACCT3464','FALL',98,'RODRIGUEZ',74,'');
insert into section values (95,'ACCT2220','SPRING',99,'RODRIQUEZ',74,'');  --null number field two single quotes denote null number is valid
insert into section values (96,'COSC2025','FALL',98,'RAFAELT',79,179);
insert into section values (97,'ACCT3333','FALL',99,'RODRIQUEZ',74,'');
insert into section values (98,'COSC3380','FALL',99,'HARDESTY',79,179);
insert into section values (99,'ENGL3401','FALL',99,'HILLARY',13,101);
insert into section values (100,'POLY1201','FALL',99,'SCHMIDT','','');  --null number field two single quotes denote null number is valid
insert into section values (101,'POLY2103','SPRING',00,'SCHMIDT','','');  --null number field two single quotes denote null number is valid
insert into section values (102,'COSC3320','SPRING',99,'KNUTH',79,179);
insert into section values (104,'POLY4103','SPRING',00,'SCHMIDT','','');  --null number field two single quotes denote null number is valid
insert into section values (107,'MATH2333','SPRING',00,'CHANG',36,123);
insert into section values (109,'MATH5501','FALL',99,'CHANG',36,123);
insert into section values (112,'MATH2410','FALL',99,'CHANG',36,123);
insert into section values (119,'COSC1310','FALL',99,'ANDERSON',79,179);
insert into section values (126,'ENGL1010','FALL',98,'HERMANO',13,101);
insert into section values (127,'ENGL1011','SPRING',99,'SPRING',13,101);
insert into section values (133,'ENGL1010','FALL',99,'HERMANO',13,101);
insert into section values (134,'ENGL1011','SPRING',00,'HERMANO',13,101);
insert into section values (135,'COSC3380','FALL',99,'STONE',79,179);
insert into section values (145,'COSC1310','SPRING',99,'JONES',79,179);
insert into section values (158,'MATH2410','SPRING',98,'',36,123);
insert into section values (201,'CHEM2001','FALL',99,'',58,114);
insert into section values (202,'CHEM3001','SPRING',00,'CARNEAU',58,'');  --null number field two single quotes denote null number is valid
create table student (stno integer, sname varchar2(20), major varchar2(4), class integer, bdate date);
insert into student values (2,'Lineas','ENGL',1,'04/15/1980');
insert into student values (3,'Mary','COSC',4,'07/06/1978');
insert into student values (5,'Zelda','COSC','','02/12/1978');
insert into student values (6,'Ken','POLY','','07/15/1980');
insert into student values (7,'Mario','MATH','','08/12/1980');
insert into student values (8,'Brenda','COSC',2,'08/13/1977');
insert into student values (9,'Romona','ENGL','','04/15/1980');
insert into student values (10,'Richard','ENGL',1,'05/13/1980');
insert into student values (13,'Kelly','MATH',4,'08/12/1980');
insert into student values (14,'Lujack','COSC',1,'02/12/1977');
insert into student values (15,'Reva','MATH',2,'06/10/1980');
insert into student values (17,'Elainie','COSC',1,'08/12/1976');
insert into student values (19,'Harley','POLY',2,'04/16/1981');
insert into student values (20,'Donald','ACCT',4,'10/15/1977');
insert into student values (24,'Chris','ACCT',4,'02/12/1978');
insert into student values (31,'Jake','COSC',4,'02/12/1978');
insert into student values (34,'Lynette','POLY',1,'07/16/1981');
insert into student values (49,'Susan','ENGL',3,'03/11/1980');
insert into student values (62,'Monica','MATH',3,'10/14/1980');
insert into student values (70,'Bill','POLY','','10/14/1980');
insert into student values (88,'Smith','','','10/15/1979');
insert into student values (121,'Hillary','COSC',1,'07/16/1977');
insert into student values (122,'Phoebe','ENGL',3,'04/15/1980');
insert into student values (123,'Holly','POLY',4,'01/15/1981');
insert into student values (125,'Sadie','MATH',2,'08/12/1980');
insert into student values (126,'Jessica','POLY',2,'07/16/1981');
insert into student values (127,'Steve','ENGL',1,'03/11/1980');
insert into student values (128,'Brad','COSC',1,'09/10/1977');
insert into student values (129,'Cedric','ENGL',2,'04/15/1980');
insert into student values (130,'Alan','COSC',2,'07/16/1977');
insert into student values (131,'Rachel','ENGL',3,'04/15/1980');
insert into student values (132,'George','POLY',1,'04/16/1981');
insert into student values (142,'Jerry','COSC',4,'03/12/1978');
insert into student values (143,'Cramer','ENGL',3,'04/15/1980');
insert into student values (144,'Fraiser','POLY',1,'07/16/1981');
insert into student values (145,'Harrison','ACCT',4,'02/12/1977');
insert into student values (146,'Francis','ACCT',4,'06/11/1977');
insert into student values (147,'Smithly','ENGL',2,'05/13/1980');
insert into student values (148,'Sebastian','ACCT',2,'10/14/1976');
insert into student values (151,'Losmith','CHEM',3,'01/15/1981');
insert into student values (153,'Genevieve','UNKN','','10/15/1979');
insert into student values (155,'Lindsay','UNKN',1,'10/15/1979');
insert into student values (157,'Stephanie','MATH','','04/16/1981');
insert into student values (158,'Thornton','','','10/15/1979');
insert into student values (160,'Gus','ART',3,'10/15/1978');
insert into student values (161,'Benny','CHEM',4,'06/10/1980');
insert into student values (163,'Lionel','','','10/15/1979');
insert into student values (191,'Jake','MATH',2,'06/10/1980');
create table room (bldg integer, room integer, capacity integer, ohead varchar2(1));
insert into room values (13,101,85,'Y');
insert into room values (36,120,25,'N');
insert into room values (36,121,25,'N');
insert into room values (36,122,25,'N');
insert into room values (36,123,35,'N');
insert into room values (58,110,'','Y');
insert into room values (58,112,40,'');
insert into room values (58,114,60,'');
insert into room values (79,174,22,'N');
insert into room values (79,179,35,'Y');

--review from learningsql.sql
select *
from student
where class between 1 and 4
order by class asc, sname;
select *
from student
where (class = 1 and (major = 'ACCT' or major = 'COSC')) or (class = 3 and (major = 'ACCT' or major = 'COSC'));
select sname, class, bdate
from student
where bdate between '1/1/1980' and '7/1/1981'  --date use single quotes
order by 3 asc, sname;
select sname, class
from student
where class is null;
select s.sname
from student s
where s.class = 4;  --table alias
select g.student_number, g.grade
from grade_report g
where g.grade = 'C' or g.grade = 'D';
select bldg
from room;
select distinct(bldg)
from room;
select count(bldg)
from room;
select count(distinct((bldg)))
from room;

--start chapter 3 line 96 learningsql.sql 03/06/18
create table employees (name varchar2(20), address varchar2(20), employee_number integer, salary number(8,2));
--number(p,s) is number(precision or total number of digits 1-38, scale number of digits to the right of the deciaml place out of total number of digits). e.g. number(5,2) is -999.99 to 999.99 inclusive.  1,000 is rejected.  80.999 is rounded up to 81.00.
create table employees (name varchar2(20), address varchar2(20), employee_number integer, salary float(8,2));  --Oracle 12C doesn't like float(,)
insert into employees values ('Joe Smith', '123 4th St.', 101, 2500.49);
insert into employees values ('R Mar','202122 23rd St.', null, 100000.01);
insert into employees (name, address, salary)
values ('R Mar','789 10th St.',500000.39);
insert into employees values ('B Posey','2323 Willie Mays Pl',23,null);
insert into employees values ('     MadBum','2323 Willie Mays Pl',40,null);
insert into employees values ('HPence   right  ','2323 Willie Mays Pl',9,null);
insert into employees(name, employee_number)
select sname, stno
from student
where stno > 100;  
insert into emp2
select *
from emp1
where employee_number >= 100; --if employees table and student table columns match left to right both tables, then no need to mention column names.
update employees
set salary = employee_number+500;
delete from employees;  --delete data delete rows
drop table employees;  --delete table
--start chapter 3 line 136 learningsql.sql 03/08/18
alter table employees
add major varchar2(40);  --add column
alter table employees
modify major varchar2(4);  --edit column varchar2(40) to varchar2(4)
alter table employees
drop column major;  --delete column
delete from employees
where name = 'R Mar' and address = '202122 23rd St.';  --delete rows with criteria
--start chapter 4 line 205 learningsql.sql 03/08/18
select *
from course inner join prereq
on course.course_number = prereq.course_number;
--same as
select *
from course, prereq
where course.course_number=prereq.course_number;
select c.course_name, c.course_number, c.credit_hours, c.offering_dept, p.prereq
from course c inner join prereq p
on c.course_number = p.course_number;
select c.course_name, c.course_number, d2m.dname
from department_to_major d2m inner join
	(course c inner join prereq p
	on c.course_number=p.course_number)
on c.offering_dept=d2m.dcode;  --join multiple tables using nested inner join or multiple inner join
select c.course_name, c.course_number, d.dname
from course c, prereq p, department_to_major d
where c.course_number=p.course_number and c.offering_dept=d.dcode;  --join multiple tables using from
select *
from course left join prereq
on course.course_number=prereq.course_number;
--same as 
select *
from course left outer join prereq
on course.course_number=prereq.course_number;
/* It seems the outer in left outer join and right outer join is optional */
select count(*) as "count excludes null values"
from grade_report;
select sum(salary), min(salary), max(salary), avg(salary)
from employees;
select name, salary, round((salary/3), 4) as "salary/3 four decimal places"
from employees;
select name, salary, nvl(salary,0) as "if salary null then 0"
from employees;
/*
select name, nz(wage,2)*nz(hours,40) as [wage*hours, 80 if null]
from employee; /* if null, update wage to 2 and hours to 40.  2*40=80 in results */
-- RANK() leaves a gap in the sequence when there is a tie, but DENSE_RANK() leaves no gaps.
select salary, rank() over (order by salary desc)
from employees
where salary is not null;
select salary, rank() over (order by salary desc nulls last)
from employees;  --if null rows, then they're rank at bottom.
select name, salary
from employees;
select name || ', Esq.' as "Concatenate field with ||"
from employees;
select '.....' || name as "Concatenate name field"  --.....Joe Smith
from employees;
select sname, substr(sname,2,4) as "start 2nd return 4 characters"
from student;  --substring.  Extract middle string or part of string.
select sname, substr(sname,-4) as "start end return 4 characters"
from student;  --like right() in Excel
select sname, instr(sname,'e') as "position # for e"
from student;
select name, substr(name,instr(name,' ')+1,length(name))
from employees;  --extract string after first space or print last name
select name, ltrim(name), rtrim(name), trim(name)
from employees;
select name, upper(name), lower(name), length(name)
from employees;  --upper case and lower case and length of name or len of name; string length
--start Chapter 5 line 392 03/12/18