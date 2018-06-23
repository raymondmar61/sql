#Chapter 17 Maintaining Your Database (p 313)
#Database maintenance and performance tuning are often the subjects of entire books.  Chapter is an introduction to a handful of essentials.  There are additional resoruces in the Appendix.

--Vacuum shrinks the size of the database removing unused rows.  When a row is updated, the database creates a new version of that row that includes the updated value, but it doesn't delete the old version of the row.  These leftover rows you can't see as dead rows.  Likewise to deleted rows.  It lives on as a dead row in the table.  Vacuum designates the space occupied by dead rows as available for the database to use again.  Vacuum doesn't return the space to your system's disk.  Vacuum Full creates a new version of the table that doesn't included the freed-up dead row space.  You can run Vacuum on demand.  Default PostgreSQL runs the autovaccum background process and runs vaccum as needed.
select relname, last_vacuum, last_autovacuum, vacuum_count, autovacuum_count
from pg_stat_all_tables
where relname = 'employees';  --pg_stat_all_tables is a view.  relname is the table to run vacuum statistics on the table.
vacuum employees;  --run vacuum manually.  vacuum tablename;
vacuum full employees;  --run vacuum full manually.  vacuum full tablename;

--Change server settings.  Examples are enabling autovacuum, change date style datestyle, change time zone timezone, and default_text_search_config.  After you make changes to postgresql.conf, you must save the file and then reload settings using the pg_ctl PostgreSQL command to apply the new settings.  Go to Command Prompt, type pg_ctl reload -D "path".  For me, it's pg_ctl reload -D "I:\Program Files\PostgreSQL\10\data"
show config_file;  --find the location of postgresql.conf file.  My compuer is I:/Program Files/PostgreSQL/10/data/postgresql.conf.  View the file as a text file.
show data_directory;  --find the location of the data directory.  My computer is I:/Program Files/PostgreSQL/10/data

--Backup and restore.The PostgreSQL command line tool pg_dump creates an output file that contains all the data from your database, SQL commands for re-creating tables, and other database objects, as well as loading the data into tables.  You can also use pg_dump to save only selected tables.  Default is pg_dump outputs a plain text file.
--e.g. to backup the analysis database, run the command below
pg_dump -d analysis -U postgres -Fc > analysis_backup.sql  --RM:  I set up the command line for psql.  The procedure is Chapter 16 p 292-295.  Also, the command I ran required a password.  postgres is the username.  analysis_backup.sql is the backup file name.  The analysis_backup.sql file was saved in C:\Users\Mar.
--to backup one or more tables that match a particular name, use the -t argument followed by the name of the table in single quotes.
pg_dump -t 'train_rides' -d analysis -U postgres -Fc > train_backup.sql  --train_rides is the table.  analysis is the database name.  postgres is the username.  train_backup.sql is the backup file name.
pg_dump -t employees -d analysis -U postgres -Fc > employees_backup.sql  --RM:  instructor says single quotes needed for table name.  It didn't work.  I ran the SQL code without single quotes.  It worked.
pg_restore -C -d postgres -U postgres analysis_backup.sql  --pg_restore -C -d database name -U username backup file name
--There are additional options for pg_dump not mentioned in the book.  Visit https://www.postgresql.org/docs/current/static/app-pgdump.html for documentation.