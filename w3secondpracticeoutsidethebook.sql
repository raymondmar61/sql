#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php

#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php

#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city <> 'New York'
or grade <= 100;  #RM:  incorrect.  It's a neither nor
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';
#also
select *
from customer
where cust_name between 'A%' and 'C%';
#also
select *
from customer
where cust_name between 'A' and 'C';