create table car (carmodel varchar2(20));

create table categories (category varchar2(50), id number constraint categoriespk primary key);
alter table categories rename constraint categoriespk to id_pk;  --rename constraint rename primary key

create table expenses (id number constraint expenses_pk primary key, expensedate date, event varchar2(30), category varchar2(40), name varchar2(50), amount float, payment_method varchar2(17), comments varchar2(250), subtractbudget varchar2(5), gallons float, pricepergallon float, tax float, goingout varchar2(13), tip float);  --date is a reserved word
set define off --https://stackoverflow.com/questions/12961215/escaping-ampersand-character-in-sql-string.  no semicolon
set define on --https://stackoverflow.com/questions/12961215/escaping-ampersand-character-in-sql-string.  no semicolon
alter table expenses modify event varchar2(35);

create table personplace (id number constraint personplaceid_pk primary key, personplace varchar2(60), streetnumber number, streetdirection varchar2(1), streetname varchar2(50), suite varchar2(10), city varchar2(20), state varchar2(2), zip number, comments varchar2(60));  --I can't use id_pk for the second time because id_pk used for categories table.  I use personplaceid_pk
set define off --https://stackoverflow.com/questions/12961215/escaping-ampersand-character-in-sql-string.  no semicolon
set define on --https://stackoverflow.com/questions/12961215/escaping-ampersand-character-in-sql-string.  no semicolon

create table reasongoingout (id number constraint reasongoingout_pk primary key, reasonwentout varchar2(13));