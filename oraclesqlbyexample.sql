--Oracle SQL by Example by Alice Rischert
--RM:  close file at top to review Oracle commands and shortcuts.
--Ctrl+D clear
--Shift+F4 opens Popup Describe window on an object
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
--View-->Snippets.  Snippets is a window contianing SQL functions or syntax examples.  Hovering over the function reveals a brief description of the function.  Drag the SQL to the Worksheet.  e,g, Date/Time Functions.  The Snippets window lists commonly used functions, expressions, and code fragments. It does not provide a complete list of all available functions and syntax options in Oracle SQL. You can customize the snippets and add frequently used code fragments or functions.
--Comments --for single line /* ... */ for multi-line

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
--start page 239
