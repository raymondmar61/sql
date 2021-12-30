select e.emp_name as "Employee Name", e.emp_id as "Employee ID", m.emp_name as "Manager Name", e.manager_id as "Manager ID"
from employees e inner join employees m
on e.manager_id = m.emp_id
order by e.emp_id;  #RM:  there is no Kayling because she doesn't have a manager
/*
Employee Name   Employee ID Manager Name    Manager ID  
SANDRINE    63679   FRANK   69062   
ADELYN  64989   BLAZE   66928   
WADE    65271   BLAZE   66928   
JONAS   65646   KAYLING 68319   
MADDEN  66564   BLAZE   66928   
BLAZE   66928   KAYLING 68319   
CLARE   67832   KAYLING 68319   
SCARLET 67858   JONAS   65646   
TUCKER  68454   BLAZE   66928   
ADNRES  68736   SCARLET 67858   
JULIUS  69000   BLAZE   66928   
FRANK   69062   JONAS   65646   
MARKER  69324   CLARE   67832   
*/
select e.emp_name as "Employee Name", e.emp_id as "Employee ID", m.emp_name as "Manager Name", e.manager_id as "Manager ID"
from employees e left join employees m
on e.manager_id = m.emp_id
order by e.emp_id;  #RM:  Kayling is included even though she doesn't have a manager
/*
Employee Name   Employee ID Manager Name    Manager ID  
SANDRINE    63679   FRANK   69062   
ADELYN  64989   BLAZE   66928   
WADE    65271   BLAZE   66928   
JONAS   65646   KAYLING 68319   
MADDEN  66564   BLAZE   66928   
BLAZE   66928   KAYLING 68319   
CLARE   67832   KAYLING 68319   
SCARLET 67858   JONAS   65646   
KAYLING 68319   NULL    NULL    
TUCKER  68454   BLAZE   66928   
ADNRES  68736   SCARLET 67858   
JULIUS  69000   BLAZE   66928   
FRANK   69062   JONAS   65646   
MARKER  69324   CLARE   67832   
*/

create view employeedepartmentname as
    select e.emp_name, e.dep_id, d.dep_name
    from employees e inner join department d
    on e.dep_id = d.dep_id;
select *
from employeedepartmentname;
/*
emp_name    dep_id  dep_name    
KAYLING 1001    FINANCE 
BLAZE   3001    MARKETING   
CLARE   1001    FINANCE 
JONAS   2001    AUDIT   
SCARLET 2001    AUDIT   
FRANK   2001    AUDIT   
SANDRINE    2001    AUDIT   
ADELYN  3001    MARKETING   
WADE    3001    MARKETING   
MADDEN  3001    MARKETING   
TUCKER  3001    MARKETING   
ADNRES  2001    AUDIT   
JULIUS  3001    MARKETING   
MARKER  1001    FINANCE 
*/

select emp_name, dep_name
from employeedepartmentname
where dep_name in ('FINANCE','AUDIT');
/*
emp_name    dep_name    
KAYLING FINANCE 
CLARE   FINANCE 
JONAS   AUDIT   
SCARLET AUDIT   
FRANK   AUDIT   
SANDRINE    AUDIT   
ADNRES  AUDIT   
MARKER  FINANCE
*/
drop view employeedepartmentname;