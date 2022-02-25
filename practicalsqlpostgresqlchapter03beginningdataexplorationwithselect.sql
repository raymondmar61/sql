#Practical SQL By Anthony DeBarros Second Edition Chapter 03 Beginning Data Exploration With Select
table teachers;
'''
"id"    "firstname" "lastname"  "school"    "hiredate"  "salary"
1   "Janet" "Smith" "F.D. Roosevelt HS" "2011-10-30"    36200
2   "Lee"   "Reynolds"  "F.D. Roosevelt HS" "1993-05-22"    65000
3   "Samuel"    "Cole"  "Myers Middle School"   "2005-08-01"    43500
4   "Samanta"   "Bush"  "Myers Middle School"   "2011-10-30"    36200
5   "Betty" "Diaz"  "Myers Middle School"   "2005-08-30"    43500
6   "Kathleen"  "Roush" "F.D. Roosevelt HS" "2010-10-22"    38500
'''

select lastname, firstname, salary
from teachers
order by salary desc;
select lastname, firstname, hiredate
from teachers
order by school asc, 3 desc;
select distinct school
from teachers
order by school;
'''
"school"
"F.D. Roosevelt HS"
"Myers Middle School"
'''

select distinct school, salary
from teachers
order by school, salary;
'''
"school"    "salary"
"F.D. Roosevelt HS" 36200
"F.D. Roosevelt HS" 38500
"F.D. Roosevelt HS" 65000
"Myers Middle School"   36200
"Myers Middle School"   43500
'''

select lastname, school, hiredate
from teachers
where school = 'Myers Middle School';
select school
from teachers
where school <> 'F.D. Roosevelt HS';
select firstname, lastname, school, salary
from teachers
where salary between 40000 and 65000;  --between is inclusive
'''
"firstname" "lastname"  "school"    "salary"
"Lee"   "Reynolds"  "F.D. Roosevelt HS" 65000
"Samuel"    "Cole"  "Myers Middle School"   43500
"Betty" "Diaz"  "Myers Middle School"   43500
'''

select firstname
from teachers
where firstname like 'sam%'; --% is wildcard matching one or more characters
select firstname
from teachers
where firstname ilike 'sam%';  --ilike wildcard case insensitive
'''
"firstname"
"Samuel"
"Samanta"
'''

select firstname, lastname, school, hiredate, salary
from teachers
where school ilike '%roos%'
order by hiredate desc;
'''
"firstname" "lastname"  "school"    "hiredate"  "salary"
"Janet" "Smith" "F.D. Roosevelt HS" "2011-10-30"    36200
"Kathleen"  "Roush" "F.D. Roosevelt HS" "2010-10-22"    38500
"Lee"   "Reynolds"  "F.D. Roosevelt HS" "1993-05-22"    65000
'''