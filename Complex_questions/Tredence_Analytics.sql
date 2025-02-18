PROBLEM STATEMENT : Several friends at Cinema ticket office would like to reserve consecutive available seats. Write a query to get all the consecutive available seats order by seat_id .

SCRIPTS : 
CREATE TABLE cinema (
 seat_id INT PRIMARY KEY,
 free int
);
delete from cinema;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);

Solution 1: 
with cte as(
select *, lead(free) over (order by seat_id) as next_seat ,lag(free) over (order by seat_id) as prev_seat   from cinema 
)

select seat_id from cte where free=1 and (next_seat=1 or prev_seat=1);

Solution 2:

with cte1 as(
select *, row_number() over(order by seat_id) as rn,seat_id- row_number() over(order by seat_id) 
 as grp from cinema where free=1
)
select seat_id from(
select *,count(*) over (partition by grp) as cnt from cte1 )  as new where cnt >1 ;

Solution 3:


with cte3 as(
select c1.seat_id as s1,c2.seat_id as s2 from cinema c1 join cinema c2 on c1.seat_id+1=c2.seat_id 
where c1.free=1 and c2.free=1
)

select s1 from cte3 union select s2 from cte3;

