--Oracle SQL by Example by Alice Rischert
--RM:  close file at top to review Oracle commands and shortcuts.
--Ctrl+D clear
--Shift+F4 opens Popup Describe window on an object.  Similarily, hold Ctrl and double click object to view object information.
--Ctrl+F7 quick syntax formatting
--Ctrl+Shift+Quote toggle uppecase and lowercase
--Ctrl+Shift+Enter appears to show query builder only
--Press SQL button at Query Results shows the SQL statements
--You can drag tables listed in the Connections navigator into the SQL Worksheet. When you do this, you construct a SELECT statement with all columns in the table. If desired, you can then edit the statement further.
--You need to end each SQL statement with a semicolon (;) or type a forward slash (/) on a new line; otherwise, SQL Developer displays an error.
--If you want to run both statements at once, you need to run the statements as a script by clicking the Run Script icon (F5).  RM:  highlight multiple statements, press Ctrl+Enter.
--F8 is SQL History.  Can search history.
--The Single Record View window allows you to examine one record at a time and scroll through the records.  Right mouse click anywhere in Query Results.
--The Auto-fit menu options are very useful for formatting the Results window according to the length of the data cells or the length of the column name.  Right mouse click columns at Query Results.
--View-->Snippets.  Snippets is a window containing SQL functions or syntax examples.  Hovering over the function reveals a brief description of the function.  Drag the SQL to the Worksheet.  e,g, Date/Time Functions.  The Snippets window lists commonly used functions, expressions, and code fragments. It does not provide a complete list of all available functions and syntax options in Oracle SQL. You can customize the snippets and add frequently used code fragments or functions.
--Comments --for single line /* ... */ for multi-line
--When you define a table alias in SQL Developer, any subsequent reference of the alias brings up a list of columns for the table, helping you remember the column names and avoid column misspellings (see Figure 7.4 page 289).
--Right mouse click select Split Vertically or Split Horizontally split displays multiple views.  e.g. see multiple views same table.  See a table and SQL query builder.  Also New Document Tab Group.  Page 494.

--CHAPTER 1 SQL AND DATA 1 book page (44 pdf page)
--A table may have only one primary key, which consists of one or more columns. If the primary key contains multiple columns, it is referred to as a composite primary key, or concatenated primary key.
--Data Manipulation Language (DML) select, insert, update, delete, merge
--Data Definition Language (DDL) create, alter, drop, truncate, rename
--Data Control Language (DCL) grant, revoke
--Transaction Control commit, rollback, savepoint
--Normalization is to eliminate redundancy in tables, therefore avoiding any future data manipulation problems. There are a number of different rules for minimizing duplication of data, which are formulated into the various normal forms.  Although there are many normalization rules, the five normal forms and the Boyce–Codd normal form (BCNF) are the most widely accepted. This lab discusses the first three normal forms because programmers and analysts typically don’t bother normalizing beyond third normal form—although experienced database designers sometimes do.
--For a table to be in first normal form, all repeating groups must be removed and placed in a new table.  e.g. a book table has three location columns location1, location2, and location3.  Solution is create a book location table with two columns bookid and location.  bookid 1010 has New York one entry, bookid 1010 has San Francisco second entry, bookid 1010 has Chicago third entry.  Three bookid 1010 entries with its locations.
--For a table to be in second normal form, all nonkey columns must depend on the entire primary key. It applies only to tables that have composite primary keys.  e.g. BOOK_AUTHOR table with both the BOOK_ID and AUTHOR_ID as the composite primary key. In this example, authors with the ID 900 and 901 coauthored the book with the ID 10002. If you add the author’s phone number to the table, the second normal form is violated because the phone number is dependent only on the AUTHOR_ID, not on BOOK_ID. ROYALTY_ SHARE is dependent completely on the combination of both columns because the percentage of the royalty varies from book to book and is split among authors.  RM:  solution add phone number to the author table
--For a table to be in third normal form, every nonkey column must be a fact about the primary key.  e.g. The PUBLISHER_PHONE_NO column is not dependent on the primary key column BOOK_ID but on the PUBLISHER_NAME column. Therefore, the PUBLISHER_PHONE_NO column should not be part of the BOOK table.  Instead, the publisher’s phone number should be stored in a separate table called PUBLISHER. This has the advantage that when a publisher’s phone number is updated, it needs to be updated in only one place rather than at all occurrences of this publisher in the BOOK table. Removing the PUBLISHER_PHONE_NO column eliminates redundancy and avoids any possibilities of data inconsistencies.
--One-to-many relationship one individual customer can have many order rows in the order table
--One-to-one relationship every row in the product table has one matching row in the product price table.  However, data from both tables are combined into one table mostly.
--Many-to-many relationship one book can have one or more authors and one author can write one or more books.  The relational database model requires the resolution of many-to-many relationships into one-to-many relationship tables.  The solution in this example is achieved by creating an associative table (also called an intersection table) via the BOOK_AUTHOR table.
--In the real world, you typically see only two types of relationships: first, mandatory on the “one” side and optional on the “many” end; and second, optional on both ends.  For example, mandatory relationships on both sides are infrequently implemented; this means that rows must be inserted in both tables simultaneously. Occasionally, you find one-to-one relationships, but most often, the columns from both tables are combined into one table. Many-to-many relationships are not allowed in the relational database; they must be resolved via an associative, or intersection, table into one-to-many relationships.
--The student table does not show the city and state. This information can be looked up via the foreign key column zip, as indicated with the “(FK)” symbol after the column name.
--A recursive, or self-referencing, relationship implies a column in a table refers to another column in the same table.  Recursive relationships are always optional.
--Student database tables:  student, course, section, instructor, zipcode, enrollment, grade_type, grade, grade_type_weight, grade_conversion

--CHAPTER 2 SQL: THE BASICS 49 book page (92 pdf page)
select description, cost
from course;
--You can drag tables listed in the Connections navigator into the SQL Worksheet. When you do this, you construct a select statement with all columns in the table. If desired, you can then edit the statement further.
--The use of the distinct or unique keyword in the select list eliminates duplicate data in the result set.
select distinct zip
from instructor;
select unique zip
from instructor;
--Skipped An Introduction to SQL*Plus 81 (124)

--CHAPTER 3 THE WHERE AND ORDER BY CLAUSES 101 (144)
select first_name, last_name, phone
from instructor
where last_name = 'Schorin';
select first_name, last_name, phone
from instructor
where last_name <> 'Schorin';  --not equal <> or != works Oracle
select description, cost
from course
where cost >= 1195;
select description, cost
from course
where cost between 1000 and 1100;  --between is inclusive
select description, cost
from course
where cost in (1095,1595);
select first_name, last_name, phone
from instructor
where last_name like 'S%';
select first_name, last_name, phone
from instructor
where last_name like '_o%';  --% is like * and _ is single character
--RM:  reminder There is no rule about columns in the where clause having to exist in the select list.
select description, prerequisite
from course
where prerequisite is null;
select description, prerequisite
from course
where cost = 1095 and description like 'I%';
select description, cost, prerequisite
from course
where cost = 1195 and (prerequisite = 20 or prerequisite = 25);
--You can apply the BETWEEN functions to text columns which utilizes the BETWEEN operator with text literals W and Z
select student_id, last_name
from student
where last_name between 'W' and 'Z';
--same as
select student_id, last_name
from student
where last_name between 'W%' and 'Z%';
select description
from grade_type
where description between 'Midterm' and 'Project';
--same as
select description
from grade_type
where description >= 'Midterm' and description <= 'Project';
select rownum, last_name, student_id
from student
where rownum <=10; --The rownum pseudocolumn is useful if you want to limit the number of rows returned by a query.
select distinct cost
from course
where prerequisite is null;
select course_no, description
from course
where prerequisite is null
order by description desc;
select first_name, last_name
from student
where zip = '10025'
order by student_id;  --it is also possible to use ORDER BY on columns that are not selected.  
select distinct first_name, last_name, student_id
from student
where zip = '10025'
order by student_id;  --However, If the select list contains distinct, the column(s) the keyword pertains to must also be listed in the order by clause.
select distinct cost
from course
order by cost;
--You can change the ordering of the nulls with the nulls first or nulls last option in the ORDER BY clause.  nulls on top nulls top.
select distinct cost
from course
order by cost nulls first;
select first_name first, first_name as "First"
from student
order by "First";  --column alias. can even sort by column alias
select salutation, first_name, last_name
from student
where last_name = 'Grant'
order by salutation desc, first_name asc;
select salutation, first_name, last_name
from student
where last_name = 'Grant'
order by 1 desc, 2 asc;  --column position.  can even sort by column position

