#https://www.codecademy.com/learn/sql-analyzing-business-metrics

#1 Advanced Aggregates
/*
orders 4999 rows
id	int
ordered_at	text
delivered_at	text
delivered_to	int
order_items 20000 rows
id	int
order_id	int
name	text
amount_paid	real
*/
select *
from order_items
order by id
limit 100;
#Let's get a Daily Count of orders from the orders table. Complete the query using the date function to cast the timestamps in ordered_at to dates.
select date(ordered_at), count(ordered_at)
from orders
group by 1
order by 1;
#Daily Count query to get the revenue.
select date(ordered_at), round(sum(amount_paid),2)
from orders join order_items
on orders.id = order_items.order_id
group by 1
order by 1;
#What's the daily revenue from customers ordering kale smoothies?
select date(ordered_at), round(sum(amount_paid),2)
from orders join order_items
on orders.id = order_items.order_id
where order_items.name = "kale-smoothie"
group by 1
order by 1;
#The following query groups and sum the products by price to get the total revenue for each item.
#First, sum revenue by name or total revenue for each item.
select name, round(sum(amount_paid), 2)
from order_items
group by name
order by 2 desc;
#We have the sum of the the products by revenue, but we still need the percent. For that, we'll need to get the total using a subquery. A subquery can perform complicated calculations and create filtered or aggregate tables on the fly.
select name, round(sum(amount_paid) / (
	select sum(amount_paid) from order_items) * 100.0, 2) as pct
from order_items
group by 1
order by 2 desc;  #RM, wow!
/*
name	pct
tikka-masala	31.7
grilled-cheese	21.6
chicken-parm	19.95
blt	14.75
soda	5.48
orange-juice	2.94
cake	2.71
banana-smoothie	0.53
kale-smoothie	0.35
*/
#We'll build our own categories using a case statement. Complete the query below with a case condition of name that lists out each product, and decides its group.
select *,
	case name
		when 'kale-smoothie'    then 'smoothie'
		when 'banana-smoothie'  then 'smoothie'
		when 'orange-juice'     then 'drink'
		when 'soda'             then 'drink'
		when 'blt'              then 'sandwich'
		when 'grilled-cheese'   then 'sandwich'
		when 'tikka-masala'     then 'dinner'
		when 'chicken-parm'     then 'dinner'
		else 'other'
	end as category
from order_items
order by id
limit 100;
#Add the denominator that will sum the amount_paid.
select case name
	when 'kale-smoothie'    then 'smoothie'
	when 'banana-smoothie'  then 'smoothie'
	when 'orange-juice'     then 'drink'
	when 'soda'             then 'drink'
	when 'blt'              then 'sandwich'
	when 'grilled-cheese'   then 'sandwich'
	when 'tikka-masala'     then 'dinner'
	when 'chicken-parm'     then 'dinner'
	else 'other'
	end as category, round(1.0*sum(amount_paid)/(select sum(amount_paid) from order_items)*100,2) as pct
from order_items
group by 1
order by 2 desc;
/*
category	pct
dinner	51.64
sandwich	36.34
drink	8.42
other	2.71
smoothie	0.88
*/
#We'll create a metric called reorder rate and see how that compares to the other products at SpeedySpoon.  We'll define reorder rate as the ratio of the total number of orders to the number of people making those orders. A lower ratio means most of the orders are reorders. A higher ratio means more of the orders are first purchases.
#Counting the total orders per product is straightforward. We count the distinct order_ids in the order_items table.
select name, count(distinct order_id)
from order_items
group by 1
order by 1;
/*
name	count(distinct order_id)
banana-smoothie	105
blt	2175
cake	669
chicken-parm	2487
grilled-cheese	2832
kale-smoothie	72
orange-juice	905
soda	2041
tikka-masala	3168
*/
#Source count distinct values https://stackoverflow.com/questions/141562/sql-to-find-the-number-of-distinct-values-in-a-column
#Now we need the number of people making these orders.  To get that information, we need to join in the orders table and count unique values in the delivered_to field, and sort by the reorder_rate.
select name, round(1.0 * count(distinct order_id) / count(distinct orders.delivered_to), 2) as reorder_rate
from order_items join orders
on orders.id = order_items.order_id
group by 1
order by 2 desc;
/*
name	reorder_rate
banana-smoothie	10.5
kale-smoothie	7.2
tikka-masala	3.32
grilled-cheese	3.06
chicken-parm	2.72
blt	2.49
soda	2.38
orange-juice	1.5
cake	1.4
*/
#Wow! That's unexpected. While smoothies aren't making a lot of money for SpeedySpoon, they have a very high reorder rate. That means these smoothie customers are strong repeat customers.
#Instead of recommending smoothies be taken off the menu, we should talk to the smoothie customers and see what they like so much about these smoothies. There could be an opportunity here to expand the product line, or get other customers as excited as these kale fanatics. Nice work!
/*
Let's generalize what we've learned so far:
Data aggregation is the grouping of data in summary form.
Daily Count is the count of orders in a day.
Daily Revenue Count is the revenue on orders per day.
Product Sum is the total revenue of a product.
Subqueries can be used to perform complicated calculations and create filtered or aggregate tables on the fly.
Reorder Rate is the ratio of the total number of orders to the number of people making orders.
*/