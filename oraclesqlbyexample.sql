--Oracle SQL by Example by Alice Rischert
--RM:  close file at top to review Oracle commands and shortcuts.
--Ctrl+D clear
--Shift+F4 opens Popup Describe window on an object
--Ctrl+F7 quick syntax formatting
--Ctrl+Shift+Quote toggle uppecase and lowercase
--Press SQL button at Query Results shows the SQL statements
--You can drag tables listed in the Connections navigator into the SQL Worksheet. When you do this, you construct a SELECT statement with all columns in the table. If desired, you can then edit the statement further.
--You need to end each SQL statement with a semicolon (;) or type a forward slash (/) on a new line; otherwise, SQL Developer displays an error.
--If you want to run both statements at once, you need to run the statements as a script by clicking the Run Script icon (F5).  RM:  highlight multiple statements, press Ctrl+Enter.
--F8 is SQL History.  Can search history.
--The Single Record View window allows you to examine one record at a time and scroll through the records.  Right mouse click anywhere in Query Results.
--The Auto-fit menu options are very useful for formatting the Results window according to the length of the data cells or the length of the column name.  Right mouse click columns at Query Results.

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
--Start Page 101 (144)