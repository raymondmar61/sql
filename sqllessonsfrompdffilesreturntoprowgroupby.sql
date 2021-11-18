#How to Select the First Row in Each GROUP BY Group _ LearnSQL.com.pdf
#sql - Select first row in each GROUP BY group_ - Stack Overflow.pdf
create table examresults
    (firstname varchar(10), lastname varchar(15), year integer, result integer);
insert into examresults
values('John','Klein',2020,40);
insert into examresults
values('Edith','Black',2020,43);
insert into examresults
values('Mark','Johnson',2019,32);
insert into examresults
values('Laura','Summer',2020,35);
insert into examresults
values('Kate','Smith',2019,41);
insert into examresults
values('Jacob','Black',2019,44);
insert into examresults
values('Tom','Bennett',2020,38);
insert into examresults
values('Emily','Kelley',2020,43);
insert into examresults
values('Emily','Kelley',2020,43);
insert into examresults
values('Emilytie','Foster',2020,43);
#Find the student with the best result for each year
select *
from examresults;
/*
firstname   lastname    year    result  
John    Klein   2020    40  
Edith   Black   2020    43  
Mark    Johnson 2019    32  
Laura   Summer  2020    35  
Kate    Smith   2019    41  
Jacob   Black   2019    44  
Tom Bennett 2020    38  
Emily   Kelley  2020    43  
Emilytie    Foster  2020    43  
*/
#Add a row number column
with withsqloperatorname as (
    select *, row_number() over(partition by year order by result desc) as rownumbercolumn
    from examresults)
select *
from withsqloperatorname
where rownumbercolumn = 1; #RM:  MySQL doesn't have row_number function.  Need to emulate row_number function.
set @rownumber = 0;
select (@rownumber:=@rownumber+1) as rownumbercolumn, *
from examresults; #returns error message #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '* from examresults LIMIT 0, 25' at line 1
#https://www.mysqltutorial.org/mysql-row_number/
set @rownumber = 0;
select (@rownumber:=@rownumber+1) as rownumbercolumn, examresults.*
from examresults;
/*
rownumbercolumn firstname   lastname    year    result  
1   John    Klein   2020    40  
2   Edith   Black   2020    43  
3   Mark    Johnson 2019    32  
4   Laura   Summer  2020    35  
5   Kate    Smith   2019    41  
6   Jacob   Black   2019    44  
7   Tom Bennett 2020    38  
8   Emily   Kelley  2020    43  
9   Emilytie    Foster  2020    43  
*/
select (@row_number:=@row_number + 1) as rownumbercolumn, examresults.*
from examresults, (
    select @row_number:=0) as initialvariable;
/*
rownumbercolumn firstname   lastname    year    result  
1   John    Klein   2020    40  
2   Edith   Black   2020    43  
3   Mark    Johnson 2019    32  
4   Laura   Summer  2020    35  
5   Kate    Smith   2019    41  
6   Jacob   Black   2019    44  
7   Tom Bennett 2020    38  
8   Emily   Kelley  2020    43  
9   Emilytie    Foster  2020    43  
*/
#return the first row number grouped by year sorted by result descending for highest to lowest
select *
from examresults
group by year;
/*
firstname   lastname    year    result  
Mark    Johnson 2019    32  
John    Klein   2020    40  
*/
set @rownumber = 0;
select (@rownumber:=@rownumber+1) as rownumbercolumn, examresults.*
from examresults
group by year
order by result desc;  #RM:  incorrect
/*
rownumbercolumn firstname   lastname    year    result      
1   John    Klein   2020    40  
3   Mark    Johnson 2019    32  
*/

with withsqloperatorname as (
    set @rownumber = 0;
    select examresults.*, (@rownumber:=@rownumber+1) over(partition by examresults.year order by examresults.result desc) as rownumbercolumn
    from examresults)
select withsqloperatorname.*
from withsqloperatorname; #return error message #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'withsqloperatorname as (set @rownumber = 0' at line 1
select (@row_number:=@row_number + 1) over(partition by examresults.year order by examresults.result desc) as rownumbercolumn, examresults.*
from examresults, (
    select @row_number:=0) as initialvariable; #return error message #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(partition by examresults.year order by examresults.result desc) as rownumbercol' at line 1
