#create tables
create table sqlContracts ([Contract Num] number, [Customer ID] number, [Contract Amt] number, [Signing Date] date, [Contract Type] varchar(255));
#create table sqlContracts ([Contract Num] number, [Customer ID] number, [Contract Amt] number, [Signing Date] date, [Contract Type] short text);  #short text and shorttext Syntax Error
create index indexname
on sqlContracts ([Contract Num]) with primary; #create primary key Contract Num for table sqlContracts named indexname

create table sqlCustomers ([CustomerId] number, Company varchar(255), FirstName varchar(255), LastName varchar(255), Tel varchar(255), StreetAddress varchar(255), City varchar(255), State varchar(2), Zip number, Email varchar(255), Comments longtext); #RM:  long text 64,000 characters works
create index indexnamesqlCustomers
on sqlCustomers ([CustomerId]) with primary; #create primary key CustomerId for table sqlCustomers named indexnamesqlCustomers
alter table sqlCustomers
drop [CustomerId]; #Error message.  Cannon delete a field that is part of an index or is needed by the system.

create table sqlInvoices ([Invoice Num] number, [Contract Num] number, [Invoice Date] date, [Invoice Item] varchar(255), [Invoice Amt] number, [Invoice Paid] varchar(255));
create index indexsqlInvoices
on sqlInvoices ([Invoice Num]) with primary; #create primary key Invoice Num for table sqlInvoices named indexsqlInvoices

#delete all rows in sqlContracts table
delete *
from sqlContracts;

#customers with contracts
select FirstName, LastName, [Contract Num], [Signing Date], [Contract Type]
from Customers inner join Contracts
on Customers.CustomerID = Contracts.[Customer ID];

#simple calculated query customers with contracts and late fee
select FirstName, LastName, [Contract Num], [Signing Date], [Contract Type], [Contract Amt], round([Contract Amt]*1.05,2) as [5% added late fee]
from Customers inner join Contracts
on Customers.CustomerID = Contracts.[Customer ID];