--CHAPTER 4 CHARACTER, NUMBER, AND MISCELLANEOUS FUNCTIONS 133 (176)
select state, lower(state), lower('STate')
from zipcode;
select city, upper(city), state, initcap(state)
from zipcode;
--The LPAD and RPAD functions also transform data: They left pad and right pad strings, respectively. When you pad a string, you add to it. These functions can add characters, symbols, or even spaces to your result set.
select city, rpad(city,20,'*') as "city fill to 20 char * right", state, lpad(state,10,'-') as "state fill to 10 char - left"
from zipcode; --Santurce,Santurce************,PR,--------PR
select city, rpad(city,20) as "city fill to 20 w/spaces right"
from zipcode;  --default rpad and lpad is spaces
select ('0001234500'), ltrim('0001234500','0') as "1234500", rtrim('0001234500','0') as "00012345", ltrim(rtrim('0001234500','0'),'0') as "12345"
from dual;
select ('0001234500'), trim(both '0' from '0001234500') as "12345", trim(leading '0' from '0001234500') as "1234500", trim(trailing '0' from '0001234500') as "00012345"  --RM:  both is option.  The TRIM function removes leading characters, trailing characters, or both, effectively doing the job of LTRIM and RTRIM in one function.  TRIM doesn't remove character inside a string.
from dual;
select ('     00012345  00 00  '), trim('     00012345  00 00  ') as "remove spaces 00012345  00 00"
from dual;
select last_name, substr(last_name,1, 5) as "start 1, get 5 characters", substr(last_name,6) as "start 6, get rest characters"
from student;  --substring returns part string.  If starting_position is a negative number, Oracle starts counting from the end of the string.
select description, instr(description, 'er') as "find 'er' position return #"
from course
order by 2 desc; --in string looks for the occurrence of a string inside another string, returning the starting position of the search string within the target string.  ordered by desc to see the 'er's easier.
--same as even better
select description, instr(description, 'er') as "find 'er' position return #"
from course
where instr(description, 'er') > 1;
--INSTR(char1, char2 [,starting_position [, occurrence]]).  INSTR can take two optional input parameters. The third parameter allows you to specify the start position for the search. The fourth parameter specifies which occurrence of the string to look for. When these optional parameters are not used, the default value is 1.  char1 is string.  char2 is what to look for in string.
select last_name, length(last_name)
from student;  --The LENGTH function determines the length of a string, expressed as a number
--Using functions in where and order by clauses
select first_name, last_name
from student
where substr(last_name,1, 2) = 'Mo';  --uses the SUBSTR function in the WHERE clause to search for student last names that begin with 'Mo'
--same as
select first_name, last_name
from student
where last_name like 'Mo%';
select first_name, last_name
from student
where instr(first_name,'.') > 0
order by length(last_name);
--same as
select first_name, last_name
from student
where first_name like '%.%'
order by length(last_name);
--Nested functions
select city, rpad(upper(city),20,'.') as "CITY fill to 20 char . right"
from zipcode;
select first_name
from student;
select first_name, instr(first_name,'.') as "find .", substr(first_name,1,instr(first_name,' ')-1) as "first name no spaces",substr(first_name,instr(first_name,'.')-1,2) as "middle initial ."
from student
where instr(first_name,'.') > 3;
--same as book better because what if first name two words
select first_name, substr(first_name, instr(first_name, '.')-1) mi, substr(first_name, 1, instr(first_name, '.')-2) first
from student
where instr(first_name, '.') >= 3;
--same as my way better than book because book way first name yes spaces
select first_name, instr(first_name,'.') as "find .", substr(first_name,1,instr(first_name,'.')-3) as "first name no spaces",substr(first_name,instr(first_name,'.')-1,2) as "middle initial ."
from student
where instr(first_name,'.') > 3
--There are two methods of concatenation in Oracle: One is with the CONCAT function, the other is the concatenation operator (||), which is two vertical bars or pipe symbols.  CONCAT accepts two parameters only.
select concat(city, state)
from zipcode;
select city || ', ' || state
from zipcode;
select replace('My replacehand is asleep', 'replacehand', 'withfoot')
from dual;  --The replace function replaces one string with another string.  replace(char, if, then)
--the TRANSLATE function provides a one-for-one character substitution. For instance, it allows you to determine whether all the phone numbers in the STUDENT table follow the same format. In the next query, TRANSLATE substitutes the # character for every character from 0 to 9. Then the values are checked against the ‘###-###-####’ format.
select phone
from student
where translate(phone,'0123456789','#########') <> '###-###-####';
--The SOUNDEX function allows you to compare differently spelled words that phonetically sound alike. The next query uses the SOUNDEX function to display students whose last name sounds like Martin.  sounds like.
select student_id, last_name
from student
where soundex(last_name) = soundex('martin');
/*
The backslash (\) sign is selected as the escape character to indicate that the underscore character following the character is to be interpreted as a literal underscore and not as the wildcard underscore.
SELECT student_id, employer
FROM student
WHERE employer LIKE '%B\_B%' ESCAPE '\';
*/
select (-29), abs(-29)
from dual; --absolute value
select -14, sign(-14), sign (14), sign(0)
from dual; --sign function tells you the sign. 1 for positive, -1 for negative, 0 for zero
select 222.34501, round(222.34501,1) as "222.3", round(222.34501,2) as "222.35", round(222.34501,3) as "222.345", round(222.34501,4) as "222.345", trunc(222.34501, 2) as "222.34", trunc(222.34501, 0) as "222"
from dual;  --round and trunicate
select 222.34501, round(222.34501,-1) as "220", round(222.34501,-2) as "200", trunc(222.34501, -1) as "220", trunc(222.34501, -2) as "200"
from dual;  --round and trunicate can be used to affect the left side of the decimal as well by passing a negative number as a parameter.
select 22.5, floor(22.5) as "22", ceil(22.5) as "23", trunc(22.5) as "22", round(22.5) as "23"
from dual;  --ceiling and floor
select mod(23,8) as "7"
from dual;  --modulus or remainder of a value divided by another value.  mod(value,divisor) 23/8=2 remainder 7
select distinct cost, cost+10, cost-10, cost*10, cost/10
from course;
select distinct cost, cost + (cost * .10)
from course;
--The nvl function replaces a NULL value with a default value.  When you substitute a value, the data type of the substituted value must agree with the data type of the input parameter.  Use to_char to convert to varchar2.  nvl(input_expression, substitution_expression).
select prerequisite, nvl(prerequisite,0)
from course;
select course_no, description, nvl(to_char(prerequisite),'Not Applicable') as prerequisite
from course;
--The coalesce function is similar to the nvl function.  You can optionally evaluate multiple substitution columns or substitution expressions. The syntax is as follows:  coalesce(input_expression, substitution_expression_1,[, substitution_expression_n])
select student_id, midterm_grade, finalexam_grade, quiz_grade, coalesce(midterm_grade, finalexam_grade, quiz_grade) "coalesce column"
from grade_summary;
--The nvl2 function ichecks for both not null and null values and has three parameters versus nvl’s two parameters. The syntax for the function is as follows:  nvl2(input_expr, not_null_substitution_expr, null_substitution_expr)
select prerequisite, nvl2(to_char(prerequisite), 'Yes there''s prereq', 'No prereq')  --escape for single quotes use double quotes
from course;
--The lnnvl function can be used only in the WHERE clause of a SELECT statement. It returns either true or false. It returns true and therefore a result if the condition is either false or unknown.  RM:  lnnvl returns the oppposite or null.
select course_no, cost
from course
where lnnvl(cost < 1500);  --returns cost greater than 1500 or null
--The nullif function is unique in that it generates null values. The function compares two expressions; if the values are equal, the function returns a null; otherwise, the function returns the first expression.  nullif(expression1, equal_expression2)
select student_id, to_char(created_date, 'dd-mon-yy hh24:mi:ss') "created", to_char(modified_date, 'dd-mon-yy hh24:mi:ss') "modified", nullif(created_date, modified_date) "null two dates are equal"
from student;
--The decode function substitutes values based on a condition, using if-then-else logic. If a value is equal to another value, the substitution value is returned. If the value compared is not equal to any of the listed expressions, an optional default value can be returned. The syntax code for the decode function is as follows. decode(if_expr, equals_search, then_result [,else_default]).  If then else.  If else.  The search and result values can be repeated.  RM:  like a replace also replace null.  RM::case better than decode.
select distinct state, decode(state, 'NY', 'new york', 'NJ', 'new jersey') as "null when not NY NJ", decode(state, 'NY', 'new york', 'NJ', 'new jersey', 'otherdefault') as "otherdefault when not NY NJ"
from zipcode;
select zip, decode(zip, null, 'no zipcode', zip) as "no zipcode when null"
from instructor;
--The decode function does not allow greater than or less than comparisons; however, combining the decode function with the sign function overcomes this shortcoming.
/*The following select statement combines the decode and sign functions to display the course cost as 500 for courses that cost less than 1195. If the course cost is greater than or equal to 1195, the actual cost is displayed. The calculation of the value in the cost column minus 1195 results in a negative number, a positive number, a zero, or null. The sign function determines the sign of the calculation and returns, respectively, –1, +1, 0, or null. The decode function checks whether the result equals –1. If it does, this indicates that the cost is less than 1195, and the decode function returns 500; otherwise, the regular cost is shown.*/
select course_no, cost, sign(cost-1195), decode(sign(cost-1195),-1,500,cost) as "sign-1 then 500 otherwise cost"
from course;  --if sign=-1, then 500; otherwise cost
--same as
select course_no, cost, case when cost < 1195 then 500 else cost end as "test case"
from course;
--case expression if-then-else if then else if else logic.  Each case expression starts with the keyword case and ends with the keyword end.
select course_no, cost, case
	when cost < 1100 then 1000
	when cost >= 1000 and cost < 1500 then cost * 1.1
	when cost is null then 0
	else cost
  	end as "test case"
