Write a SQL query to find out supplier_id, product_id, and starting date of record_date for which stock quantity is less than 50 for two or more consecutive days.

You are given a inventory table as below:

-- Create the table
CREATE TABLE stock (
 supplier_id INT,
 product_id INT,
 stock_quantity INT,
 record_date DATE
);

-- Insert the data
INSERT INTO stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
 (1, 1, 60, '2022-01-01'),
 (1, 1, 40, '2022-01-02'),
 (1, 1, 35, '2022-01-03'),
 (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
 (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
 (1, 1, 38, '2022-01-16'),
 (1, 2, 45, '2022-01-08'),
 (1, 2, 40, '2022-01-09'),
 (2, 1, 45, '2022-01-06'),
 (2, 1, 55, '2022-01-07'),
 (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
 (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
 (2, 2, 23, '2022-01-16');

----------------------------------------------------------------------------------
Solution:
----------------------------------------------------------------------------------


with cte as(
select *,lag(record_date,1,record_date) over(partition by supplier_id,product_id order by record_date) 
as prev_date,datediff(record_date,lag(record_date,1,record_date) over(partition by supplier_id,product_id order by 
record_date) ) as diff from stock where stock_quantity < 50
),
cte1 as(
select *,case when diff<=1 then 0 else 1 end as group_flag,sum(case when diff<=1 then 0 else 1 end )
over(partition by supplier_id,product_id order by record_date) group_id  from cte
)
select supplier_id,product_id,min(record_date) as first_date
from cte1 group by supplier_id,product_id,group_id having count(*)>=2;

