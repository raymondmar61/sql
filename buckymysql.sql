/* Bucky 4 Show and Select, 5 Basic Rules for SQL Statements, 6 Getting Multiple Columns, 7 Distinct and Limit, 8 Sorting Results, 9 Sort Direction, 10 Basic Data Filtering and WHERE, 11 Advanced Filtering Using AND and OR, 12 Are you IN or are you NOT IN, 13 How Search Engines Work, 14 More on Wildcards, 15 Regular Expressions, 16 Creating Custom Columns, 17 Functions, 18 More on Aggregate Functions, 19 GROUP BY, 20 Subqueries, 21  Another Subquery Example, 22 How to Join Tables, 23 Outer Joins, 24 UNION, 25 Full Text Searching, 26 INSERT INTO, 27 How to Insert Multiple Rows, 28 UPDATE DELETE, 29 Create Table, 30 NOT NULL AUTO INCREMENT, 31 ALTER DROP RENAME TABLE, 32 Views, 33 Final Video.  */

SHOW DATABASES /* lists all databases in server.  In my ININ webserver, they're information_schema and innova18_database */

SHOW TABLES /* returns a list of tables in the database */

SHOW COLUMNS
FROM customers /* returns columns and the columns' properties */

SELECT city
FROM customers

SELECT city
FROM customers; /*separate multiple queries with a semicolon */

SELECT id
FROM customers; /*separate multiple queries with a semicolon */

SELECT name, zip
FROM customers;

SELECT *
FROM customers;

SELECT DISTINCT state
FROM customers;

SELECT id, name
FROM customers
LIMIT 5; /*Use LIMIT keyword to restrict number of search results one number for LIMIT */

SELECT id, name
FROM customers
LIMIT 5,10; /* LIMIT number left of comma is the starting point and right of comma is the how many rows to return.  Left of comma starting point is +1 because SQL starting count is zero search results two numbers for LIMIT.  A range of data to be returned. */

/* The two SQL statements below return the same results.  They're written differently */
SELECT address
FROM customers
SELECT customers.address
FROM customers

SELECT name, address
FROM customers
ORDER BY id

SELECT state, city, name
FROM customers
ORDER BY state, name

SELECT name, zip
FROM customers
ORDER BY zip DESC

SELECT name, id
FROM customers
ORDER BY id DESC
LIMIT 1

SELECT id, name
FROM customers
WHERE id = 54 /* id != 54 is the not equal */

SELECT id, name
FROM customers
WHERE id < 8

SELECT id, name
FROM customers
WHERE id BETWEEN 25 AND 30 /* 25 AND 30 are inclusive */

SELECT name, state
FROM customers
WHERE state = "CA"

SELECT name, state, city
FROM customers
WHERE state = "CA" AND city = "Hollywood"

SELECT name, state, city
FROM customers
WHERE city = "Boston" OR state = "CA"

/* Use paranthesis.  Different results appear */
SELECT id, name, city
FROM customers
WHERE id = 1 OR id = 2 AND city="Raleigh"
SELECT id, name, city
FROM customers
WHERE (id = 1 OR id = 2) AND city="Raleigh"

SELECT name, state
FROM customers
WHERE state IN ("CA","NC","NY")
SELECT name, state
FROM customers
WHERE state NOT IN ("CA","NC","NY")

/* % wild card like the * symbol */
SELECT name
FROM items
WHERE name LIKE "new%"
SELECT name
FROM items
WHERE name LIKE "%computer%"
SELECT city
FROM customers
WHERE city LIKE "h%d" /* return results city begins with h and ends with d */

/* _ wild card one character */
SELECT name
FROM items
WHERE name LIKE "_ boxes of frogs"

