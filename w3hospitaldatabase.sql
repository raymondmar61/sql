#https://www.w3resource.com/sql-exercises/hospital-database-exercise/index.php
#https://www.w3resource.com/w3r_images/hospital-database-e-r-diagram.png
#https://en.wikibooks.org/wiki/SQL_Exercises/The_Hospital
#Sample Database: hospital.  With the help of a Hospital Database, this exercises will help you undestand simple SQL select queries to advanced multi table JOIN queries.
/*
List of tables in the hospital database:

physician
department
affiliated_with
procedure
trained_in
patient
nurse
appointment
medication
prescribes
block
room
on_call
stay
undergoes

Sample table: nurse
 employeeid |      name       |  position  | registered |    ssn
------------+-----------------+------------+------------+-----------
        101 | Carla Espinosa  | Head Nurse | t          | 111111110
        102 | Laverne Roberts | Nurse      | t          | 222222220
        103 | Paul Flowers    | Nurse      | f          | 333333330

Sample table: physician
 employeeid |       name        |           position           |    ssn
------------+-------------------+------------------------------+-----------
          1 | John Dorian       | Staff Internist              | 111111111
          2 | Elliot Reid       | Attending Physician          | 222222222
          3 | Christopher Turk  | Surgical Attending Physician | 333333333
          4 | Percival Cox      | Senior Attending Physician   | 444444444
          5 | Bob Kelso         | Head Chief of Medicine       | 555555555
          6 | Todd Quinlan      | Surgical Attending Physician | 666666666
          7 | John Wen          | Surgical Attending Physician | 777777777
          8 | Keith Dudemeister | MD Resident                  | 888888888
          9 | Molly Clock       | Attending Psychiatrist       | 999999999

Sample table: department
 departmentid |       name       | head
--------------+------------------+------
            1 | General Medicine |    4
            2 | Surgery          |    7
            3 | Psychiatry       |    9

Sample table: appointment
 appointmentid |  patient  | prepnurse | physician |    start_dt_time    |     end_dt_time     | examinationroom
---------------+-----------+-----------+-----------+---------------------+---------------------+-----------------
      13216584 | 100000001 |       101 |         1 | 2008-04-24 10:00:00 | 2008-04-24 11:00:00 | A
      26548913 | 100000002 |       101 |         2 | 2008-04-24 10:00:00 | 2008-04-24 11:00:00 | B
      36549879 | 100000001 |       102 |         1 | 2008-04-25 10:00:00 | 2008-04-25 11:00:00 | A
      46846589 | 100000004 |       103 |         4 | 2008-04-25 10:00:00 | 2008-04-25 11:00:00 | B
      59871321 | 100000004 |           |         4 | 2008-04-26 10:00:00 | 2008-04-26 11:00:00 | C
      69879231 | 100000003 |       103 |         2 | 2008-04-26 11:00:00 | 2008-04-26 12:00:00 | C
      76983231 | 100000001 |           |         3 | 2008-04-26 12:00:00 | 2008-04-26 13:00:00 | C
      86213939 | 100000004 |       102 |         9 | 2008-04-27 10:00:00 | 2008-04-21 11:00:00 | A
      93216548 | 100000002 |       101 |         2 | 2008-04-27 10:00:00 | 2008-04-27 11:00:00 | B

Sample table: room
roomnumber | roomtype | blockfloor | blockcode | unavailable
-----------+----------+------------+-----------+-------------
       101 | Single   |          1 |         1 | f
       102 | Single   |          1 |         1 | f
       103 | Single   |          1 |         1 | f
       111 | Single   |          1 |         2 | f
       112 | Single   |          1 |         2 | t
       113 | Single   |          1 |         2 | f
       121 | Single   |          1 |         3 | f
       122 | Single   |          1 |         3 | f
       123 | Single   |          1 |         3 | f
       201 | Single   |          2 |         1 | t
       202 | Single   |          2 |         1 | f
       203 | Single   |          2 |         1 | f
       211 | Single   |          2 |         2 | f
       212 | Single   |          2 |         2 | f
       213 | Single   |          2 |         2 | t
       221 | Single   |          2 |         3 | f
       222 | Single   |          2 |         3 | f
       223 | Single   |          2 |         3 | f
       301 | Single   |          3 |         1 | f
       302 | Single   |          3 |         1 | t
       303 | Single   |          3 |         1 | f
       311 | Single   |          3 |         2 | f
       312 | Single   |          3 |         2 | f
       313 | Single   |          3 |         2 | f
       321 | Single   |          3 |         3 | t
       322 | Single   |          3 |         3 | f
       323 | Single   |          3 |         3 | f
       401 | Single   |          4 |         1 | f
       402 | Single   |          4 |         1 | t
       403 | Single   |          4 |         1 | f
       411 | Single   |          4 |         2 | f
       412 | Single   |          4 |         2 | f
       413 | Single   |          4 |         2 | f
       421 | Single   |          4 |         3 | t
       422 | Single   |          4 |         3 | f
       423 | Single   |          4 |         3 | f

Sample table: affiliated_with
physician | department | primaryaffiliation
-----------+------------+--------------------
         1 |          1 | t
         2 |          1 | t
         3 |          1 | f
         3 |          2 | t
         4 |          1 | t
         5 |          1 | t
         6 |          2 | t
         7 |          1 | f
         7 |          2 | t
         8 |          1 | t
         9 |          3 | t

Sample table: procedure
 code |              name              | cost
------+--------------------------------+-------
    1 | Reverse Rhinopodoplasty        |  1500
    2 | Obtuse Pyloric Recombobulation |  3750
    3 | Folded Demiophtalmectomy       |  4500
    4 | Complete Walletectomy          | 10000
    5 | Obfuscated Dermogastrotomy     |  4899
    6 | Reversible Pancreomyoplasty    |  5600
    7 | Follicular Demiectomy          |    25

Sample table: trained_in
physician | treatment | certificationdate | certificationexpires
-----------+-----------+-------------------+----------------------
         3 |         1 | 2008-01-01        | 2008-12-31
         3 |         2 | 2008-01-01        | 2008-12-31
         3 |         5 | 2008-01-01        | 2008-12-31
         3 |         6 | 2008-01-01        | 2008-12-31
         3 |         7 | 2008-01-01        | 2008-12-31
         6 |         2 | 2008-01-01        | 2008-12-31
         6 |         5 | 2007-01-01        | 2007-12-31
         6 |         6 | 2008-01-01        | 2008-12-31
         7 |         1 | 2008-01-01        | 2008-12-31
         7 |         2 | 2008-01-01        | 2008-12-31
         7 |         3 | 2008-01-01        | 2008-12-31
         7 |         4 | 2008-01-01        | 2008-12-31
         7 |         5 | 2008-01-01        | 2008-12-31
         7 |         6 | 2008-01-01        | 2008-12-31
         7 |         7 | 2008-01-01        | 2008-12-31

Sample table: patient
    ssn    |       name        |      address       |  phone   | insuranceid | pcp
-----------+-------------------+--------------------+----------+-------------+-----
 100000001 | John Smith        | 42 Foobar Lane     | 555-0256 |    68476213 |   1
 100000002 | Grace Ritchie     | 37 Snafu Drive     | 555-0512 |    36546321 |   2
 100000003 | Random J. Patient | 101 Omgbbq Street  | 555-1204 |    65465421 |   2
 100000004 | Dennis Doe        | 1100 Foobaz Avenue | 555-2048 |    68421879 |   3

Sample table: appointment
 appointmentid |  patient  | prepnurse | physician |    start_dt_time    |     end_dt_time     | examinationroom
---------------+-----------+-----------+-----------+---------------------+---------------------+-----------------
      13216584 | 100000001 |       101 |         1 | 2008-04-24 10:00:00 | 2008-04-24 11:00:00 | A
      26548913 | 100000002 |       101 |         2 | 2008-04-24 10:00:00 | 2008-04-24 11:00:00 | B
      36549879 | 100000001 |       102 |         1 | 2008-04-25 10:00:00 | 2008-04-25 11:00:00 | A
      46846589 | 100000004 |       103 |         4 | 2008-04-25 10:00:00 | 2008-04-25 11:00:00 | B
      59871321 | 100000004 |           |         4 | 2008-04-26 10:00:00 | 2008-04-26 11:00:00 | C
      69879231 | 100000003 |       103 |         2 | 2008-04-26 11:00:00 | 2008-04-26 12:00:00 | C
      76983231 | 100000001 |           |         3 | 2008-04-26 12:00:00 | 2008-04-26 13:00:00 | C
      86213939 | 100000004 |       102 |         9 | 2008-04-27 10:00:00 | 2008-04-21 11:00:00 | A
      93216548 | 100000002 |       101 |         2 | 2008-04-27 10:00:00 | 2008-04-27 11:00:00 | B

Sample table: nurse
 employeeid |      name       |  position  | registered |    ssn
------------+-----------------+------------+------------+-----------
        101 | Carla Espinosa  | Head Nurse | t          | 111111110
        102 | Laverne Roberts | Nurse      | t          | 222222220
        103 | Paul Flowers    | Nurse      | f          | 333333330

Sample table: prescribes
 physician |  patient  | medication |        date         | appointment | dose
-----------+-----------+------------+---------------------+-------------+------
         1 | 100000001 |          1 | 2008-04-24 10:47:00 |    13216584 | 5
         9 | 100000004 |          2 | 2008-04-27 10:53:00 |    86213939 | 10
         9 | 100000004 |          2 | 2008-04-30 16:53:00 |             | 5

Sample table: medication
 code |     name     |         brand         | description
------+--------------+-----------------------+-------------
    1 | Procrastin-X | X                     | N/A
    2 | Thesisin     | Foo Labs              | N/A
    3 | Awakin       | Bar Laboratories      | N/A
    4 | Crescavitin  | Baz Industries        | N/A
    5 | Melioraurin  | Snafu Pharmaceuticals | N/A

Sample table: undergoes
  patient  | procedure | stay |        date         | physician | assistingnurse
-----------+-----------+------+---------------------+-----------+----------------
 100000001 |         6 | 3215 | 2008-05-02 00:00:00 |         3 |            101
 100000001 |         2 | 3215 | 2008-05-03 00:00:00 |         7 |            101
 100000004 |         1 | 3217 | 2008-05-07 00:00:00 |         3 |            102
 100000004 |         5 | 3217 | 2008-05-09 00:00:00 |         6 |
 100000001 |         7 | 3217 | 2008-05-10 00:00:00 |         7 |            101
 100000004 |         4 | 3217 | 2008-05-13 00:00:00 |         3 |            103

Sample table: stay
 stayid |  patient  | room |     start_time      |      end_time
--------+-----------+------+---------------------+---------------------
   3215 | 100000001 |  111 | 2008-05-01 00:00:00 | 2008-05-04 00:00:00
   3216 | 100000003 |  123 | 2008-05-03 00:00:00 | 2008-05-14 00:00:00
   3217 | 100000004 |  112 | 2008-05-02 00:00:00 | 2008-05-03 00:00:00

physician:
employeeid – this is a unique ID of a physician
name – this is the name of a physician
position – this is the designation of a physician
ssn – this is a security number of a physician

department:
departmentid – this is a unique ID for a department
name – this is the name of a department
head – this is the ID of the physician who is the head of a department, referencing to the column employeeid of the table physician

affiliated_with:
physician – this is the ID of the physicians which is referencing to the column employeeid of the physician table
department – this is the ID the department which is referencing to the column departmentid of the department table
primaryaffiliation – this is a logical column which indicate that whether the physicians are yet to be affiliated or not
Note: The combination of physician, department will come once in that table.

procedure:
code – this is the unique ID of a medical procedure
name – the name of the medical procedure
cost – the cost for the procedure

trained_in:
physician – this is ID of the physicians which is referencing to the column employeeid of the physician table
treatment – this is the ID of the medical procedure which is referencing to the column code of the procedure table
certificationdate – this is the starting date of certification
certificationexpires – this is the expiry date of certification
Note: The combination of physician and treatement will come once in that table.

patient:
ssn – this is a unique ID for each patient
name – this is the name of the patient
address – this is the address of the patient
phone – this is the phone number of the patient
insuranceid – this is the insurance id of the patient
pcp – this is the ID of the physician who primarily checked up the patient which is referencing to the column employeeid of the physician table

nurse:
employeeid – this is the unique ID for a nurse
name – name of the nurses
position – the designation of the nurses
registered – this is a logical column which indicate that whether the nurses are registered for nursing or not
ssn – this is the security number of a nurse

appointment:
appointmentid – this is the unique ID for an appointment
patient – this is the ID of each patient which is referencing to the ssn column of patient table
prepnurse – the ID of the nurse who may attend the patient with the physician, which is referencing to the column employeeid of the nurse table
physician – this is the ID the physicians which is referencing to the employeeid column of the physician table
start_dt_time – this is the schedule date and approximate time to meet the physician
end_dt_time – this is the schedule date and approximate time to end the meeting
examinationroom – this the room where to meet a patient to the physician

medication:
code – this is the unique ID for a medicine
name – this is the name of the medicine
brand – this is the brand of the medicine
description – this is the description of the medicine

prescribes:
physician – this is the ID of the physician referencing to the employeeid column of the physician table
patient – this is the ID of the patient which is referencing to the ssn column of the patient table
medication – the ID of the medicine which is referencing to the code of the medication table
date – the date and time of the prescribed medication
appointment – the prescription made by the physician to a patient who may taken an appointment which is referencing to column appointmentid of appointment table
dose – the dose prescribed by the physician
Note: The combination of physician, patient, medication, date will come once in that table.

block:
blockfloor – ID of the floor
blockcode - ID of the block
Note: The combination of blockfloor, blockcode will come once in that table.

room:
roomnumber – this is the unique ID of a room
roomtype – this is type of room
blockfloor - this is the floor ID where the room in
blockcode – this is the ID of the block where the room in
unavailable – this is the logical column which indicate that whether the room is available or not
Note: The of blockfloor, blockcode columns are refercing to the combination of blockfloor and blockcode columns of the table block.

on_call:
nurse – this is ID of the nurse which is referencing to the employeeid column of the table nurse
blockfloor - this is the ID of the floor
blockcode – this is the ID of block
oncallstart - the starting date and time of on call duration
oncallend – the ending date and time of on call duration
Note: The combination of nurse, blockfloor, blockcode, oncallstart, oncallend will come once in that table and the combination of blockfloor, blockcode columns are refercing to the combination of blockfloor and blockcode columns of the table block .

stay:
stayid - this is unique ID for the admission
patient – this is the ID of the patient which is referencing the ssn column of patient table
room - this is the ID of the room where the patient admitted and which is referencing to the roomnumber column of the room table
start_time – this is the time when a patient admitted
end_time – this is the time how long a patient is staying

undergoes:
patient - this is ID of the patient which is referencing to the ssn column of the patient table
procedure – this is ID of the procedure and referencing to the code column of the procedure table
stay - this is the ID admission of a patient, which is referencing to the stayid column of the stay table
date – this is the date when a patient undergoes for a medical procedure
physician – this is the ID of a physician which is referencing to the column employeeid of the table physician
assistingnurse – this is the ID of a nurse who will assists the physician, referencing to the column employeeid of the table nurse
Note: The combination ofpatient, procedure, stay, date will come once in that table.
The database for hospital management system used for this exercises is based upon a database available in wikipedia. Sturcture and Data are may have gone through alterations sporadically.
*/

#The database for hospital management system used for this exercises is based upon a database available in wikipedia. Sturcture and Data are may have gone through alterations sporadically.  Wikipedia:  https://en.wikibooks.org/wiki/SQL_Exercises/The_Hospital