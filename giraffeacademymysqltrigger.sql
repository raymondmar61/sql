#Triggers.  Trigger is SQL code to define a certain action when a certain operation is performed.  Triggers are defined in the commandline.
create table trigger_test
(message varchar(100));
#mysql -u root -p Type the Linux code in commandline to access MySQL in Command Line
#use giraffe Type the Linux code to use the giraffe database
#Create a trigger to insert a value in trigger_test table when a new employee is added in employee table.  Three copy and paste.  First copy and paste to Command Line is delimiter $$.  Second copy and paste to Command Line is the code.  Third copy and paste to Command Line is delimiter ;.
delimiter $$ #The delimiter are placeholders writing triggers for the .sql file.  Also, the two delimiter changes the default semicolon ; ending a sql statement by changing from semicolon ; to two dollar sings $$, and then changes back to semicolon.
create trigger triggernamemy_trigger
before insert on employee
for each row begin
    insert into trigger_test
    values('Added new employee');
end$$
delimiter ;
insert into employee
values(109,'Oscar','Martinez','1968-02-19','M',69000,106,3);
select *
from trigger_test;
/*
# message
'Added new employee'
*/
delimiter $$ #The delimiter are placeholders writing triggers for the .sql file.  Also, the two delimiter changes the default semicolon ; ending a sql statement by changing from semicolon ; to two dollar sings $$, and then changes back to semicolon.  Yes, copy and paste three separate times the two delimiters and the trigger sql code to create the new trigger triggernamemy_trigger2
create trigger triggernamemy_trigger2
before insert on employee
for each row begin
    insert into trigger_test
    values(concat('Added new employee ',new.first_name,new.last_name));
end$$
delimiter ;
drop trigger triggernamemy_trigger2; #delete trigger on commandline
insert into employee
values(110,'Kevin','Malone','1978-02-19','M',69000,106,3);
select *
from trigger_test; #triggers compounds each other
/*
# message
'Added new employee'
'Added new employee'
'Added new employee KevinMalone'
*/
select *
from employee;
/*
# emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id
'100', 'David', 'Wallace', '1967-11-17', 'M', '250000', NULL, '1'
'101', 'Jan', 'Levinson', '1961-05-11', 'F', '110000', '100', '1'
'103', 'Angela', 'Martin', '1971-06-25', 'F', '63000', NULL, NULL
'104', 'Kelly', 'Kapoor', '1980-02-05', 'F', '55000', NULL, NULL
'105', 'Stanley', 'Hudson', '1958-02-19', 'M', '69000', NULL, NULL
'106', 'Josh', 'Porter', '1969-09-05', 'M', '78000', '100', '3'
'107', 'Andy', 'Bernard', '1973-07-22', 'M', '65000', '106', '3'
'108', 'Jim', 'Halpert', '1978-10-01', 'M', '71000', '106', '3'
'109', 'Oscar', 'Martinez', '1968-02-19', 'M', '69000', '106', '3'
'110', 'Kevin', 'Malone', '1978-02-19', 'M', '69000', '106', '3'
*/
delimiter $$ #The delimiter are placeholders writing triggers for the .sql file.  Also, the two delimiter changes the default semicolon ; ending a sql statement by changing from semicolon ; to two dollar sings $$, and then changes back to semicolon.
create trigger triggernamemy_triggerconditional
before insert on employee
for each row begin
    if new.sex = 'M' then
        insert into trigger_test values(concat('Added male employee ',new.first_name,'_',new.last_name));
    elseif new.sex = 'F' then
        insert into trigger_test values(concat('Added female employee ',new.first_name,'_',new.last_name));
    else
        insert into trigger_test values(concat('Added other employee ',new.first_name,'_',new.last_name));
    end if;
end$$
delimiter ;
insert into employee
values(111,'Pam','Beesly','1988-02-19','F',69000,106,3);
select *
from trigger_test; #triggers compounds each other
/*
# message
'Added new employee'
'Added new employee'
'Added new employee KevinMalone'
'Added new employee'
'Added new employee PamBeesly'
'Added female employee Pam_Beesly'
*/
select *
from employee;
/*
# emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id
'100', 'David', 'Wallace', '1967-11-17', 'M', '250000', NULL, '1'
'101', 'Jan', 'Levinson', '1961-05-11', 'F', '110000', '100', '1'
'103', 'Angela', 'Martin', '1971-06-25', 'F', '63000', NULL, NULL
'104', 'Kelly', 'Kapoor', '1980-02-05', 'F', '55000', NULL, NULL
'105', 'Stanley', 'Hudson', '1958-02-19', 'M', '69000', NULL, NULL
'106', 'Josh', 'Porter', '1969-09-05', 'M', '78000', '100', '3'
'107', 'Andy', 'Bernard', '1973-07-22', 'M', '65000', '106', '3'
'108', 'Jim', 'Halpert', '1978-10-01', 'M', '71000', '106', '3'
'109', 'Oscar', 'Martinez', '1968-02-19', 'M', '69000', '106', '3'
'110', 'Kevin', 'Malone', '1978-02-19', 'M', '69000', '106', '3'
'111', 'Pam', 'Beesly', '1988-02-19', 'F', '69000', '106', '3'
*/
#triggers valid for insert, update, or delete such as before update.  Also after such as after delete.