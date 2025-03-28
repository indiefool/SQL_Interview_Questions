Find start and detination location of a customer

CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur'),
    ('c3', 'Jaipur', 'Kochi');

----------------------------------------------------------------------------
Solution 1:
----------------------------------------------------------------------------

with cte as
(
select customer, start_loc as loc,'start_loc' as column_name from travel_data 
union all
select customer,end_loc as loc,'end_loc' as column_name from travel_data
),
cte_2 as
(
select *,count(*) over(partition by customer,loc) as cnt from cte
)
select customer, max(case when column_name='start_loc'  then loc end )  as start_loc  ,
max(case when column_name='end_loc'  then loc end )  as dest_loc
from cte_2 where cnt=1  group by customer


----------------------------------------------------------------------------
Solution 2:
----------------------------------------------------------------------------

select td.customer, max(case when td1.end_loc is null then td.start_loc end ) as start_location,
max(case when td2.start_loc is null then td.end_loc end) as end_location
 from travel_data td left join travel_data td1 on td.customer =td1.customer and td.start_loc=td1.end_loc
 
 left join travel_data td2 on td.customer=td2.customer and td.end_loc=td2.start_loc group by td.customer

