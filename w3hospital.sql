#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php

#1. Write a query in SQL to find all the information of the nurses who are yet to be registered
select *
from nurse
where registered = 'f';

#2. Write a query in SQL to find the name of the nurse who are the head of their department.
select name
from nurse
where position = 'Head Nurse';

#3. Write a query in SQL to obtain the name of the physicians who are the head of each department.
select p.name, d.name as "Department"
from physician p, department d
where p.employeeid = d.head;

#4. Write a query in SQL to count the number of patients who taken appointment with at least one physician.  #RM:  No double counting same physicians.  Want how many different doctors each patient visited.
select patient, count(distinct physician)
from appointment
group by patient;
#official solution
select count(distinct patient) as "No. of patients taken at least one appointment"
from appointment;

#5. Write a query in SQL to find the floor and block where the room number 212 belongs to.
select blockfloor, blockcode
from room
where roomnumber = 212;

#6. Write a query in SQL to count the number available rooms.
select count(*)
from room
where unavailable = 'f';

#7. Write a query in SQL to count the number of unavailable rooms.
select count(*)
from room
where unavailable = 't';

#8. Write a query in SQL to obtain the name of the physician and the departments they are affiliated with.
select p.name as "Physician", d.name as "Department"
from physician p join affiliated_with a
on p.employeeid = a.physician
join department d
on a.department = d.departmentid
where a.primaryaffiliation = 't';  #RM:  .name is the same.  Must included as "alias".

#9. Write a query in SQL to obtain the name of the physicians who are trained for a special treatment.
select physician.name as "Physician", procedure.name as "Specialist"
from physician, procedure, trained_in
where physician.employeeid = trained_in.physician
and trained_in.treatment = procedure.code;

#10. Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.
select p.name as "Physician", d.name as "Department"
from physician p join affiliated_with a
on p.employeeid = a.physician
join department d
on a.department = d.departmentid
where a.primaryaffiliation = 'f';