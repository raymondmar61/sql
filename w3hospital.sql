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

#11. Write a query in SQL to obtain the name of the physicians who are not a specialized physician.
select name
from physician
where position not like '%Physician%';
#official solution
select p.name as "Physician", p.position "Designation"
from physician p left join trained_in t
on p.employeeid=t.physician
where t.treatment is null
order by employeeid;

#12. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement.
select patient.name as "Patient's Name", physician.name as "Physician's Name"
from patient, physician
where patient.pcp = physician.employeeid;

#13. Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.  #RM:  question asked for number of physicians, not the number of appointements.  Official solution counted all physicians or all appointments.
select patient.name, count(distinct appointment.physician)
from patient, appointment
where patient.ssn = appointment.patient
group by patient.name;

#14. Write a query in SQL to count number of unique patients who got an appointment for examination room C.
select count(distinct patient)
from appointment
where examinationroom = 'C';

#15. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.
select patient.name, appointment.examinationroom, appointment.start_dt_time
from patient join appointment
on patient.ssn = appointment.patient;

#16. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.  #RM:  find the nurse who served the patient.
select nurse.name, appointment.examinationroom, appointment.start_dt_time
from nurse, appointment
where nurse.employeeid = appointment.prepnurse;

#17. Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no.
select patient.name as "Patient", physician.name as "Physician", nurse.name as "Nurse", appointment.examinationroom
from patient join appointment
on patient.ssn = appointment.patient
join nurse
on nurse.employeeid = appointment.prepnurse
join physician
on physician.employeeid = appointment.physician
where appointment.start_dt_time = '2008-04-25 10:00:00';

#18. Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.
select patient.name as "Patient", physician.name as "Physician", appointment.start_dt_time, appointment.examinationroom
from patient join appointment
on patient.ssn = appointment.patient
join physician
on physician.employeeid = appointment.physician
where appointment.prepnurse is null;

#19. Write a query in SQL to find the name of the patients, their treating physicians and medication.  #RM:  want physician who prescribed the medication.  Not the pcp physician.  Confusing.
select patient.name as "Patient", physician.name as "Physician", medication.name as "Medication", prescribes.dose
from patient join physician
on patient.pcp = physician.employeeid
join prescribes
on patient.ssn = prescribes.patient
join medication
on prescribes.medication = medication.code;  #patient's pcp physician
select patient.name as "Patient", physician.name as "Physician", medication.name as "Medication", prescribes.dose
from patient join prescribes
on patient.ssn = prescribes.patient
join physician
on prescribes.physician = physician.employeeid
join medication
on prescribes.medication = medication.code;  #patient's prescription physician

#20. Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.  #RM:  looked at solution.  Find patients where prescribes.appointment is not null.  And want physician who prescribed the medication.  Not the pcp physician.  From question 19.
select patient.name as "Patient", physician.name as "Physician", medication.name as "Medication", prescribes.dose
from patient join prescribes
on patient.ssn = prescribes.patient
join physician
on prescribes.physician = physician.employeeid
join medication
on prescribes.medication = medication.code
where prescribes.appointment is not null;

#21. Write a query in SQL to find the name and medication for those patients who did not take any appointment.  #RM:  Find patients where prescribes.appointment is null.
select patient.name as "Patient", physician.name as "Physician", medication.name as "Medication", prescribes.dose
from patient join prescribes
on patient.ssn = prescribes.patient
join physician
on prescribes.physician = physician.employeeid
join medication
on prescribes.medication = medication.code
where prescribes.appointment is null;

#22. Write a query in SQL to count the number of available rooms in each block.  #RM:  solution used blockcode column and not blockfloor
select blockcode, count(blockcode)
from room
where unavailable = 'f'
group by blockcode
order by blockcode;

#23. Write a query in SQL to count the number of available rooms in each floor.  #RM:  now use blockfloor
select blockfloor, count(blockfloor)
from room
where unavailable = 'f'
group by blockfloor
order by blockfloor;

#24. Write a query in SQL to count the number of available rooms for each block in each floor.  #RM:  solution group by blockfloor first then blockcode.
select blockfloor, blockcode, count(*)
from room
where unavailable = 'f'
group by blockfloor, blockcode
order by blockfloor, blockcode;