from course;
select course_no, cost, prerequisite, case
	when cost < 1100 then
		case
			when prerequisite in (10,50) then cost/2
			else cost
		end
	when cost >= 1100 and cost < 1500 then cost*1.1
	when cost is null then 0
	else cost
	end as "test case"
from course;
select capacity, location
from section
where capacity*case
	when substr(location,1,1)='L' then 2
	when substr(location,1,1)='M' then 1.5
	else null
	end
>30;
select section_id, capacity, case
	when capacity >=15 then to_char(capacity)
	when capacity < 15 then 'Room too small'
	end as "Capacity"
from section;  --use to_char to match data types as characters or convert numbers to character or string
select course_no, cost, case
	when cost = 1095 then cost / 2
	when cost = 1195 then cost * 1.1
	when cost = 1595 then cost
	else cost * 0.5
	end as "any cost adjustment"
from course;
--same as
select course_no, cost, case cost
	when 1095 then cost / 2
	when 1195 then cost * 1.1
	when 1595 then cost
	else cost * 0.5
	end as "any cost adjustment"
from course;
/* Summary page 178 RM:  short answer is if then else if-then-else if else SQL statements
NVL(input_expression, substitution_expression) Null value replacement.
COALESCE(input_expression, substitution_expression_1, [, substitution_expression_n]) Null value replacement with multiple substitution expressions.
NVL2(input_expr, not_null_substitution_expr, null_substitution_expr) Null and not null substitution replacement.
LNNVL(condition) Returns true if the condition is false or unknown. Returns false if the condition is true.
NULLIF(expression1, equal_expression2) Returns null if the value of two expressions are identical; otherwise, returns first expression.
NANVL(input_value, substitution_value) Returns a substitution value in the case of NAN (not a number) value.
DECODE (if_expr, equals_search, then_result [,else_default]) Substitution function based on if-then-else logic.
CASE {WHEN cond THEN return_expr [WHEN cond THEN return_ expr]…} [ELSE else_expr] END Searched CASE expression. It allows for testing of null values and other comparisons.
CASE {expr WHEN expr THEN return_expr [WHEN expr THEN return_expr]…} [ELSE else_expr] END The simple CASE expression tests for equality only.No greater than, less than, or IS NULL comparisons are allowed.
*/

--CHAPTER 5 DATE AND CONVERSION FUNCTIONS 189 (232)
/* to_char(date [,format mask]) converts all datetime-related data types into varchar2 to display in a different format
to_date(char [,format mask]) converts text to a date data type. */
select last_name, registration_date
from student;  --RM:  my Oracle displays mm/dd/yyyy
select last_name, registration_date, to_char(registration_date, 'mm/dd') as "date 01/22"
from student;  --The to_char conversion function changes the date data type into text and applies a format mask.
--The to_date function does just the opposite of the to_char function: It converts a text literal into a date data type.
select last_name, to_char(registration_date, 'Dy') as "1.day", to_char(registration_date, 'Dy') as "2.day", to_char(registration_date, 'Month DD, YYYY') as "look at the month", to_char(registration_date, 'HH:MI PM') as "time"
from student;
--Here is a more elaborate example, which uses the fm mask to eliminate the extra spaces between the month and the date in the second column of the following result set. In addition, this format mask uses the th suffix on the day (dd) mask, to include the st, nd, rd, and th in lowercase after each number. The third and last column spells out the date using the sp format parameter, with the first letter capitalized by using the Dd format. Also, you can add a text literal, as in this case with the "of" text.
select last_name, to_char(registration_date, 'fmMonth ddth, YYYY') "eliminating spaces", to_char(registration_date, 'Ddspth "of" fmMonth') "spelled out"
from student;
--date search or search date
select last_name, registration_date
from student
where registration_date = to_date('22-jan-2007','dd-mon-yyyy');
--also
select last_name, registration_date
from student
where registration_date = '01/22/2007'  --RM:  my Oracle displays mm/dd/yyyy
/*  Check your Oracle date settings using the query below
select sys_context ('userenv', 'nls_date_format')
from dual;
*/
--The next query illustrates how a two-digit year gets interpreted with the RR format mask. The text literals '17-OCT-67' and '17-OCT-17' are converted to a date data type with the format mask DD-MON-RR. Then the to_char function converts the date data type back to text, but this time with a four-digit year. Effectively, the two-digit year 67 is interpreted as 1967, and the two-digit year literal 17 is interpreted as 2017.
select to_char(to_date('17-oct-67','DD-MON-RR'),'YYYY') "1900", to_char(to_date('17-oct-17','DD-MON-RR'),'YYYY') "2000"
from dual;
--The Oracle date data type includes the time. You can query records for a specific time or ignore the time altogether. The next SQL statement displays the time as part of the result set.  If no time component was included when the data was entered, Oracle assumes that the time is midnight, which is 12:00:00 AM, or 00:00:00 military time (HH24 time format mask).
select last_name, to_char(registration_date, 'DD-MON-YYYY hh24:mi:ss') as "22-JAN-2007 00:00:00"
from student;
select student_id, to_char(enroll_date, 'dd-mon-yyyy hh24:mi:ss')
from enrollment
where enroll_date >= date'2007-02-07'
and enroll_date < date '2007-02-08';  --specify a date format and time format in select and where clauses
--or
select student_id, enroll_date
from enrollment
where enroll_date >= '02/07/2007'
and enroll_date < '02/08/2007';  --RM:  remember the single quotes
--also when time is important
select student_id, to_char(enroll_date, 'dd-mon-yyyy hh24:mi:ss')
from enrollment
where enroll_date >= timestamp '2007-02-07 10:00:00'
and enroll_date < timestamp '2007-02-08 11:00:00';
--The SYSDATE function returns the computer operating system’s current date and time and does not take any parameters.
select sysdate, to_char(sysdate, 'DD-MM-YYYY HH24:MI') as "day-month-year 12:46"
from dual;
select sysdate, trunc(sysdate) as "12/14/2017"
from dual;
select sysdate, to_date('01/01/2017')-sysdate, trunc(to_date('01/01/2017')-sysdate) as "days remove decimal"
from dual;  
--To perform any date calculation, the column or text literal must be converted to the Oracle DATE data type.  RM:  for my Oracle, date can be MM/DD/YYYY format.
select sysdate, sysdate+3 as "three days later", to_date(sysdate+3/24, 'MM/DD/YYYY HH:MI') as "three hours later no time", to_char(sysdate+3/24, 'MM/DD/YYYY HH:MI') as "three hours later yes time", to_char(sysdate+1.5, 'MM/DD/YYYY HH24:MI') as "36 hours later"
from dual;  --date calculation.  Can't use to_date to display the time.  Use to_char.
--The extract function extracts the year, month, or day from a column of the date data type column. The next example shows rows with April values in the start_date_time column and how the various elements of the date data type can be extracted. Valid keyword choices are year, month, and day. You cannot extract hours, minutes, or seconds from the date data type.
select start_date_time, extract(month from start_date_time) as "month", extract(year from start_date_time) as "year", extract(day from start_date_time) as "day"
from section
where extract(month from start_date_time) = 4;  --RM added where clause to demonstrate narrowing results
--RM:  page 213 table 5.6 lists common date functions such as add-months(), months_between().  Also author suggests using snippets View-->Snippets to see Date/Time Functions.  RM:  Of course.
--RM:  skipped Lab 5.3 TIMESTAMP and TIME ZONE page 217
/* to_char(date [,format mask]) converts all datetime-related data types into varchar2 to display in a different format
to_date(char [,format mask]) converts text to a date data type. */
--RM:  skipped Lab 5.4 INTERVAL YEAR TO MONTH and INTERVAL DAY TO SECOND page 236
select *
from conversion_example
where course_no = '123';
--same as
select *
from conversion_example
where course_no = to_char(123);  --you may encounter cases in which you do not have control over the literal or in which you are comparing one table’s column against another table’s column.  use to_char()
--The cast function converts from one data type to another.  The syntax for the cast function is as follows. cast(expression AS data type)
select *
from conversion_example
where course_no = cast(123 as varchar2(3));
select 'Mar/29/2009', cast('Mar/29/2009' as date) as dt, cast('29-mar-09' as timestamp with local time zone) as tz
from dual;  --return Mar/29/2009; 03/29/2009; 29-MAR-09 12.00.00.000000000 AM
select section_id, start_date_time, to_char(start_date_time, 'DD-MM-YYYY')
from section
where start_date_time >= cast('01-Jul-2007' as date)
and start_date_time < cast('01-Aug-2007' as date);  --error message.  RM:  my pc date jul/1/2007 not 01-jul-2007
select section_id, start_date_time, to_char(start_date_time, 'DD-MM-YYYY')
from section
where start_date_time >= cast('jul/1/2007' as date)
and start_date_time < cast('aug/1/2007' as date);
select course_no, cost, to_char(cost, '999,999') as costwithcommas
from course;
--RM:  Table 5.16 page 255 common to_char number format models

