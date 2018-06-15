#Chapter 03 Understanding Data Types (p 23)
#RM:  analysis database
#data dictionary:  a document that lists each column, specifies whether it's a number, character, or other type, and explains the column values.
#Chapter 04 there is a data type money.

create table characters (char_alwaysfixedlength char(20), varchar_variablelengthupto20 varchar(20), text_unlimitedlength1gb text);
create table char_data_types (varchar_column varchar(20), char_column char(20), text_column text);
insert into char_data_types 
values ('abcvarchar','abcchar','abctext'), ('defghivarchar','defghichar','defghhitext');  --if values statement match the number of columns in the table, the database assumes you're inserting values in the order the column definitions were specified
copy char_data_types to 'I:\Program Files\PostgreSQL\exportdata.txt'
with (format csv, header, delimiter '|'); --export data to a text file to desktop.  RM: can't export to desktop.  Also, notice char_column is always 20 character length.

create table integernumbers (smallint_plusminus32767 smallint, integer_plusminus2147483648 integer, bigint_plusminus9223372036854775808 bigint);
create table autoincrementingintegers (bigserial_ bigserial_, smallserial_ smallserial_, serial_ serial);  --PostgreSQL auto-increment the value when inserting a row starting with 1 up to the maximum to each integer type
create table decimalnumbers (numeric_fixedpointtotalcommarightofdecimal numeric(5,2), decimal_fixedpointtotalcommarightofdecimal decimal(5,2), real_sixdecimaldigits real, double_precision_15decimaldigits double precision);  --(5,2) means up to five digits, two must be right of decimal.
create table number_data_types (numeric_column numeric(20,5), real_column real, double_column double precision);
insert into number_data_types
values (.7, .7, .7), (2.13579, 2.13579, 2.13579), (2.1357987654, 2.1357987654, 2.1357987654);

create table dateandtimes (timestamp_dateandtime timestamp timestamp_dateandtimewithtimezone timestamp with time zone, date_date date, time_time time, interval_time interval);

/* The CAST() function transform a value fro its stored data type to another type; e.g. retrieve a number as a character to you can combine it with text or treat a date stored as characters as an actual date type. */
select numeric_column, cast(numeric_column as integer), cast(numeric_column as varchar(6))
from number_data_types;