with love as (select (@row_number:=@row_number + 1) as rownumbercolumn, examresults.*
from examresults, (
    select @row_number:=0) as initialvariable)
select *
from love; #error message #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'love as (select (@row_number:=@row_number + 1) as rownumbercolumn, examresults.*' at line 1
select year, max(result)
from examresults
group by year;
/*
year    max(result) 
2019    44  
2020    43  
*/
select returnrows.*
from examresults returnrows
join (
    select highestresult.year, max(highestresult.result) as highestresultcolumn
    from examresults highestresult
    group by highestresult.year) joinclauselabel
on joinclauselabel.year = returnrows.year
and joinclauselabel.highestresultcolumn = returnrows.result
group by returnrows.year; #correct answer works any SQL language.  Can't break ties.
/*
firstname   lastname    year    result  
Jacob   Black   2019    44  
Edith   Black   2020    43  
*/
select *
from examresults primaryquery
where result in (
    select max(subquery.result) as highestresult
    from examresults subquery
    where subquery.year=primaryquery.year and subquery.highestresult=primaryquery.result
    group by subquery.year); #error message #1054 - Unknown column 'subquery.highestresult' in 'where clause'
select *
from examresults primaryquery
where result in (
    select max(subquery.result) as highestresult
    from examresults subquery
    where subquery.year=primaryquery.year
    group by subquery.year); #correct answer.  Ties included.
/*
firstname   lastname    year    result  
Edith   Black   2020    43  
Jacob   Black   2019    44  
Emily   Kelley  2020    43  
Emilytie    Foster  2020    43  
*/
#Bonus add a row number to each group #RM:  doesnt' work from my MySQL database https://www.mysqltutorial.org/mysql-row_number/
set @rownumber:=0;
select @rownumber:=case when @rownumberyear = year then @rownumber+1 else 1 end as rownumbercolumn, @rownumberyear:=year year, firstname, lastname, result
from examresults;
/*
rownumbercolumn year    firstname   lastname    result  
1   2020    John    Klein   40  
1   2020    Edith   Black   43  
1   2019    Mark    Johnson 32  
1   2020    Laura   Summer  35  
1   2019    Kate    Smith   41  
1   2019    Jacob   Black   44  
1   2020    Tom Bennett 38  
1   2020    Emily   Kelley  43  
1   2020    Emilytie    Foster  43  
*/
set @rownumber:=0;
select @rownumber:=case when @rownumberyear = year then @rownumber+1 else 1 end as rownumbercolumn, @rownumberyear:=year year, firstname, lastname, result
from examresults
order by year;
/*
rownumbercolumn year    firstname   lastname    result  
1   2019    Mark    Johnson 32  
1   2019    Kate    Smith   41  
1   2019    Jacob   Black   44  
1   2020    John    Klein   40  
1   2020    Edith   Black   43  
1   2020    Laura   Summer  35  
1   2020    Tom Bennett 38  
1   2020    Emily   Kelley  43  
1   2020    Emilytie    Foster  43  
*/

create table documentstatus
    (id integer(2) not null primary key, documentid integer(1), status varchar(2), datecreated date);
insert into documentstatus
values(2,1,'S1','2011-07-29');
insert into documentstatus
values(3,1,'S2','2011-07-30');
insert into documentstatus
values(6,1,'S1','2011-08-02');
insert into documentstatus
values(1,2,'S1','2011-07-28');
insert into documentstatus
values(4,2,'S2','2011-07-30');
insert into documentstatus
values(5,2,'S3','2011-08-01');
insert into documentstatus
values(7,3,'S1','2011-08-02');
#Get the latest document id group by documentid.  Solutions are 6 and 7 for S1, 3 and 4 for S2, 5 for S3.
select *
from documentstatus;
/*
id  documentid  status  datecreated 
2   1   S1  2011-07-29  
3   1   S2  2011-07-30  
6   1   S1  2011-08-02  
1   2   S1  2011-07-28  
4   2   S2  2011-07-30  
5   2   S3  2011-08-01  
7   3   S1  2011-08-02  
*/