--CHAPTER 6 AGGREGATE FUNCTIONS, GROUP BY, AND HAVING CLAUSES
--Aggregate functions allow you to generate summary data for a group of rows to obtain totals, averages, counts, minimum values, and maximum values.  Aggregate functions group together data to produce a single result.
select count(*)
from enrollment; #print 226
--count(*) counts rows that contain null values, whereas count with a column excludes rows that contain nulls.
select count(final_grade) as "1 row has a value", count(section_id), count(*)
from enrollment; #print 1; 226; 226
select count(distinct section_id), count(section_id)
from enrollment; #print 64; 226
select sum(capacity)
from section; #print 1652
select avg(capacity) as averagenullsareignred, avg(nvl(capacity,0)) as averageifnullthenzero
from section; #print 21.179487; 21.179487 nulls are ignored calculating average
select min(capacity), max(capacity)
from section; #print 10; 25
select min(registration_date) as "first date", max(registration_date) as "last date"
from student #print 01/22/2007; 02/23/2007
--A less frequently used data type for the min and max functions is the varchar2 data type
select min(description) as "first alphabeticaly", max(description) as "last alphabeticaly"
from course; #print Advanced Java Programming; Unix Tips and Techniques
--All aggregate functions learned so far ignores null values except count(*).  Use nvl or coalesce function to substitute for any null values.
--example below if then else aggregate if else aggregate if then aggregate
select avg(case 
	when prerequisite is null then cost*1.1
	when prerequisite = 20 then cost*1.2
	else cost
	end) as "avg based on conditions"
from course; #print 1256.13793
--The distinct keyword used for avg, sum, and count functions.
--The group by and having clauses allow you to categorize and aggregate data further.  The group by clause determines how rows are grouped.
select distinct location
from section;
--same as
select location
from section
group by location;
select location, count(*)
from section
group by location; #print how many times each group by location is listed in section table
select location, count(*), sum(capacity), min(capacity), max(capacity)
from section
group by location; #For each distinct location, you see the capacities aggregate functions
select location, instructor_id, count(*), sum(capacity), min(capacity), max(capacity)
from section
group by location, instructor_id
order by location; #The aggregate functions to the distinct values of the location and the instructor_id columns
--Every column you list in the select list, except the aggregate function column itself, must be repeated in the group by clause.  The columns used in the ORDER BY clause must appear in the SELECT list, which is unlike the normal use of order by when sorting.
--The purpose of the having clause is to eliminate groups, just as the where clause is used to eliminate rows.
select location, instructor_id, count(location), sum(capacity)
from section
group by location, instructor_id
having sum(capacity) > 50
order by sum(capacity) desc; #having clause restricts the result set to locations with a total capacity value of more than 50 students
select location, instructor_id, count(location) "Total Locations", sum(capacity) "Total Capacity"
from section
where section_no in (2, 3)
group by location, instructor_id
having sum(capacity) > 50; #The where clause is executed by the database first, narrowing the result set to rows in the section table where section_no equals either 2 or 3 (that is, the second or third section of a course). The next step is to group the results by the columns listed in the group BY clause and to apply the aggregate functions. Finally, the having condition is tested against the groups. Only rows with a total capacity of greater than 50 are returned in the result.
--Either the columns used in the having clause must be found in the group by clause or they must be aggregate functions.
--In the following example, the aggregate count function is not mentioned in the select list, yet the having clause refers to it. The second condition of the having clause chooses only location groups with a starting value of L5. In this particular example, it is preferable to move this condition to the WHERE clause because doing so eliminates the rows even before the groups are formed, and the statement will therefore execute faster.
select location, sum(capacity) "Total Capacity"
from section
where section_no = 3
group by location
having (count(location) > 3 and location like 'L5%'); #Either the columns used in the having clause must be found in the group by clause or they must be aggregate functions.
--same as
select location, sum(capacity) as "Total Capacity"
from section
where section_no = 3 and location like 'L5%'
group by location
having count(location) > 3; #Either the columns used in the having clause must be found in the group by clause or they must be aggregate functions.
#Any constant, such as a text or number literal or a function that does not take any parameters, such as the sysdate function, may be listed in the select list without being repeated in the group by clause.  The following query shows the text literal 'Hello', the number literal 1, and the sysdate function in the select list of the query. These expressions do not need to be repeated in the group by clause.
select 'Hello', 1, sysdate, course_no "Course #", count(*)
from section
group by course_no
having count(*) = 5;
--Aggregate functions can be nested.
select section_id, count(*)
from enrollment
group by section_id
order by count(*) desc;
--better
select max(count(*))
from enrollment
group by section_id; #print 12

--CHAPTER 7 EQUIJOINS 285 (328)
--The equijoin, the most common join, allows you to connect two or more tables. Equijoins are based on equality of values in one or more columns.
/*
First choose the columns you want to include in the result. Next, determine the tables to which the columns belong. Then identify the common columns between the tables. Finally, determine whether there is a one-to-one or a one-to-many relationship among the column values. Joins are typically used to join between the primary key and the foreign key
*/
select course_no, description
from course;
select course_no, section_no, location, instructor_id
from section;
select first_name, last_name
from instructor;
select course.course_no, section.section_no, course.description, section.location, section.instructor_id
from course, section
where course.course_no = section.course_no;
--same as
select c.course_no, s.section_no, c.description, s.location, s.instructor_id
from course c, section s
where c.course_no = s.course_no;
--When you define a table alias in SQL Developer, any subsequent reference of the alias brings up a list of columns for the table, helping you remember the column names and avoid column misspellings (see Figure 7.4 page 289).
--In an equijoin, a null value in the common column has the effect of not including the row in the result.
select course_no, s.section_no, c.description, s.location, s.instructor_id
from course c join section s
using (course_no);  --there is no c. in course_no and in using(course_no)
--same as
select course_no, s.section_no, c.description, s.location, s.instructor_id
from course c inner join section s
using (course_no);  --there is no c. in course_no and in using(course_no)
--same as
select c.course_no, s.section_no, c.description, s.location, s.instructor_id
from course c join section s
on c.course_no = s.course_no;
select c.course_no, s.section_no, c.description, s.location, s.instructor_id
from course c join section s
on c.course_no = s.course_no
where description like 'B%';
select course_no, s.section_no, c.description, s.location, s.instructor_id
from course c natural join section s;  --instructor recommends avoid natural join.  there is no c. in course_no
--To include the instructor’s first and last names, you can expand this statement to join to a third table, the instructor table.
select c.course_no, s.section_no, c.description, s.location, s.instructor_id, i.last_name, i.first_name
from course c, section s, instructor i
where c.course_no = s.course_no
and s.instructor_id = i.instructor_id;
--same as
select c.course_no, s.section_no, c.description, s.location, s.instructor_id, i.last_name, i.first_name
from course c join section s
on (c.course_no = s.course_no)
join instructor i
on (s.instructor_id = i.instructor_id);
--same as
select course_no, s.section_no, c.description, s.location, instructor_id, i.last_name, i.first_name
from course c inner join section s
using (course_no)
join instructor i
using (instructor_id);  --there is no c. in course_no and in using(course_no).  Also no i. in instructor_id and in using(instructor_id)
select g.student_id, g.section_id, g.grade_type_code type, g.grade_code_occurrence no, g.numeric_grade indiv_gr,
to_char(e.enroll_date, 'MM/DD/YY') enrolldt
from grade g, enrollment e
where g.student_id = 220
and g.section_id = 119
and g.student_id = e.student_id
and g.section_id = e.section_id;
--same as
select g.student_id, g.section_id, g.grade_type_code type, g.grade_code_occurrence no, g.numeric_grade indiv_gr,
to_char(e.enroll_date, 'MM/DD/YY') enrolldt
from grade g join enrollment e
on (g.student_id = e.student_id and g.section_id = e.section_id)
where g.student_id = 220 and g.section_id = 119;
--same as
select student_id, section_id, grade_type_code type, grade_code_occurrence no, numeric_grade indiv_gr,
to_char(enroll_date, 'MM/DD/YY') enrolldt
from grade join enrollment
using (student_id, section_id)
where student_id = 220 and section_id = 119;
/*
Joining across multiple tables involves repeating the same steps of a two-join or three-join table: You join the first two tables and then join the result to each subsequent table, using the common column(s). You repeat this until all the tables are joined.

To join n tables together, you need at least n–1 join conditions. For example, to join five tables, you need at least four join conditions. If your join deals with tables containing multicolumn keys, you will obviously need to include these multiple columns as part of the join condition.

Although the traditional join syntax, with the columns separated by commas in the from clause and the join condition listed in the where clause, may become the old way of writing sql, you must nevertheless familiarize yourself with ansi syntax of using because millions of sql statements already use it, and it clearly performs its intended purpose.
*/

