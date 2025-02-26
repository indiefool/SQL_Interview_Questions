You are given a table of distances between cities. You need to remove duplicates in case the distance is also the same.

Also when you remove duplicates keep the first one in output. 

CREATE TABLE city_distance
(
 distance INT,
 source VARCHAR(512),
 destination VARCHAR(512)
);

delete from city_distance;
INSERT INTO city_distance(distance, source, destination) VALUES ('100', 'New Delhi', 'Panipat');
INSERT INTO city_distance(distance, source, destination) VALUES ('200', 'Ambala', 'New Delhi');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Bangalore', 'Mysore');
INSERT INTO city_distance(distance, source, destination) VALUES ('150', 'Mysore', 'Bangalore');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Mumbai', 'Pune');
INSERT INTO city_distance(distance, source, destination) VALUES ('250', 'Pune', 'Mumbai');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Chennai', 'Bhopal');
INSERT INTO city_distance(distance, source, destination) VALUES ('2500', 'Bhopal', 'Chennai');
INSERT INTO city_distance(distance, source, destination) VALUES ('60', 'Tirupati', 'Tirumala');
INSERT INTO city_distance(distance, source, destination) VALUES ('80', 'Tirumala', 'Tirupati');

------------------------------------------------------------------------------------------------
Solution 1
------------------------------------------------------------------------------------------------

select a.* from city_distance a left join city_distance b on a.source=b.destination and a.destination=b.source

where b.distance is null or a.distance!=b.distance or a.source < a.destination


------------------------------------------------------------------------------------------------
Solution 2
------------------------------------------------------------------------------------------------

with cte as (
select *, case when source < destination then source else destination end  as city1,

case when source < destination then destination else source  end  as city2 from city_distance 
)
,
cte1 as(
select  *,count(*) over(partition by city1,city2,distance) as cnt from cte 
)

select  distance, source, destination from cte1 where cnt=1 or (source < destination);


------------------------------------------------------------------------------------------------
Solution 3
------------------------------------------------------------------------------------------------

with cte as(
select *, row_number() over(order by (select null)) as rn  from city_distance
)

select  a.distance, a.source, a.destination from cte a left join cte b 
on a.source=b.destination 
and a.destination=b.source where b.distance is null or a.distance !=b.distance or a.rn < b.rn ;



