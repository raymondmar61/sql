#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/soccer-database-exercise/basic-exercises-on-soccer-database.php

#1. Write a query in SQL to find the number of venues for EURO cup 2016.
select count(*)
from soccer_venue;

#2. Write a query in SQL to find the number countries participated in the EURO cup 2016.
select count(distinct team_id)
from player_mast;

#3. Write a query in SQL to find the number goals scored in EURO cup 2016 within normal play schedule.
select count(goal_id)
from goal_details
where goal_schedule = 'NT';  #goal_schedule – when the goal came, normal play NT or in stoppage time ST or in extra time ET

#4. Write a query in SQL to find the number of matches ended with a result.
select count(*)
from match_mast
where results = 'WIN';

#5. Write a query in SQL to find the number of matches ended with draws.
select count(*)
from match_mast
where results = 'DRAW';

#6. Write a query in SQL to find the date when did Football EURO cup 2016 begin.
select min(play_date)
from match_mast;

#7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.
select count(*)
from goal_details
where goal_type = 'O';  #goal_type – this is the type of goal which came in normally N or own goal indicating by O and goal came from penalty P

#8. Write a query in SQL to count the number of matches ended with a results in group stage.  #RM:  solution says must be a win.
select count(*)
from match_mast
where results = 'WIN'
and play_stage = 'G';

#9. Write a query in SQL to find the number of matches got a result by penalty shootout.
select count(distinct match_no)
from penalty_shootout;

#10. Write a query in SQL to find the number of matches were decided on penalties in the Round of 16.
select count(*)
from match_mast
where decided_by = 'P'
and play_stage = 'R';

#11. Write a query in SQL to find the number of goal scored in every match within normal play schedule.
select match_no, count(match_no)
from goal_details
where goal_schedule = 'NT'
group by match_no
order by match_no;

#12. Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play.
select match_no, play_date, goal_score
from match_mast
where stop1_sec = 0;

#13. Write a query in SQL to find the number of matches ending with a goalless draw in group stage of play.
select count(distinct match_no)
from match_details
where win_lose = 'D'
and goal_score = 0
and play_stage = 'G';
#RM:  lol my select statement is select count(*)/2

#14. Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout.
select count(match_no)
from match_details
where win_lose = 'W'
and goal_score = 1
and decided_by <> 'P';

#15. Write a query in SQL to find the total number of players replaced in the tournament.
select count(*)
from player_in_out
where in_out = 'I';

#16. Write a query in SQL to find the total number of palyers replaced within normal time of play.
select count(*)
from player_in_out
where in_out = 'I'
and play_schedule = 'NT';