--CHAPTER 8 SUBQUERIES 323 (366)
select min(cost)
from course; #return 1095
select *
from course;
select *
from course
where cost = 
	(select	min(cost)
	from course);
select *
from course
where cost in 
	(select	cost
	from course
	where prerequisite = 20);  --find courses the cost is courses prerequisite = 20
--not same as
select *
from course
where prerequisite = 20;
select last_name, first_name
from student
where student_id in
	(select student_id
	from enrollment
	where section_id in
		(select section_id
		from section
		where section_no = 8
		and course_no = 20));  --get students enrolled in section 8 and course number 20
/* The innermost nested subquery, the last subquery in the example, is executed first; it determines
the section_id for section number 8 and course number 20. The surrounding query uses this
resulting section_id in the where clause to select student IDs from the enrollment
table. These student_id rows are fed to the outermost select statement, which then
displays the first and last names from the student table. */
--A subquery that uses the in or = operator can often be expressed as an equijoin if the subquery does not contain an aggregate function.  RM:  lesson learned at Sams Teach Yourself SQL in 10 Minutes.  Aggregate function use subquery.
select course_no, description
from course
where course_no in
	(select course_no
	from section
	where location = 'L211');
--same as
select c.course_no, c.description
from course c, section s
where c.course_no = s.course_no
and s.location = 'L211';
select student_id, section_id, numeric_grade
from grade
where grade_type_code = 'PJ'
and (section_id, numeric_grade) in
	(select section_id, max(numeric_grade)
	from grade
	where grade_type_code = 'PJ'
	group by section_id);  --get students with highest grades in project PJ
/* any null in subqueries return no records.  Also, order by clause is not allow inside a subquery. */
--Correlated subqueries allow you to reference columns from the outer query in the subquery. Second, they execute the inner query repeatedly once for each row in the outer query.
select student_id, section_id, numeric_grade
from grade outer
where grade_type_code = 'PJ'
and numeric_grade = 
	(select max(numeric_grade)
	from grade
	where grade_type_code = outer.grade_type_code
	and section_id = outer.section_id);  --get students with highest grades in project PJ.  outer is the grade table alias
--Not all subqueries can be transformed into joins; for example, a subquery containing an aggregate function cannot be transformed into a join.
--RM:  skipped Inline Views and Scalar Subquery Expressions page 355
/* The ANY, SOME, and ALL operators are related to the IN operator as they also compare against a list of values. In addition, these operators allow >, <, >=, and <= comparisons. */
select section_id, numeric_grade
from grade
where section_id = 84
and numeric_grade < any (80, 90);
--same as
select section_id, numeric_grade
from grade
where section_id = 84
and numeric_grade < 90;
select section_id, numeric_grade
from grade
where section_id = 84
and numeric_grade < all (80, 90);
--same as
select section_id, numeric_grade
from grade
where section_id = 84
and numeric_grade < 80;

--CHAPTER 9 SET OPERATORS 377 (420)
--Oracle has four set operators.  The UNION and UNION ALL operators combine results. The INTERSECT operator  determines common rows. The MINUS operator shows differences between sets of rows.
select first_name, last_name
from instructor;
select first_name, last_name
from student;
select first_name, last_name
from instructor
union
select first_name, last_name
from student;
--UNION operator shows only distinct rows, duplicate row appears once.  UNION ALL includes any duplicates when sets of data are added.
select instructor_id, first_name, last_name, phone
from instructor
union
select student_id, first_name, last_name, phone
from student
order by last_name;
--The MINUS operator returns the difference between two sets. Effectively, you use it to subtract one set from another set.
select instructor_id
from instructor  --returns the complete list of instructors
minus
select instructor_id
from section;  --if instructor_id in section is also in instructor, minus it or don't show it in results.
--The INTERSECT operator determines the common values between two sets.
select created_by
from enrollment
intersect
select created_by
from course;  --distinct values where the two sets overlap or intersect are returned

--CHAPTER 10 COMPLEX JOINS 399 (442)
--ANSI outer join syntax below
select c.course_no, c.description, s.section_id, s.course_no
from course c left outer join section s
on c.course_no = s.course_no
order by c.course_no;
--same as
select c.course_no, c.description, s.section_id, s.course_no
from section s right outer join course c
on c.course_no = s.course_no
order by c.course_no;
--same as
select course_no, description, section_id
from section right outer join course
using (course_no)
order by course_no;
--RM:  skipped Oracle's outer join operator (+) p403
--A full outer join includes rows from both tables
select col1, col2
from t1 full outer join t2
on t1.col1 = t2.col2;  --made up tables in book
--An equijoin always joins one or multiple tables. A self-join joins a table to itself by pretending there are different tables involved.  One table has one alias and the same table has another alias.  Oracle treats the two tables as two different tables.  Join same table.
select course_no, description, prerequisite
from course;
--I want to see the prerequisite description.  Run a self-join.
select c1.course_no, c1.description as "course description", c1.prerequisite as "prerequisite", c2.description as "prerequisite description"
from course c1 join course c2
on c1.prerequisite = c2.course_no
order by c1.prerequisite, c1.course_no;  --You join the prerequisite column of table c1 with the course_no column of table c2, if matching records are found, the description of the prerequisite is displayed.
--Occasionally, you need to construct joins that are not based on equality of values. The following query illustrates such an example, using the BETWEEN operator, where you have values that fall into a range.  Equijoin based on range of values.
select grade_type_code, numeric_grade, letter_grade
from grade g join grade_conversion c
on (g.numeric_grade between c.min_grade and c.max_grade)
order by grade_type_code, numeric_grade desc;  --The BETWEEN operator checks for each value in the NUMERIC_GRADE column to see if the individual grade is between the values found in the columns MIN_GRADE and MAX_GRADE of the GRADE_CONVERSION table. If a match is found, the corresponding letter grade is returned. For example, the first row of the result shows the value 76 in the NUMERIC_GRADE column for a final examination. The appropriate letter grade for the value 76 is C.
--same as
select grade_type_code, numeric_grade, letter_grade, min_grade, max_grade
from grade g, grade_conversion c
where g.numeric_grade between c.min_grade and c.max_grade
order by grade_type_code, numeric_grade desc;

--CHAPTER 11 INSERT, UPDATE, AND DELETE 429 (472)
--INSERT, UPDATE, DELETE, and MERGE statements, which are known as Data Manipulation Language (DML)
insert into zipcode
values ('11111','Westerly','MA',user,to_date('18-JAN-2010','DD-MON-YYYY'),user, sysdate);  --The values are in the same order as the columns when you use the DESCRIBE command on the ZIPCODE table.
--It is good practice to include a column list, though, in case of future table changes.
insert into zipcode (zip, city, state, created_by, created_date, modified_by, modified_date)
values ('11111','Westerly','MA',user,to_date('18-JAN-2010','DD-MON-YYYY'),user, sysdate);
--When you are not inserting data into all columns of a table, you must explicitly name the columns to insert data into.
insert into zipcode (zip, created_by, created_date, modified_by, modified_date)
values ('11111',user,sysdate,user, sysdate);
--Another method for inserting data is to select data from another table via a subquery. The subquery may return one or multiple rows; thus, the INSERT statement inserts one or multiple rows at a time.
insert into introcoursetablemadeup (course_no, description, cost, prereq_no, created_by, created_date, modified_by, modified_date)
select course_no, description, cost, prerequisite, created_by, created_date, 'Melanie', to_date('01-JAN-2008','DD-MON-YYYY')
from course
where prerequisite is null;
--inserting into multiple tables
insert all
	into section_history
	values (section_id, start_date_time, course_no, section_no)
	into capacity_history
	values (section_no, location, capacity)
select section_id, start_date_time, course_no, section_no, location, capacity
from section
where trunc(start_date_time) < trunc(sysdate)-365;
--inserting into multiple tables with conditions
insert all
	when section_id between 100 and 400 then
	into section_history
	values (section_id, start_date_time, course_no, section_no)
	when capacity >=25 then
	into capacity_history
	values (section_no, location, capacity)
