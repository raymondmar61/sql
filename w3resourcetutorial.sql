#https://www.w3resource.com/sql/tutorials.php
/*
SQL statements are grouped into following categories:

Data manipulation: The Data Manipulation Language (DML) is the subset of SQL which is used to add, update and delete data.
Data definition: The Data Definition Language (DDL) is used to manage table and index structure. CREATE, ALTER, RENAME, DROP and TRUNCATE statements are to name a few data definition elements.
Data control: The Data Control Language (DCL) is used to set permissions to users and groups of users whether they can access and manipulate data.
Transaction: A transaction contains a number of SQL statements. After the transaction begins, all of the SQL statements are executed and at the end of the transaction, permanent changes are made in the associated tables.
Procedure: Using a stored procedure, a method is created which contains source code for performing repetitive tasks.
*/
/*
Statements are grouped into seven categories which are called classes. See the following table:

Class	Example
data statements	SELECT, INSERT, UPDATE, DELETE
connection statements	CONNECT, DISCONNECT
schema statements	ALTER, CREATE, DROP
control statements	CALL, RETURN
diagnostic statements	GET DIAGNOSTICS
session statements	SET CONSTRAINT
transaction statements	COMMIT, ROLLBACK
*/
/*
Database and Table Manipulation
Command	Description
CREATE DATABASE database_name	Create a database
DROP DATABASE database_name	Delete a database
CREATE TABLE "table_name" ("column_1" "column_1_data_type", "column_2" "column_2_data_type", ... )	Create a table in a database.
ALTER TABLE table_name ADD column_name column_datatype	Add columns in an existing table.
ALTER TABLE table_name DROP column_name column_datatype	Delete columns in an existing table.
DROP TABLE table_name	Delete a table.
*/
/*
Data Types:
Data Type	Description
CHARACTER(n)	Character string, fixed length n.
CHARACTER VARYING(n) or VARCHAR(n)	Variable length character string, maximum length n.
BINARY(n)	Fixed-length binary string, maximum length n.
BOOLEAN	Stores truth values - either TRUE or FALSE.
BINARY VARYING(n) or VARBINARY(n)	Variable length binary string, maximum length n.
INTEGER(p)	Integer numerical, precision p.
SMALLINT	Integer numerical precision 5.
INTEGER	Integer numerical, precision 10.
BIGINT	Integer numerical, precision 19.
DECIMAL(p, s)	Exact numerical, precision p, scale s.
NUMERIC(p, s)	Exact numerical, precision p, scale s. (Same as DECIMAL ).
FLOAT(p)	Approximate numerical, mantissa precision p.
REAL	Approximate numerical mantissa precision 7.
FLOAT	Approximate numerical mantissa precision 16.
DOUBLE PRECISION	Approximate numerical mantissa precision 16.
DATE
TIME
TIMESTAMP	Composed of a number of integer fields, representing an absolute point in time, depending on sub-type.
INTERVAL	Composed of a number of integer fields, representing a period of time, depending on the type of interval.
COLLECTION  (ARRAY, MULTISET)	ARRAY(offered in SQL99) is a set-length and ordered the collection of elements.
XML	Stores XML data. It can be used wherever a SQL data type is allowed, such as a column of a table.
*/
/*
Index Manipulation:
Command	Description
CREATE INDEX index_name ON table_name (column_name_1, column_name_2, ...)	Create a simple index.
CREATE UNIQUE INDEX index_name ON table_name (column_name_1, column_name_2, ...)	Create a unique index.
DROP INDEX table_name.index_name	Drop a index.
*/
/*
SQL Operators:
Operators	Description
SQL Arithmetic Operator	Arithmetic operators are addition(+), subtraction(-), multiplication(*) and division(/). The + and - operators can also be used in date arithmetic.
SQL Comparison Operator	A comparison (or relational) operator is a mathematical symbol which is used to compare two values.
SQL Assignment operator	In SQL the assignment operator ( = ) assigns a value to a variable or of a column or field of a table.
SQL Bitwise Operator	The bitwise operators are & ( Bitwise AND ), | ( Bitwise OR ) and ^ ( Bitwise Exclusive OR or XOR ). The valid datatypes for bitwise operators are BINARY, BIT, INT, SMALLINT, TINYINT, and VARBINARY.
SQL Logical Operator	The Logical operators are those that are true or false. The logical operators are AND , OR, NOT, IN, BETWEEN, ANY, ALL, SOME, EXISTS, and LIKE.
SQL Unary Operator	The SQL Unary operators perform such an operation which contain only one expression of any of the datatypes in the numeric datatype category.
*/
/*
Insert, Update and Delete:
Command	Description
INSERT INTO table_name VALUES (value_1, value_2,....)  Insert new rows into a table.
INSERT INTO table_name (column1, column2,...) VALUES (value_1, value_2,....)  Insert new rows into a table.
UPDATE table_name SET column_name_1 = new_value_1, column_name_2 = new_value_2 WHERE column_name = some_value	Update one or several columns in rows.
DELETE FROM table_name WHERE column_name = some_value	Delete rows in a table.
*/
/*
Select:
Command	Description
SELECT column_name(s) FROM table_name  Select data from a table.
SELECT * FROM table_name	Select all data from a table.
SELECT DISTINCT column_name(s) FROM table_name	Select only distinct (different) data from a table.
SELECT column_name(s) FROM table_name WHERE column operator value AND column operator value OR column operator value AND (... OR ...) ...	Select only certain data from a table.
SELECT column_name(s) FROM table_name WHERE column_name IN (value1, value2, ...)	The IN operator may be used if you know the exact value you want to return for at least one of the columns.
SELECT column_name(s) FROM table_name ORDER BY row_1, row_2 DESC, row_3 ASC, ...	Select data from a table with sort the rows.
SELECT column_1, ..., SUM(group_column_name) FROM table_name GROUP BY group_column_name	The GROUP BY clause is used with the SELECT statement to make a group of rows based on the values of a specific column or expression. The SQL AGGREGATE function can be used to get summary information for every group and these are applied to individual group.
SELECT column_name(s) INTO new_table_name FROM source_table_name WHERE query	Select data from table(S) and insert it into another table.
SELECT column_name(s) IN external_database_name FROM source_table_name WHERE query	Select data from table(S) and insert it in another database.
*/
/*
Functions:
SQL functions	Description
Aggregate Function	This function can produce a single value for an entire group or table. Some Aggregate functions are -
SQL Count function
SQL Sum function
SQL Avg function
SQL Max function
SQL Min function

Arithmetic Function	A mathematical function executes a mathematical operation usually based on input values that are provided as arguments, and return a numeric value as the result of the operation. 
Some Arithmetic functions are -
abs()
ceil()
floor()
exp()
ln()
mod()
power()
sqrt()

Character Function	A character or string function is a function which takes one or more characters or numbers as parameters and returns a character value. Some Character functions are -
lower()
upper()
trim()
translate()
*/
/*
Joins:
Name	Description
SQL EQUI JOIN	The SQL EQUI JOIN is a simple SQL join uses the equal sign(=) as the comparison operator for the condition. It has two types - SQL Outer join and SQL Inner join.  SQL INNER JOIN returns all rows from tables where the key record of one table is equal to the key records of another table.  SQL OUTER JOIN returns all rows from one table and only those rows from the secondary table where the joined condition is satisfying i.e. the columns are equal in both tables.

SQL NON EQUI JOIN	The SQL NON EQUI JOIN is a join uses comparison operator other than the equal sign like >, <, >=, <= with the condition.
*/
/*
Union:
Command	Description
SQL_Statement_1 UNION SQL_Statement_2	Select all different values from SQL_Statement_1 and SQL_Statement_2
SQL_Statement_1 UNION ALL SQL_Statement_2	Select all values from SQL_Statement_1 and SQL_Statement_2
*/
/*
View:
Command	Description
CREATE VIEW view_name AS SELECT column_name(s) FROM table_name WHERE condition	Create a virtual table based on the result-set of a SELECT statement.
*/