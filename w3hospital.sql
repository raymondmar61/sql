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

#25. Write a query in SQL to count the number of unavailable rooms for each block in each floor.
select blockfloor, blockcode, count(unavailable)
from room
where unavailable = 't'
group by blockfloor, blockcode
order by blockfloor, blockcode;
#quick count
select count(*)
from room
where unavailable = 't';

#26. Write a query in SQL to find out the floor where the maximum no of rooms are available.
select blockfloor, count(*)
from room
where unavailable = 'f'
group by blockfloor
having count(*) = (
	select count(*)
	from room
	where unavailable = 'f'
	group by blockfloor
	order by count(*) desc limit 1)
order by blockfloor;
#official solution
select blockfloor as "floor", count(*) as  "no of available rooms"
from room
where unavailable='f'
group by blockfloor
having count(*) = (
	select max(getcountsagain) as highest_total
	from (
		select blockfloor, count(*) as getcountsagain
      	from room
      	where unavailable='f'
      	group by blockfloor)
    as temptablegetmaxcount);

#27. Write a query in SQL to find out the floor where the minimum no of rooms are available.
select blockfloor, count(*)
from room
where unavailable = 'f'
group by blockfloor
having count(*) = (
  select count(*)
  from room
  where unavailable = 'f'
  group by blockfloor
  order by count(*) asc limit 1)
order by blockfloor;
#official solution
select blockfloor as "floor", count(*) as  "no of available rooms"
from room
where unavailable='f'
group by blockfloor
having count(*) = (
  select min(getcountsagain) as lowest_total
  from (
    select blockfloor, count(*) as getcountsagain
        from room
        where unavailable='f'
        group by blockfloor)
    as temptablegetmincount);

#28. Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted.
select patient.name, room.blockfloor, stay.room, room.blockcode
from patient join stay
on patient.ssn = stay.patient
join room
on stay.room = room.roomnumber;

#29. Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.
select nurse.name, on_call.blockfloor, on_call.blockcode
from nurse, on_call
where nurse.employeeid = on_call.nurse;

#30. Write a query in SQL to make a report which will show -
#a) name of the patient, 
#b) name of the physician who is treating him or her,
#c) name of the nurse who is attending him or her,
#d) which treatement is going on to the patient,
#e) the date of release,
#f) in which room the patient has admitted and which floor and block the room belongs to respectively.
select patient.name as "Patient", physician.name as "Physician", nurse.name as "Nurse", undergoes.procedure, undergoes.date, room.blockfloor, room.roomnumber #official solution says undergoes.date is date of release.  It's not stay.end_time.
from patient join undergoes
on patient.ssn = undergoes.patient
join physician
on undergoes.physician = physician.employeeid
left join nurse
on undergoes.assistingnurse = nurse.employeeid #one patient is not assigned a nurse
join stay
on undergoes.stay = stay.stayid
join room
on stay.room = room.roomnumber;

#31. Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform.  #RM:  double equal signs on a join statement or double joins.
#List of Physicians undergoes a procedure
select physician.name, undergoes.procedure
from physician join undergoes
on physician.employeeid = undergoes.physician
order by 1, 2;
/*
name	procedure
Christopher Turk	1
Christopher Turk	4
Christopher Turk	6
John Wen	2
John Wen	7
Todd Quinlan	5
*/
#List of Physicians with certifications or trained_in
select physician.name, trained_in.treatment
from physician join trained_in
on physician.employeeid = trained_in.physician
order by 1, 2;
/*
name	treatment
Christopher Turk	1
Christopher Turk	2
Christopher Turk	5
Christopher Turk	6
Christopher Turk	7
John Wen	1
John Wen	2
John Wen	3
John Wen	4
John Wen	5
John Wen	6
John Wen	7
Todd Quinlan	2
Todd Quinlan	5
Todd Quinlan	6
*/
#official solution
select name as "Physician"
from physician
where employeeid in (
	select undergoes.physician
	from undergoes left join trained_in
	on undergoes.physician=trained_in.physician
	and undergoes.procedure=trained_in.treatment
	where treatment is null); #answer is Christopher Turk
#the subquery if I include trained_in.treatment, then there is a null.  One row is physician 3 and treatment null.
select undergoes.physician, trained_in.treatment
from undergoes left join trained_in
on undergoes.physician=trained_in.physician
and undergoes.procedure=trained_in.treatment;
/*
physician	treatment
3	1
3	
3	6
*/
#user solution
select name, treatment
from physician p join undergoes u
on p.employeeid=u.physician
left join trained_in t
on u.procedure=t.treatment
and u.physician=t.physician
where treatment is null; #answer is Christopher Turk

#32. Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure.   #RM:  double equal signs on a join statement or double joins.
#Physicians performing procedure on patient and the date
select physician.name as "Physician", procedure.name "Procedure", undergoes.date, patient.name "Patient"
from physician join undergoes
on physician.employeeid = undergoes.physician
join procedure
on undergoes.procedure = procedure.code
join patient
on undergoes.patient = patient.ssn
order by physician.name;
#Not certified physicians performing procedure on patient and the date 
select physician.name as "Physician", procedure.name "Procedure", undergoes.date, patient.name "Patient"
from physician join undergoes
on physician.employeeid = undergoes.physician
join procedure
on undergoes.procedure = procedure.code
join patient
on undergoes.patient = patient.ssn
left outer join trained_in
on undergoes.physician = trained_in.physician
and undergoes.procedure = trained_in.treatment
where trained_in.treatment is null
order by physician.name;