select section_id, start_date_time, course_no, section_no, location, capacity
from section
where trunc(start_date_time) < trunc(sysdate)-365;
--The INSERT FIRST statement evaluates the WHEN clauses in order; if the first condition is true, the row is inserted, and subsequent conditions are no longer tested. For example, with a SECTION_ID value of 130 and a capacity of 25, the statement inserts the row in the SECTION_ HISTORY tables only because the first condition of the WHEN clause is satisfied. You can have an optional ELSE condition in case none of the conditions are true.
insert first
	when section_id between 100 and 400 then
	into section_history
	values (section_id, start_date_time, course_no, section_no)
	when capacity >=25 then
	into capacity_history
	values (section_no, location, capacity)
select section_id, start_date_time, course_no, section_no, location, capacity
from section
where trunc(start_date_time) < trunc(sysdate)-365;
--The pivoting INSERT ALL statement is just like the unconditional INSERT ALL statement: It inserts the rows into multiple tables, and it also does not have a WHEN condition. The following is an example of pivoting a table (that is, flipping it on its side).
insert all
	into gradedistributionnormalized
	values(section_id, 'A', grade_a)
	into gradedistributionnormalized
	values(section_id, 'B', grade_b)
	into gradedistributionnormalized
	values(section_id, 'C', grade_c)
	into gradedistributionnormalized
	values(section_id, 'D', grade_d)
	into gradedistributionnormalized
	values(section_id, 'F', grade_f)
select section_id, grade_a, grade_b, grade_c, grade_d, grade_f
from gradedistribution;
/*
The COMMIT command makes a change to data permanent.  The effect of the COMMIT command is that it allows other sessions to see the data.  Commit locks for the changed rows are released, and other users can perform changes on the rows.  Data Definition Language (DDL) statements, such as the CREATE TABLE command, or Data Control Language (DCL) statements, such as the GRANT command, implicitly issue a COMMIT to the database; there is no need to issue a COMMIT command.
The ROLLBACK command undoes any DML statements back to the last COMMIT command issued. Any pending changes are discarded, and any locks on the affected rows are released.  E.g. insert three rows to zipcode table.  Type rollback.  the three rows are removed from zipcode table.
The SAVEPOINT command allows you to save the results of DML transactions temporarily. The ROLLBACK command can then refer to a particular SAVEPOINT and roll back the transaction up to that point; any statements issued after the SAVEPOINT are rolled back.
*/
update enrollment
set final_grade = 90
where enroll_date >= to_date('01/01/2007', 'MM/DD/YYYY') and enroll_date < ('02/01/2007');
update enrollment
set final_grade = null;
--A column may have a default value defined; this value is entered when an INSERT statement did not specify an explicit value for a column.
update grade
set numeric_grade = default  --The numeric_grade default value is 0.  Set the numeric_grade to default 0.
where student_id = 211
	and section_id = 141
	and grade_type_code = 'HM'
	and grade_code_occurrence = 1;
--CASE expressions can be used anywhere expressions are allowed.  It's like if-then if then statement.
update enrollment
set final_grade = case
	when final_grade <=80 then final_grade+5
	when final_grade >80 then final_grade+10
	end;
--An update can occur based on data from other tables, using a subquery.
update instructor
set zip = (select zip
	from zipcode
	where state = 'FL')
where instructor_id = 108;
--The following subquery returns multiple zip codes for the state of Connecticut.  You can use max or min function or any aggregate function guarantees the return of a single row.
update instructor
set zip = (select max(zip)
	from zipcode
	where state = 'CT')
where instructor_id = 108;
--The following statement updates the FINAL_GRADE column to 90 and the MODIFIED_DATE column to March 13, 2009, for those sections taught by the instructor Hanks.  Correlated subquery.
--RM:  skipped rest of correlated subquery p461.
update enrollment e
set final_grade = 90, modified_date = to_date('13-MAR-2009', 'DD-MON-YYYY')
where exists (select '*'
	from section s, instructor i
	where e.section_id = s.section_id
	and s.instructor_id = i.instructor_id
	and i.last_name = 'Hanks')
--You can perform combined INSERT, UPDATE, and DELETE operations with the MERGE command.  Adding selected data from one table.  Merge selected data from one table.  Merge data.  Merge rows, merge selected rows.
merge into employee e
using (select employee_id, salary, title, name
	from employee_change) c
	on (e.employee_id = c.employee_id)
when matched then
	update set e.salary = c.salary, e.title = c.title
when not matched then
	insert (e.employee_id, e.salary, e.title, e.name)
	values (c.employee_id, c.salary, c.title, c.name);
--The MERGE syntax contains an optional DELETE condition to the WHEN MATCHED THEN UPDATE clause. It allows you to remove rows from the table during this operation. The only rows deleted are the ones that satisfy both the DELETE and the ON conditions. The DELETE condition evaluates the rows based on the values after the update—not the original values.
merge into employee e
using (select employee_id, salary, title, name
	from employee_change) c
	on (e.employee_id = c.employee_id)
when matched then
	update set e.salary = c.salary, e.title = c.title
	delete where salary = 6000
when not matched then
	insert (e.employee_id, e.salary, e.title, e.name)
	values (c.employee_id, c.salary, c.title, c.name);
--remove data, delete data with delete statement.  Delete all rows or specific rows.
delete from grade;
/*
If you issue a DELETE on a parent table with associated child records, and the foreign key constraint is set to ON DELETE CASCADE, the children are automatically deleted. If the foreign key constraint is set to ON DELETE SET NULL, the child rows are updated to a null value, provided that the foreign key column of the child table allows nulls. The default option for a foreign key constraint with respect to DELETEs is RESTRICT. It disallows the deletion of a
parent if child rows exist. In this case, you must delete the child rows first, before you delete the parent row.
*/
--Truncate deletes all rows.  No where clause allowed.  Automatically issues a commit.  Rows are deleted.  Can't rollback.  Truncate faster than delete command.
truncate table class;
--RM:  skipped Triggers and DML Commands p 470.  Triggers are written in the PL/SQL language and can perform sophisticated actions (for example, recording changes to another table for auditing purpose or updating summary values on derived columns).

--CHAPTER 12 CREATE, ALTER, AND DROP TABLES 503 (546)
--Chapter introduces you to the Data Definition Language (DDL) commands associated with tables, the type of database object most frequently used and following chapters:  table, view, index, sequence, synonym, directory, trigger, function, procedure, package.
--DDL statements automatically issues an implicit commit.
create table toy (toy_id number(10), description varchar2(15) not null, last_purchase_date date, remaining_quantity number(6));
--number(p,s) is number(precision or total number of digits, scale number of digits to the right of the deciaml place out of total number of digits). e.g. number(5,2) is -999.99 to 999.99 inclusive.  1,000 is rejected.  80.999 is rounded up to 81.00.
--The following CREATE TABLE statement creates a table called TAB1 with several types of constraints.
create table tab1 (col1 number(10) primary key, col2 number(4) not null, col3 varchar2(5) references zipcode(zip) on delete cascade, col4 date default sysdate, col5 varchar2(20) unique, col6 number check(col6<100));
--col6 above is a check constraint.  Another example check constraint state varchar2(20) check(state in ('NY','NJ','CT','FL','CA'))
--naming constraints below.  Some of the constraint names are next to each column; these are column-level constraints. The constraint names at the end of the statement are table-level constraints. Constraint names cannot exceed 30 characters and must be unique within the user’s schema. In this example, the constraint names consist of the name of the table and column (or an abbreviated version) and a two-letter abbreviation that identifies the type of constraint.
create table tab1 (col1 number(10), col2 number(4) constraint tab1_col2_nn not null, col3 varchar2(5), col4 date default sysdate, col5 varchar2(20), col6 number, constraint tab1_pk primary key(col1), constraint tab1_zipcode_fk foreign key(col3) references zipcode(zip), constraint tab1_col5_col6_uk unique(col5, col6), constraint tabl_col6_ck check (col6 < 100), constraint tab1_col2_col6_ck check (col2 > 100 and col6 > 20));
--create table based on an existing table or tables.  Can include the data or not.
create table jan_07_enrollment as
	select *
	from enrollment
	where enroll_date >= '01/01/2007' and enroll_date <= '02/01/2007';
descrbe jan_07_enrollment;
select *
from jan_07_enrollment;
create table jan_07_enrollment as
	select *
	from enrollment
	where rownum < 1;  --create table without data
