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

#17. Write a query in SQL to find the number of players replaced in the stoppage time.
select count(*)
from player_in_out
where in_out = 'I'
and play_schedule = 'ST';

#18. Write a query in SQL to find the total number of players replaced in the first half of play.
select count(*)
from player_in_out
where in_out = 'I'
and play_schedule = 'NT'
and play_half = 1;
#Normal Time must be included in query because don't want first half of play in extra time or OT.

#19. Write a query in SQL to find the total number of goalless draws have there in the entire tournament.
select count(distinct match_no)
from match_details
where win_lose = 'D'
and goal_score = 0;

#20. Write a query in SQL to fine the total number of players replaced in the extra time of play.
select count(*)
from player_in_out
where play_schedule = 'ET'
and in_out = 'I';

#21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament.
select play_half, play_schedule, count(*)
from player_in_out
where in_out = 'I'
group by play_half, play_schedule
order by play_half, play_schedule;

#22. Write a query in SQL to find the number of shots taken in penalty shootout matches.
select count(*)
from penalty_shootout;

#23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches.
select count(*)
from penalty_shootout
where score_goal = 'Y';

#24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches.
select count(*)
from penalty_shootout
where score_goal = 'N';

#25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.
select player.player_name, count(score_goal)
from player_mast player inner join penalty_shootout penalty
on player.player_id = penalty.player_id
group by player.player_name;
#official solution
select c.match_no,a.country_name as "Team", b.player_name, b.jersey_no, c.score_goal ,c.kick_no
from soccer_country a, penalty_shootout c, player_mast b
where c.team_id=a.country_id
and c.player_id=b.player_id;

#26. Write a query in SQL to find the number of penalty shots taken by the teams.
select sc.country_name, count(ps.*)
from soccer_country sc inner join penalty_shootout ps
on ps.team_id = sc.country_id
group by sc.country_name;
#official solution
select a.country_name, count(b.*) as "Number of Shots" 
from soccer_country a, penalty_shootout b
where b.team_id=a.country_id
group by a.country_name;

#27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule.
select play_half, count(booking_time)
from player_booked
where play_schedule = 'NT'
group by play_half;

#28. Write a query in SQL to find the number of booking happened in stoppage time.
select count(booking_time)
from player_booked
where play_schedule = 'ST';

#29. Write a query in SQL to find the number of booking happened in extra time.
select count(booking_time)
from player_booked
where play_schedule = 'ET';
