create table student (studentid int primary key auto_increment, name varchar(20) not null, major varchar(20) default 'Undecided'); #highlight the database giraffe to insert a table.  Changed default comments from double hyphens to number sign.
create table student (studentid int, name varchar(20) not null, major varchar(20) default 'Undecided', primary key(studentid)); #identify primary key after all columns defined also works
describe student; #returns the student table information
drop table student; #delete table
alter table student add gpa decimal(3,2);
alter table student drop column gpa;
insert into student values(1,'Jack','Biology'); #single quotations
#Auto-Commit Transactions checked Query-->Auto-Commit Transactions
insert into student values(2,'Kate','Sociology');
insert into student (name, studentid) values('Claire',3);
update student set major = 'Chemistry' where studentid = 3;
insert into student (name, studentid, major) values('Jack',4,'Biology');
insert into student values(5,'Mike','Computer Science');
insert into student (name, major) values('Raymond','Economics'); #studentid is 6 automatically inserted because of auto_increment
select * from student;
/*
studentid, name, major
'1', 'Jack', 'Biology'
'2', 'Kate', 'Sociology'
'3', 'Claire', 'Chemistry'
'4', 'Jack', 'Biology'
'5', 'Mike', 'Computer Science'
'6', 'Raymond', 'Economics'
*/
select * from student;
update student set major = 'Bio' where major = 'Biology' and studentid > 0; #https://stackoverflow.com/questions/63195125/mysql-error-code-1175-you-are-using-safe-update-mode-even-with-primary-key
/*
https://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench
SET SQL_SAFE_UPDATES = 0;

# your code SQL here

SET SQL_SAFE_UPDATES = 1;
*/
SET SQL_SAFE_UPDATES = 0;
update student set major = 'Bio' where major = 'Biology';
delete from student; #delete all rows
delete from student where studentid = 6; #delete row or delete record.  RM:  I insert insert into student (name, major) values('Raymond','Economics'); afterwards.  The studentid is 7 instead of 6.

select * from student;
/*
studentid, name, major
'1', 'Jack', 'Biology'
'2', 'Kate', 'Sociology'
'3', 'Claire', 'Chemistry'
'4', 'Jack', 'Biology'
'5', 'Mike', 'Computer Science'
'6', 'Raymond', 'Economics'
*/
select name, major
from student
where studentid > 2 or major = 'Chemistry'
order by name desc
limit 3;
/*
# name, major
'Raymond', 'Economics'
'Mike', 'Computer Science'
'Jack', 'Biology'
*/
select *
from student
where name in ('Claire','Kate','Mike');
/*
# studentid, name, major
'2', 'Kate', 'Sociology'
'3', 'Claire', 'Chemistry'
'5', 'Mike', 'Computer Science'
*/