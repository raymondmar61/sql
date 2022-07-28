--Standard view named nevadacountiespop2019
--If replacing an existing view, the replacing query must generate the same column names with the same data types and in the same order as the view being replaced.  Okay to add columns at the end of the column list.
--To see views, click the database name, Schemas-->public-->Views.
create or replace view nevadacountiespop2019 as
    select countyname, statefips, countyfips, popest2019
    from uscountiespopest2019
    where statename='Nevada';
--Run a select query from nevadacountiespop2019 view
select *
from nevadacountiespop2019  
order by countyfips
limit 5;
/*
"countyname"	"statefips"	"countyfips"	"popest2019"
"Churchill County"	"32"	"001"	24909
"Clark County"	"32"	"003"	2266715
"Douglas County"	"32"	"005"	48905
"Elko County"	"32"	"007"	52778
"Esmeralda County"	"32"	"009"	873
*/
--Create view countypopchange20192010 showing population change for US counties
create or replace view countypopchange20192010 as
    select c2019.countyname, c2019.statename, c2019.statefips, c2019.countyfips, c2019.popest2019 as pop2019, c2010.estimatesbase2010 as pop2010, round((c2019.popest2019::numeric-c2010.estimatesbase2010)/c2010.estimatesbase2010*100,1) as pctchange20192010
    from uscountiespopest2019 as c2019 join uscountiespopest2010 as c2010
    on c2019.statefips = c2010.statefips
    and c2019.countyfips = c2010.countyfips;
--Run a select query from countypopchange20192010 view for Nevada
select countyname, statename, pop2019, pctchange20192010
from countypopchange20192010
where statename='Nevada'
order by countyfips
limit 5;
/*
"countyname"	"statename"	"pop2019"	"pctchange20192010"
"Churchill County"	"Nevada"	24909	0.1
"Clark County"	"Nevada"	2266715	16.2
"Douglas County"	"Nevada"	48905	4.1
"Elko County"	"Nevada"	52778	7.8
"Esmeralda County"	"Nevada"	873	11.4
*/
--Delete view use the drop command.  drop view *viewname*;
drop view countypopchange20192010;
--Create materialized view which is the materialized view's stored query is executed and the results are saved in the database creating a new table.  The materialized view retains its stored query.  You can update the saved data with a command to refresh the view.
--To see materialized views, click the database name, Schemas-->public-->Materialized Views.
--or replace keywords are unavailable in a materialized view.
create materialized view nevadacountiespop2019materalizedview as
    select countyname, statefips, countyfips, popest2019
    from uscountiespopest2019
    where statename = 'Nevada';