#33. Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate.   #RM:  double equal signs on a join statement or double joins.
select physician.name as "Name", physician.position as "Position", trained_in.treatment
from physician join undergoes
on physician.employeeid = undergoes.physician
left outer join trained_in
on undergoes.physician = trained_in.physician
and undergoes.procedure = trained_in.treatment
where undergoes.date > trained_in.certificationexpires;

#34. Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after the date of expiration of their certificate, their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired.  #RM:  double equal signs on a join statement or double joins.
select physician.name as "Name", physician.position as "Position", procedure.name as "Procedure", undergoes.date, patient.name as "Patient", trained_in.treatment, trained_in.certificationexpires
from physician join undergoes
on physician.employeeid = undergoes.physician
left outer join trained_in
on undergoes.physician = trained_in.physician
and undergoes.procedure = trained_in.treatment
join procedure
on undergoes.procedure = procedure.code
join patient
on undergoes.patient = patient.ssn
where undergoes.date > trained_in.certificationexpires;

#35. Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122.
select nurse.name
from nurse join on_call
on nurse.employeeid = on_call.nurse
join room
on on_call.blockfloor = room.blockfloor
and on_call.blockcode = room.blockcode
where room.roomnumber = 122;
#subquery
select nurse.name
from nurse
where employeeid in (
	select nurse
	from on_call, room
	where on_call.blockfloor = room.blockfloor
	and on_call.blockcode = room.blockcode
	and room.roomnumber = 122);

#36. Write a query in SQL to Obtain the names of all patients who has been prescribed some medication by his/her physician who has carried out primary care and the name of that physician.  #RM:  double equal signs on a join statement or double joins.
select patient.name as "Patient", prescribes.medication, physician.name as "Primary Care Physician"
from patient join prescribes
on patient.ssn = prescribes.patient
join physician
on patient.pcp = physician.employeeid
and prescribes.physician = physician.employeeid;
#official solution
select pt.name as "ptient", p.name as "physician"
from patient pt join prescribes pr
on pr.patient = pt.ssn
join physician p
on pt.pcp = p.employeeid
where pt.pcp = pr.physician
and pt.pcp = p.employeeid;

#37. Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care.  #RM:  two joins same tables different alias different joins same tables
#Undergoes Physician and PCP Physician
select patient.name as "Patient", primarycarephysician.name as "Physician PCP", procedure.name as "Procedure", physician.name as "Physician Undergoes", procedure.cost
from patient join undergoes
on patient.ssn = undergoes.patient
join procedure
on undergoes.procedure = procedure.code
join physician
on undergoes.physician = physician.employeeid
join physician primarycarephysician
on patient.pcp = primarycarephysician.employeeid
where procedure.cost > 5000;
#Undergoes Physician only
select patient.name as "Patient", procedure.name as "Procedure", physician.name as "Physician Undergoes", procedure.cost
from patient join undergoes
on patient.ssn = undergoes.patient
join procedure
on undergoes.procedure = procedure.code
join physician
on undergoes.physician = physician.employeeid
where procedure.cost > 5000;
#official solution
select pt.name as "ptient", p.name as "primary physician", pd.cost as "porcedure cost"
from patient pt join undergoes u
on u.patient=pt.ssn
join physician p
on pt.pcp=p.employeeid
join procedure pd
on u.procedure=pd.code
where pd.cost>5000;

#38. Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse who prepped the appointment was a registered nurse and the physiccian who has carried out primary care.
#patients at least two appointments
select patient.name as "Patient", count(appointment.patient)
from patient join appointment
on patient.ssn = appointment.patient
group by patient.name
having count(appointment.patient) >=2;
#patients at least two appointments with registered nurse and primary care pcp physician
select patient.name as "Patient", physician.name as "Physician", count(appointment.patient)
from patient join appointment
on patient.ssn = appointment.patient
join nurse
on appointment.prepnurse = nurse.employeeid
join physician
on physician.employeeid = appointment.physician
join physician pcp
on pcp.employeeid = patient.pcp
where nurse.registered = 't'
group by patient.name, physician.name
having count(appointment.patient) >=2;
#user solution
select name,A.count from (
	select pa.name, count(appointmentid)
	from patient pa join appointment a
	on pa.ssn=a.patient
	join nurse n
	on a.prepnurse=n.employeeid
	join physician ph
	on pa.pcp=ph.employeeid
	where registered='t'
	group by pa.name) A
where A.count >= 2;

#39. Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician who is not the head of any department and name of that physician along with their primary care physician.
select patient.name as "Patient", physician.name as "Physician"
from patient join physician
on patient.pcp = physician.employeeid
where physician.employeeid not in (
	select department.head
	from department);