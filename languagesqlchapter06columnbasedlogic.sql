#The Language Of SQL by Larry Rockoff Chapter 06 Column-Based Logic
select grade_level, case grade_level when 'A' then 'Excellent' when 'B' then 'Above Average' when 'C' then 'Average' when 'D' then 'Below Average' when 'F' then 'Failed' else 'Incomplete Grade' end as 'New Column Created Grade Explanation', lowest_sal, highest_sal
from jobgrades;
/*
grade_level	New Column Created Grade Explanation	lowest_sal	highest_sal	
A	Excellent	1000	2999	
B	Above Average	3000	5999	
C	Average	6000	9999	
D	Below Average	10000	14999	
E	Incomplete Grade	15000	24999	
F	Failed	25000	40000	
*/
select case when manager_id >= 200 then 'Top Manager' when manager_id >=140 and manager_id <=199 then 'Middle Manager'  when manager_id >=100 and manager_id <=139 then 'Low Manager' else 'No Manager' end as 'New Column Manager Description', manager_id, department_id, department_name
from departments;
/*
New Column Manager Description	manager_id	department_id	department_name	
Top Manager	200	10	Administration	
Top Manager	201	20	Marketing	
Low Manager	114	30	Purchasing	
Top Manager	203	40	Human Resources	
Low Manager	121	50	Shipping	
Low Manager	103	60	IT	
Top Manager	204	70	Public Relations	
Middle Manager	145	80	Sales	
Low Manager	100	90	Executive	
Low Manager	108	100	Finance	
Top Manager	205	110	Accounting	
No Manager	0	120	Treasury	
No Manager	0	130	Corporate Tax	
No Manager	0	140	Control And Credit	
No Manager	0	150	Shareholder Services	
No Manager	0	160	Benefits	
No Manager	0	170	Manufacturing	
No Manager	0	180	Construction	
No Manager	0	190	Contracting	
No Manager	0	200	Operations	
No Manager	0	210	IT Support	
No Manager	0	220	NOC	
No Manager	0	230	IT Helpdesk	
No Manager	0	240	Government Sales	
No Manager	0	250	Retail Sales	
*/
select case when country_id = 'CA' then 'Canada country_id column' when country_name = 'United States of Ame' then 'USA country_name column' when region_id=3 then 'Region 3 Asia' else '' end as 'New Column look at the three other columns', country_id, country_name, region_id
from countries
where country_id = 'CA'
or country_name = 'United States of Ame'
or region_id in (1,2,3);
/*
New Column look at the three other columns	country_id	country_name	region_id	
	AR	Argentina	2	
Region 3 Asia	AU	Australia	3	
	BE	Belgium	1	
	BR	Brazil	2	
Canada country_id column	CA	Canada	2	
	CH	Switzerland	1	
Region 3 Asia	CN	China	3	
	DE	Germany	1	
	DK	Denmark	1	
	FR	France	1	
Region 3 Asia	IN	India	3	
	IT	Italy	1	
Region 3 Asia	JP	Japan	3	
Region 3 Asia	ML	Malaysia	3	
	MX	Mexico	2	
	NL	Netherlands	1	
Region 3 Asia	SG	Singapore	3	
	UK	United Kingdom	1	
USA country_name column	US	United States of Ame	2	
*/