SELECT name
FROM items
WHERE name REGEXP "new" /* return results where "new" is anywhere in name */
SELECT name
FROM items
WHERE name REGEXP ".boxes" /* any single character appears before boxes returns record in its entirety; e.g. 3 boxes of frogs, 48 boxes of frogs, 7 boxes of frogs */
SELECT name
FROM items
WHERE name REGEXP "gold|car" /* return results where gold or car is anywhere in name */
SELECT name
FROM items
WHERE name REGEXP "[12345] boxes of frogs" /* return 1 boxes of frogs, 2 boxes of frogs, 3 boxes of frogs, 4 boxes of frogs, or 5 boxes of frogs */
SELECT name
FROM items
WHERE name REGEXP "[1-5] boxes of frogs" /* return 1 boxes of frogs, 2 boxes of frogs, 3 boxes of frogs, 4 boxes of frogs, or 5 boxes of frogs */
SELECT name
FROM items
WHERE name REGEXP "[^12345] boxes of frogs" /* don't return 1 boxes of frogs, 2 boxes of frogs, 3 boxes of frogs, 4 boxes of frogs, and 5 boxes of frogs */
SELECT name
FROM items
WHERE name REGEXP "[1245,48,7] boxes of frogs" /* return 1 boxes of frogs, 2 boxes of frogs, 4 boxes of frogs, 5 boxes of frogs, 48 boxes of frogs, or 7 boxes of frogs */
/* instructor says there are more REGEXP beyond his tutorial */

/* concatenate two columns and/or add text to the column name with a new column name after AS */
SELECT CONCAT(city, ", ", state) AS new_address /* e.g., returns city, state or Adams, NY */
FROM customers

SELECT name, cost, cost-1 AS sale_price /* take cost, subtract one, and name column three sale_price */
FROM items

SELECT name, UPPER(name)
FROM customers

SELECT cost, SQRT(cost)
FROM items

SELECT AVG(cost)
FROM items
SELECT SUM(bids)
FROM items

SELECT COUNT(name)
FROM items
WHERE seller_id=6
SELECT AVG(cost)
FROM items
WHERE seller_id=6

SELECT COUNT(*) AS item_count, MAX(cost) as max, AVG(cost) as avg
FROM items
WHERE seller_id=12 /* returns one row item_count 5, max 5700.5, avg 1421.2699996948243 */

SELECT seller_id, COUNT(*) AS item_count
FROM items
WHERE seller_id=1 /* returns one row seller_id 1, item_count 2 */
SELECT seller_id, COUNT(*) AS item_count
FROM items
WHERE seller_id=2 /* returns one row seller_id 2, item_count 2 */
SELECT seller_id, COUNT(*) AS item_count
FROM items
WHERE seller_id=3 /* returns one row seller_id 3, item_count 1 */
SELECT seller_id, COUNT(*) AS item_count
FROM items
GROUP BY seller_id /* easier using GROUP BY instead of WHERE searching seller_id one at at time */
SELECT seller_id, COUNT(*) AS item_count
FROM items
GROUP BY seller_id
HAVING COUNT(*) >=3 /* easier using GROUP BY instead of WHERE searching seller_id one at at time.  However, sellers must have item_count 3 or greater.  It's like a WHERE clause.  Using HAVING when using GROUP BY */
ORDER BY item_count DESC /* okay to order by a temporary column name such as item_count */

/* Subquery is a query inside another query.  Instructor says the quick example admit it's useless; there's an easier way.  Want items price is above average.  First, find the average price.  Second, find the items above the average price found in first. */
/* SQL queries are run inside out */
SELECT AVG(cost)
FROM items /* returns 463.93710062742235.  First. */
SELECT name, cost
FROM items
WHERE cost >
	(SELECT AVG(cost)
	FROM items)
ORDER BY cost DESC /* Second. */

/* Find which seller sells the cheapest frogs.  First, find all sellers selling frogs.  Second, find the minimal cost for all boxes of frogs.  */
SELECT seller_id
FROM items
WHERE name LIKE "%boxes of frogs%" /* First. */
SELECT name, min(cost)
FROM items
WHERE name LIKE "%boxes of frogs%"
AND seller_id In 
	(SELECT seller_id
	FROM items
	WHERE name LIKE "%boxes of frogs%") /* Second. */

SELECT customers.id, customers.name, items.name, items.cost
FROM customers, items
WHERE customers.id=seller_id
ORDER BY customers.id
SELECT c.id, c.name, i.name, i.cost
FROM customers as c, items as i
WHERE c.id=i.seller_id
ORDER BY c.id

SELECT customers.name, items.name
FROM customers, items
WHERE customers.id=items.seller_id
SELECT customers.name, items.name
FROM customers LEFT OUTER JOIN items
ON customers.id=items.seller_id
SELECT customers.name, items.name
FROM customers RIGHT OUTER JOIN items
ON customers.id=items.seller_id

