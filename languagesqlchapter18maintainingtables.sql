#The Language Of SQL by Larry Rockoff Chapter 18 Maintaining Tables

/*
Data Manipulation Language (DML) allows manipulating data in relatinoal databases by retrieval, insertion, deletion, or update.  Statements used are SELECT, INSERT, DELETE, and UPDATE.  Data Definition Language (DDL) statements used are CREATE VIEW, CREATE PROCEDURE, ALTER, and DROP.  Also DDL statements are CREATE which includes CREATE TABLE, CREATE VIEW, and CREATE PROCEDURE.

MySQL refers to auto-increment.  Oracle doesn't have an auto-increment type.  Instead, define a column as a sequence and create a trigger to populate the column with sequence values.  Microsoft refers to identity as auto-increment.

Indexes speed up data retrieval when the column is involved in a SQL statement.  A downside to indexing a column is more disk storage.  Another negative is slower data updates.  Any column can be indexed; however, one column can be designated as a primary key.   A primary key can span more than one column.  If the primary key contains more than one column, all those columns together contain a unique value called a composite primary key.  A foreign key is a reference from a column in one table to a column in a different table.  The foreign key column is in the child table.  The referenced column in the other table is in the parent table.
*/

create table tablenamemysql
columnoneintegerdatatype int auto_increment primary key not null,
columntwointegerdatatype int not null,
columnthreevarchardatatypenullvaluesokay varchar(25) null,
columnfourfloatdatatypenullvaluesokaydefaultvalueone float null default 1.0,
constraint foreign key columntwointegerdatatype references relatedtable (relatedtablefirstcolumnprimarykey);
create table tablenameoracle
columnoneintegerdatatype int primary key not null,
columntwointegerdatatype int not null,
columnthreevarchardatatypenullvaluesokay varchar(25) null,
columnfourfloatdatatypenullvaluesokaydefaultvalueone float null default 1.0,
constraint "constraintnameinquotes" foreign key columntwointegerdatatype references relatedtable (relatedtablefirstcolumnprimarykey);
alter table tablename
drop column columnnametodeletecolumn;
drop table tablenametodeletetable;
alter table tablename
create index columnnameaddindex;
create index indexname
on tablenamemicrosoftsqlserver (columnnameaddindex);
drop index indexname
on tablenamemicrosoftsqlserver;
drop index indexnameoracle;