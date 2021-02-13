-- TIME DIFFERERENCE BETWEEN LATEST ACTIONS

-- From the following table of user actions, 
-- write a query to return for each user the time elapsed between the last action and the second-to-last action, 
-- in ascending order by user ID

create database if not exists practicedb;
use practicedb;

create table if not exists users(
user_id integer not null,
action varchar(40),
date date
);
/*
insert into users (user_id, action, date) 
VALUES 
(1, 'start', CAST('20-2-12' AS date)), 
(1, 'cancel', CAST('20-2-13' AS date)), 
(2, 'start', CAST('20-2-11' AS date)), 
(2, 'publish', CAST('20-2-14' AS date)), 
(3, 'start', CAST('20-2-15' AS date)), 
(3, 'cancel', CAST('20-2-15' AS date)), 
(4, 'start', CAST('20-2-18' AS date)), 
(1, 'publish', CAST('20-2-19' AS date));
*/
with t1 as(
select * from users order by user_id , date),
t2 as (select user_id, action,date, rank () over( partition by user_id order by date desc) action_rank from t1 ),
t3 as (select user_id, action, date from t2 where action_rank < 3)
select user_id,  (max(date) - min(date)) as diff from t3 group by user_id;

select user_id, action, date, row_number() over(partition by user_id order by date desc) num from users;
select user_id, action, date, rank() over(partition by user_id order by date desc) num from users;