--Run a select query from nevadacountiespop2019materalizedview view
select *
from nevadacountiespop2019materalizedview
limit 5;
/*
"countyname"	"statefips"	"countyfips"	"popest2019"
"Churchill County"	"32"	"001"	24909
"Clark County"	"32"	"003"	2266715
"Douglas County"	"32"	"005"	48905
"Elko County"	"32"	"007"	52778
"Esmeralda County"	"32"	"009"	873
*/
--Run a refresh if uscountiespopest2019 are updated for nevadacountiespop2019materalizedview view.
refresh materialized view nevadacountiespop2019materalizedview;  --print REFRESH MATERIALIZED VIEW
--Delete materialized view use the drop materialized command.  drop materialized view *viewname*;
drop materialized view nevadacountiespop2019materalizedview;
--Create function percent change percentchange()
create or replace function percentchange(newvalue numeric, oldvalue numeric, decimalplaces integer default 1)
returns numeric as 'select round(((newvalue-oldvalue)/oldvalue)*100,decimalplaces);'
language SQL
immutable
returns null on null input;
select percentchange(110,108,2); --print 1.85
select percentchange(11,10,4); --print 10.0000
select percentchange(11,10); --print 10.0
select c2019.countyname, c2019.statename, c2019.popest2019 as pop2019, percentchange(c2019.popest2019,c2010.estimatesbase2010) as percentchangefunction, round((c2019.popest2019::numeric-c2010.estimatesbase2010)/c2010.estimatesbase2010*100,1) as pctchange20192010
from uscountiespopest2019 as c2019 join uscountiespopest2010 as c2010
on c2019.statefips = c2010.statefips
and c2019.countyfips = c2010.countyfips
order by percentchangefunction desc
limit 5;
/*
"countyname"    "statename" "pop2019"   "percentchangefunction" "pctchange20192010"
"McKenzie County"   "North Dakota"  15024   136.3   136.3
"Loving County" "Texas" 169 106.1   106.1
"Williams County"   "North Dakota"  37589   67.8    67.8
"Hays County"   "Texas" 230191  46.5    46.5
"Wasatch County"    "Utah"  34091   44.9    44.9
*/
--Write a procedure.  Procedure is updating data.  The example is update a record of the correct number of personal days off a teacher gets in addition to vacation days based on the time elapsed since their hire date.  First, add a column to teachers table for personal days off.
alter table teachers add column personaldays integer;
select firstname, lastname, hiredate, personaldays
from teachers;
/*
"firstname" "lastname"  "hiredate"  "personaldays"
"Janet" "Smith" "2011-10-30"    
"Lee"   "Reynolds"  "1993-05-22"    
"Samuel"    "Cole"  "2005-08-01"    
"Samanta"   "Bush"  "2011-10-30"    
"Betty" "Diaz"  "2005-08-30"    
"Kathleen"  "Roush" "2010-10-22"    
*/
--Create a procedure updatepersonaldays() for the personaldays column.  3 personal days for less than 10 years.  4 personal days for 10 to 14 years.  5 personal days for 15 to 19 years.  6 personal days for 20 to 24 years.  7 personal days for 25 years or greater.
--The PostgreSQL convention to use the non-ANSI SQL standard dollar-quote $$ to mark the start and mark the end of the string containing the function's commands.  Can add text between the dollar signs to create a unique pair of beginning and ending quotes.
create or replace procedure updatepersonaldays() as $anystringhere$ begin
update teachers
set personaldays = case when (now()-hiredate)>='10 years'::interval and (now()-hiredate)<'15 years'::interval then 4
when (now()-hiredate)>='15 years'::interval and (now()-hiredate)<'20 years'::interval then 5
when (now()-hiredate)>='20 years'::interval and (now()-hiredate)<'25 years'::interval then 6
when (now()-hiredate)>='25 years'::interval then 7
else 3
end;
raise notice 'display message here procedure is done personaldays updated!';
end;
$anystringhere$
language plpgsql;
--Run the procedure or invoke procedure use the call command
call updatepersonaldays();
select firstname, lastname, hiredate, personaldays
from teachers;
/*
"firstname" "lastname"  "hiredate"  "personaldays"
"Janet" "Smith" "2011-10-30"    4
"Lee"   "Reynolds"  "1993-05-22"    7
"Samuel"    "Cole"  "2005-08-01"    5
"Samanta"   "Bush"  "2011-10-30"    4
"Betty" "Diaz"  "2005-08-30"    5
"Kathleen"  "Roush" "2010-10-22"    4
*/
--Create a trigger.  Log changes to student grades at a school.
create table grades (studentid bigint, courseid bigint, course text not null, grade text not null, primary key (studentid, courseid));
drop table grades;
insert into grades
values (1, 1, 'Biology 2', 'F'), (1, 2, 'English 11B', 'D'), (1, 3, 'World History 11B', 'C'), (1, 4, 'Trig 2', 'B');
create table gradeshistory (studentid bigint not null, courseid bigint not null, changetime timestamp with time zone not null, course text not null, oldgrade text not null, newgrade text not null, primary key (studentid, courseid, changetime));
select *
from grades;
/*
"studentid" "courseid"  "course"    "grade"
1   1   "Biology 2" "F"
1   2   "English 11B"   "D"
1   3   "World History 11B" "C"
1   4   "Trig 2"    "B"
*/
create or replace function recordifgradechanged()
returns trigger as $astringhere$ begin
if new.grade<>old.grade then
insert into gradeshistory (studentid, courseid, changetime, course, oldgrade, newgrade)
values (old.studentid, old.courseid, now(), old.course, old.grade, new.grade);
end if;
return null;
end;
$astringhere$
language plpgsql;
create trigger gradesupdate
after update on grades  --after keyword specify the trigger to activate after the update occurs on the grades row.  Can use before instead of keywords.
for each row  --Execute the procedure once for each row updated in the grades(?) table
execute procedure recordifgradechanged();
--Test trigger
select *
from gradeshistory;
/*
*/
--Update the Biology2 grade from F to C
update grades
set grade = 'C'
where studentid=1 and courseid=1;
select *
from gradeshistory;
/*
"studentid" "courseid"  "changetime"    "course"    "oldgrade"  "newgrade"
1   1   "2022-07-27 23:43:45.540339-07" "Biology 2" "F" "C"
*/
select *
from grades;
/*
"studentid" "courseid"  "course"    "grade"
1   2   "English 11B"   "D"
1   3   "World History 11B" "C"
1   4   "Trig 2"    "B"
1   1   "Biology 2" "C"
*/
--Create a trigger.  Classify temperatures with a word description.  Add text to a column based on another column value.
create table temperaturetest (stationname text, observationdate date, maxtemp integer, mintemp integer, maxtempgroup text, primary key (stationname, observationdate));
create or replace function classifymaxtempword()
returns trigger as $astringhere$ begin
case when new.maxtemp>=90 then new.maxtempgroup:='Hot';
when new.maxtemp>=70 and new.maxtemp<90 then new.maxtempgroup:='Warm';
when new.maxtemp>=50 and new.maxtemp<70 then new.maxtempgroup:='Pleasant';
when new.maxtemp>=33 and new.maxtemp<50 then new.maxtempgroup:='Cold';
when new.maxtemp>=20 and new.maxtemp<33 then new.maxtempgroup:='Frigid';
when new.maxtemp<20 then new.maxtempgroup:='Inhumane';
else new.maxtempgroup:='New reading';
end case;
return new;
end;
$astringhere$
language plpgsql;
create trigger temperatureinsert
before insert  --Trigger to activate before the insertion using before insert
on temperaturetest
for each row  --Trigger to activate for each row because we want maxtemp recorded in the temperaturetest table maxtempgroup column
execute procedure classifymaxtempword();
select *
from temperaturetest;
/*
*/
insert into temperaturetest values ('north station', '1/19/2023', 10, -3), ('north station', '3/20/2023', 28, 19), ('north station', '5/2/2023', 65, 42), ('north station', '8/9/2023', 93, 74), ('north station', '12/14/2023', null, null);
select *
from temperaturetest;
/*
"stationname"   "observationdate"   "maxtemp"   "mintemp"   "maxtempgroup"
"north station" "2023-01-19"    10  -3  "Inhumane"
"north station" "2023-03-20"    28  19  "Frigid"
"north station" "2023-05-02"    65  42  "Pleasant"
"north station" "2023-08-09"    93  74  "Hot"
"north station" "2023-12-14"            "New reading"
*/