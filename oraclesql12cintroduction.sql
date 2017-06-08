/* Run a query shortcut keys are ctrl+enter and F9.  Use semicolons to terminate SQL statements.  Can write many SQL statements and execute one of the statements.  Semicolons separate many SQL statements.  Forward slash used below end SQL statement on new line  */
/* char() fixed-length character data.  Set char(100).  If data is 10, database saves data as 100. */
/* number(p,s) s is the decimal length to the right of decimal */
/* long variable-length character data up to 2GB. */
/* sql statements are not case sensitive. ctrl+shift+quote changes uppercase and lowercase and initial cap.  ctrl+d clears entire query builder  */

select *
from employees
/
describe employees;
desc employees; /*describe or desc works to display table's columns and its type */
select first_name, last_name, email
from employees;