rename jan_07_enrollment to jan_07_newtable; --rename table
--same as
alter table jan_07_enrollment rename to jan_07_newtable; --rename table
drop table jan_07_newtable; --delete table no longer needed.  Drop table data are removed.  If you do not want to place the table in the recycle bin, use the PURGE syntax option drop table *tablename* PURGE.  If you want to remove the foreign key constraints, use CASCADE CONSTRAINTS drop table *tablename* CASCADE CONSTRAINTS
flashback table jan_07_newtable to before drop;  --restore drop table, undelete drop table, recover delete table
--RM:  skipped temporary tables, index-organized tables, and external tables page 524
alter table toy
add (manufacturer varchar2(30) constraint toy_manufacturer_nn not null);  --add column naming the constraint
alter table toy
drop (last_purchase_date, remaining_quantity);  --delete column, delete columns
alter table toy
set unused (last_purchase_date); --make column no longer visible yet keep the column and its data.  To delete unused column, alter table *tablename* drop unused columns
alter table toy rename column description to description_tx;  --rename column
alter table toy modify (description_tx varchar2(25));  --modify description_tx column length from 15 to 25
alter table toy modify (remaining_quantity varchar2(6) constraint remain_qt_nn_constraintname not null);  --change data type from number to varchar2 and is now not null.  SQL statement successful because the table contains no data.  The sql statement can be execuited separately one for varchar2 and second for not null.
alter table toy drop constraint toy_pk;  --remove constraint by specifying constraint name toy_pk after constraint
alter table toy drop primary key;  --remove primary key constraint
alter table toy add constraint toy_pk_constraintname primary key(toy_id);  --add primary key constraint on toy_id column
alter table grade add constraint gr_enr_fk foreign key (student_id, section_id) references enrollment (student_id, section_id);  --add foreign key
alter table section add constraint sect_sect2_uk unique (section_no, course_no);  --add a unique index
alter table zipcode add constraint zipcode_zip_ck check (translate(zip, '1234567890', '9999999999') = '99999');  --add constraint.  The TRANSLATE function converts each entered digit into a 9 and then checks whether the format equals 99999. Any nonnumeric digits are not translated; therefore, the result of TRANSLATE is unequal to 99999, and the value is rejected.
alter table zipcode add constraint zipcode_zip_ck check (to_number(zip)>0 and length(zip)= 5);  --add constraint another example
alter table instructor add constraint instructor_salutation_ck check (salutation in ('Dr', 'Hon', 'Mr', 'Ms', 'Rev') or salutation is null);  --add constraint another example
alter table section rename constraint sect_crse_fk to sect_fk_crse;  --rename constraint
alter table toy disable constraint toy_pk;  --disable constraint
alter table toy disable constraint toy_pk keep index;  --disable constraint preserve index of a unique or primary key
alter table toy enable primary key;  --enable primary key
alter table toy enable constraint toy_pk;  --enable constraint name toy_pk
alter table section disable constraint sect_crse_fk;  --disable constraint name sect_crse_fk foreign key
alter table section 
disable constraint sect_crse_fk
disable constraint sect_inst_fk;  --disable multiple constraints no commas separating disable clauses

--CHAPTER 13 INDEXES, SEQUENCES, AND VIEWS 572 (615)
--RM:  More database theory and less on SQL.  Make the judgement call how to learn the chapter.
--create an index named sect_location_i on location column in section table
create index sect_location_i
on section(location);
--A composite index or concatenated index is an index based on multiple columns.  Index named course_description_cost_i on description column and cost column in course table.  description, the first column of the index, is also called the leading edge of the index.
create index course_description_cost_i
on course(description, cost);
--delete index
drop index sect_location_i;
--Sequences are Oracle database objects that allow you to generate unique integers.  Sequences are typically incremented by 1, but other increments can be specified. You can also start sequences at a specific number.  Basing the name of the sequence on the name of the column for which you want to use it is helpful for identification, but it does not associate the sequence with a particular column or table. The START WITH clause starts the sequence with the number 1.The NOCACHE keyword indicates that sequence numbers should not be kept in memory, so that when the system shuts down, you do not lose any cached numbers.
create sequence student_id_seq_new start with 1 nocache;
--A view is a virtual table that consists of columns and rows, but it is only the SELECT statement that is stored, not a physical table with data. A view’s SELECT query may reference one or multiple tables, called base tables. The base tables are typically actual tables or other views.

--CHAPTER 14 THE DATA DICTIONARY, SCRIPTING, AND REPORTING 615 (658)
--CHAPTER 15 SECURITY 661 (704)
--CHAPTER 16 REGULAR EXPRESSIONS AND HIERARCHICAL QUERIES 695 (738)
--CHAPTER 17 EXPLORING DATA WAREHOUSING FEATURES 741 (784)
--RM: take chapter 17 slow.  Advanced SQL and analytical functions
select to_char(start_date_time, 'DY') as threedigitday, count(*) as numberofclasses
from section
group by to_char(start_date_time, 'DY')
order by numberofclasses;
--You can transpose the result producing a cross-tab displaying the result horizontally, with the days of the week as columns and a count below. You do this by nesting the DECODE function in the COUNT function.
select count(decode(to_char(start_date_time, 'DY'), 'MON', 1)) MON,
	count(decode(to_char(start_date_time, 'DY'), 'TUE', 1)) TUE,
	count(decode(to_char(start_date_time, 'DY'), 'WED', 1)) WED,
	count(decode(to_char(start_date_time, 'DY'), 'THU', 1)) THU,
	count(decode(to_char(start_date_time, 'DY'), 'FRI', 1)) FRI,
	count(decode(to_char(start_date_time, 'DY'), 'SAT', 1)) SAT,
	count(decode(to_char(start_date_time, 'DY'), 'SUN', 1)) SUN
from section;
/*
When each row of the expression TO_CHAR(start_date_time, ‘DY’) is evaluated, Oracle returns the day of the week, in the format DY, which is MON for Monday, TUE for Tuesday, and so on. If the DECODE expression is equal to the search value, the value 1 is returned. Because no ELSE
condition is specified, a NULL value is returned. 
The COUNT function without an argument does not count NULL values; NULLs are counted only with the wildcard COUNT(*). Therefore, when the COUNT function is applied to the result of either NULL or 1, it counts only records with NOT NULL values. Alternatively, you can also use the SUM function.
*/
/*
The syntax of the DECODE function is as follows.
DECODE (if_expr, equals_search, then_result [,else_default])
*/
--Use CASE instead of DECODE.
select count(case when to_char(start_date_time, 'DY') = 'MON' then 1 end) MON,
	count(case when to_char(start_date_time, 'DY') = 'TUE' then 1 end) TUE,
	count(case when to_char(start_date_time, 'DY') = 'WED' then 1 end) WED,
	count(case when to_char(start_date_time, 'DY') = 'THU' then 1 end) THU,
	count(case when to_char(start_date_time, 'DY') = 'FRI' then 1 end) FRI,
	count(case when to_char(start_date_time, 'DY') = 'SAT' then 1 end) SAT,
	count(case when to_char(start_date_time, 'DY') = 'SUN' then 1 end) SUN
from section;
--The new PIVOT clause in Oracle 11g greatly simplifies the writing of cross-tab queries. It rotates the rows into columns.
select * from (
	select to_char(start_date_time, 'DY') as threedigitday, count(*) as numberofclasses
	from section
	group by to_char(start_date_time, 'DY')
	) didntneednamehere
pivot (sum(numberofclasses)  --can't use count because we add threedigitday?
for threedigitday in ('MON','TUE','WED','THU','FRI','SAT','SUN'));
--The following statement creates a table called LOCATION_BY_DATE. The difference from the previous query is that this example also includes the LOCATION column in the inner query. Now the cross-tabulated result is computed not only by the days of the week but also by the location. Another difference is the removal of quotes in the column heading; the columns shown in the IN list have an alias.
create table location_by_day as
select * from (
	select to_char(start_date_time, 'DY') as threedigitday, s.location, count(*) as numberofclasses
	from section s
	group by to_char(start_date_time, 'DY'), location
	) didntneednamehere
