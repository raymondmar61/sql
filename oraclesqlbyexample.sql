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
--View-->Snippets.  Snippets is a window contianing SQL functions or syntax examples.  Hovering over the function reveals a brief description of the function.  Drag the SQL to the Worksheet.  
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
--start page 158
