--Sams Teach Yourself SQL In 10 Minutes by Ben Forta
--Primary key values can never be reused. (If a row is deleted from the table, its primary key may not be assigned to any new rows in the future.)
--Appendix E SQL Reserved Words list most common reserved words.

--Lesson 2 Retrieving Data 24
--As a rule, you are better off not using the * wildcard unless you really do need every column in the table. Even though use of wildcards may save you the time and effort needed to list the desired columns explicitly, retrieving unnecessary columns usually slows down the performance of your retrieval and your application.
select prod_id, prod_name, prod_price
from products;