pivot (sum(numberofclasses) 
for threedigitday in ('MON' as MON,'TUE' as TUE,'WED' as WED,'THU' as THU,'FRI' as FRI,'SAT' as SAT,'SUN' as SUN));
select *
from location_by_day;
--Using the LOCATION_BY_DAY table as a source, the UNPIVOT clause allows the rotation of columns back to rows.  The default option of the UNPIVOT clause is EXCLUDE NULLS, but in this example you see the inclusion of null values through the use of the INCLUDE NULLS option.
select *
from location_by_day
unpivot include nulls (numberofclasses
for threedigitday in (mon, tue, wed, thu, fri, sat, sun));
--For very difficult queries, where the result cannot be performed using any of the previously mentioned solutions, you might want to consider creating a temporary table to hold intermediate results.  RM:  chapter 12 create temporary tables for which I skipped page 524.
/*
Oracle includes a number of very useful functions that allow you to analyze, aggregate, and rank vast amounts of stored data.  Although this lab does not discuss all the available analytical functions, it does provide an overview of the most commonly used functions.  The general syntax of analytical functions is as follows:  analytic_function([arguments]) OVER (analytic_clause).  The OVER keyword indicates that the function operates after the results of the FROM, WHERE, GROUP BY, and HAVING clauses have been formed.  ANALYTIC_CLAUSE can contain three other clauses: QUERY_PARTITIONING, ORDER_BY, or WINDOWING.  [query_partition_clause] [order_by_clause [windowing_clause]]

You perform query processing with analytical functions in several steps (see Figure 17.1). First, joins, WHERE, GROUP BY, and HAVING clauses are carried out. The analytical functions then use these results. If any partitioning clause is listed, the rows are split into the appropriate partitions. These partitions are formed after the GROUP BY clause, so you may be able to analyze data by partition, not just the expressions of the GROUP BY clause. If a windowing clause is involved, it determines the ranges of sliding windows of rows. The analytical functions are based
against the specified window and allow moving averages, sums, and so on. Analytical functions may have an ORDER BY clause as part of the function specification that allows you to order the result before the analytical function is applied. Finally, if an ORDER BY clause is present at the
end of the statement, the result set is sorted accordingly.

Analytical functions can be categorized into various types; Table 17.1 provides an overview of the different types page 748.
*/
select student_id, section_id, numeric_grade
from grade;
select student_id, section_id, numeric_grade, dense_rank() over (order by numeric_grade) as ranknumericgradelowesthighest
from grade;  --If you want the highest grade to have rank number 1, use DESCENDING in the ORDER BY clause (order by numeric_grade desc). The default is ASCENDING.
select *
from (select student_id, section_id, numeric_grade, dense_rank() over (order by numeric_grade) as ranknumericgradelowesthighest
  from grade)
where ranknumericgradelowesthighest <=3;  --To find out the three lowest grades of the student, rather than all the grades, you can modify the query by using the ranking function and an inline view
select student_id, section_id, numeric_grade, rank() over (order by numeric_grade) as ranknumericgrade, dense_rank() over (order by numeric_grade) as denseranknumericgrade, row_number() over (order by numeric_grade) as rownumbernumericgrade
from grade;  --The RANK function assigns each row a unique number. However, duplicate rows receive the identical ranking, and a gap appears in the sequence before the next rank.  The ranking function DENSE_RANK assigns duplicate values the same rank.
select student_id, section_id, numeric_grade, rank() over (partition by section_id order by numeric_grade) as ranknumericgrade, dense_rank() over (partition by section_id order by numeric_grade) as denseranknumericgrade, row_number() over (partition by section_id order by numeric_grade) as rownumbernumericgrade
from grade; --The optional partitioning clause lets you create independent rankings and resets the rank whenever the partitioned values change.  The example is partitioning section_id.  Each section_id has its own rankings.  
select student_id, section_id, numeric_grade, rank() over (partition by student_id, section_id order by numeric_grade) as ranknumericgrade, dense_rank() over (partition by student_id, section_id order by numeric_grade) as denseranknumericgrade, row_number() over (partition by student_id, section_id order by numeric_grade) as rownumbernumericgrade
from grade;  --You can partition over multiple values/columns by listing each individual expression and separating them with commas in the partitioning clause.  Table and index partitioning functionality is beyond the scope of this book and independent of analytical functions discussed in this lab.
--The NTILE function is another ranking function you can use to divide data into buckets of fourth, thirds, or any other groupings. The next SELECT statement shows the result split into four buckets (four quartiles, or 4 × 25 percent buckets).
select student_id, section_id, numeric_grade, ntile(4) over (order by numeric_grade) as byfoursnumericgrade
from grade;
select rank(99) within group (order by numeric_grade desc) as "rank 99 top to bottom"
from grade;  --You can perform this type of what-if analysis with the hypothetical ranking syntax, which uses the WITHIN GROUP keywords. The query determines the rank of the value 99 if it was present in the numeric-grade column of the grade table.  The syntax for hypothetical ranking is as follows. [RANK|DENSE_RANK|PERCENT_RANK|CUME_DIST](constant[, ...]) WITHIN GROUP (order_by_clause).  Find out how a specific data value would rank if it were part of the result set.
select count(*), min(numeric_grade), max(numeric_grade), count(*) keep (dense_rank first order by numeric_grade) as "dense_rank first order lowest", count(*) keep (dense_rank last order by numeric_grade) as "dense_rank last order highest"
from grade;  --The FIRST and LAST functions operate on a set of values to show the lowest or highest value within a result. The syntax of these functions is as follows:  aggregate_function KEEP (DENSE_RANK {LAST|FIRST} order_by_clause) [OVER query_partitioning_clause].  Lowest grade is 70.  Highest grade is 99.  Six grade rows exist for lowest grade 70.  159 rows exist for highest grade 99.  We are counting count(*) as the aggregate function.
--same as
SELECT numeric_grade, COUNT(*)
FROM grade
where (numeric_grade IN (SELECT MAX(numeric_grade)
							FROM grade)		
	or
		numeric_grade IN (SELECT MIN(numeric_grade)
							FROM grade))
group by numeric_grade;
select grade_type_code, median(numeric_grade)
from grade
group by grade_type_code;  --The MEDIAN function returns the median, or middle, value. This function has the following syntax:  MEDIAN (expression) [OVER (query_partitioning_clause)]
select student_id, section_id, grade_type_code, numeric_grade
from grade;
select student_id, section_id, grade_type_code, numeric_grade, median(numeric_grade) over (partition by grade_type_code) as "median by grade_type_code"
from grade;  --MEDIAN displays the median of the NUMERIC_GRADE column, partitioned by GRADE_TYPE_CODE.
--stats_mode returns the value that occurs with the greatest frequency.  Most common.  It's the mode.
select cost
from course;
select stats_mode(cost)
from course;  --print 1195
select cost, count(*)
from course
group by cost
order by count(*) --count all data or group by count
--another example
select numeric_grade
from grade;
select stats_mode(numeric_grade)
from grade;  --print 161
select numeric_grade, count(*)
from grade
group by numeric_grade
order by count(*) desc;
--The reporting functionality allows you to compute aggregates for a row in a partition. The syntax is as follows: {SUM|AVG|MAX|MIN|COUNT|STDDEV|VARIANCE} ([ALL|DISTINCT] {expression|*}) OVER ([PARTITION BY expression2[,...]])
select numeric_grade, grade_type_code, avg(numeric_grade) over (partition by grade_type_code) as "avg numericg per gradetypec"
from grade;  --lists the individual grades and the grade type and displays the grade average for each or per grade type
select numeric_grade, grade_type_code, avg(numeric_grade) over () as "avg numericg all gradetypec"
from grade;  --lists the individual grades and the grade type and displays the grade average all grade type
--The RATIO_TO_REPORT function is a reporting function that computes the ratio of a value to the sum of a set of values. The syntax is as follows:  RATIO_TO_REPORT(expression) OVER ([query_partition_clause])
select course_no, cost, ratio_to_report(cost) over () as "cost ratio per course_no"
from course;
--The WINDOWING clause allows you to compute cumulative, moving, and centered aggregates.  A window has a defining starting point and ending point. The parameters in the windowing clause are always relative to the current row. A sliding window changes the starting point or ending point, depending on the definition of the window. A window that defines a cumulative sum starts with the first row and then slides forward with each subsequent row. A moving average has sliding starting and ending rows for a constant logical or physical range.  Moving sum.  Moving average.
select course_no, cost, avg(cost) over (order by course_no rows between unbounded preceding and current row) as "moving cost average", sum(cost) over (order by course_no rows between unbounded preceding and current row) as "moving cost sum"
from course;
select course_no, cost, avg(cost) over (order by course_no rows between 1 preceding and 1 following) as "moving cost center avg", avg(cost) over (order by course_no rows 1 preceding) as "moving cost last two avg", avg(cost) over (order by course_no rows between unbounded preceding and current row) as "moving cost avg"
from course;  --moving average center, one above one below; moving average last two; moving average all rows
/*
You can expand this functionality for any of the aggregate functions. This allows you to compute moving sums, centered sums, moving min and max values, and so on.

The syntax of the windowing clause is as follows.
order_by_clause {ROWS|RANGE}
{BETWEEN
{UNBOUNDED PRECEDING|CURRENT ROW|
expression {PRECEDING|FOLLOWING}}
AND
{UNBOUNDED FOLLOWING|CURRENT ROW|
expression {PRECEDING|FOLLOWING}}|
{UNBOUNDED PRECEDING|CURRENT ROW|
expression PRECEDING}}

The ROWS and RANGE keywords allow you to define a window, either physically through the number of rows or logically, such as a time interval or a positive numeric value in the RANGE keyword. The BETWEEN…AND clause defines the starting and ending points of the window, and if none are specified, Oracle defaults to RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.

UNBOUNDED PRECEDING indicates that the window starts at the first row of the partition, and UNBOUNDED FOLLOWING indicates that the window ends at the last row of the partition.

Besides the aggregate functions, such as AVG, COUNT, MIN, MAX, SUM, STDDEV, and VARIANCE, you can use the FIRST_VALUE and LAST_VALUE functions, which return the first value and last value in the window, respectively.
*/
--start page 761