/* I could have used AND OR keywords in WHERE to acheive the same results-->bids > 190 OR cost > 1000 */
/* Instructor says UNION good for more complex filtering.  Important the columns must be the same implying the tables must be the same.  UNION removes duplicate entries.  */
SELECT name, cost, bids
FROM items
WHERE bids > 190
UNION
SELECT name, cost, bids
FROM items
WHERE cost > 1000
/* UNION ALL includes duplicate entries */
SELECT name, cost, bids
FROM items
WHERE bids > 190
UNION ALL
SELECT name, cost, bids
FROM items
WHERE cost > 1000

ALTER TABLE items
ADD FULLTEXT(name) /* Full text searching. The SQL code enable full text searching.  In this case, we enable full text searching for the name column.  We can search like a search engine for name column.  */
SELECT name, cost
FROM items
WHERE Match(name) Against("baby") /* Match what column.  name column.  Against what search parameters.  search for "baby" in Aginast paranthesis.  I could have used the LIKE SQL code.  Instructor responds FULLTEXT ranks the results.  FULLTEXT is faster.  FULLTEXT can be customized further.  There are more options or symbols FULLTEXT.  Instructor demonstarates two options.  */
SELECT name, cost
FROM items
WHERE Match(name) Against("+baby -coat" IN BOOLEAN MODE) /* Search results must have baby and must not have coat */

INSERT INTO items
VALUES ("101","bacon strips","9.95","1","0") /* items table columns left to right: id, name, cost, seller_id, bids.  Insert the new record in order of the columns left to right. */
INSERT INTO items(id, name, cost, seller_id, bids)
VALUES ("102","fish n chips","7.99","1","0")
INSERT INTO items(id, cost, name)
VALUES ("103","7.77","beef on a stick")

/* Insert multiple rows of data */
INSERT INTO items(id, name, cost, seller_id, bids)
VALUES ("104","beef chops","7.99","1","0"),("105","jelly pockets","4.50","1","0"),("106","sack of ham","9.95","1","0")

INSERT INTO items (id, name, cost, seller_id, bids)
SELECT id, name, cost, seller_id, bids
FROM fakeitemstable
WHERE bids >= 1 /* insert items from fakeitemstable table to items table bids one or greater*/

UPDATE items
SET name = "pudding hammock" /* updates all records name is pudding hammock */
UPDATE items
SET name = "pudding hammock"
WHERE id = 106
UPDATE items
SET name = "frog paste", bids = 66
WHERE id = 106

DELETE
FROM items
WHERE id = 104

CREATE TABLE users(
    id int,
    username varchar(30),
    password varchar(20),
    PRIMARY KEY(id)
)

username varchar(30) NOT NULL /* Add the words NOT NULL when creating a table the column data must be filled */

id int NOT NULL AUTO_INCREMENT /* AUTO_INCREMENT automatically add one to the last id when a new row is created.  When creating a new table, AUTO_INCREMENT starts a default 1 and adds one each time.  */

CREATE TABLE people(
    id int NOT NULL AUTO_INCREMENT,
    username varchar(30) NOT NULL,
    password varchar(20) NOT NULL
    PRIMARY KEY(id)
)

ALTER TABLE users ADD addnewcolumnname varchar(10) /* add a new column */
ALTER TABLE users DROP COLUMN addnewcolumnname /* delete an existing column */
DROP TABLE users /* delete an existing table */
RENAME TABLE customers TO customerstablenewname /* change a table name */

/* Views are temporary tables */
/* Create temporary table show top ten items most bids */
SELECT id, name, bids
FROM items
ORDER BY bids DESC
LIMIT 10
/* temporary table viewnamemostbids as a view created show top ten items most bids.  viewnamemostbids view contains no data.  The data is from items table.  It's like a dynamic table because the view updates when items table updates.  View don't require additional memory.  */
CREATE VIEW viewnamemostbids AS (SELECT id, name, bids
FROM items
ORDER BY bids DESC
LIMIT 10)

CREATE VIEW mailing AS (SELECT CONCAT(city, ", ", state) AS address
FROM customers)

/* we can run queries on views */
SELECT name, bids
FROM viewnamemostbids

/* Backup the database.  Click Export in phpMyAdmin.  Accept the defaults.  */
/* Backup the database.  Click Export in phpMyAdmin.  Accept the defaults.  */