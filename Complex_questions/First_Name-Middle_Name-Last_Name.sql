Find out First Name , Middle Name and Last Name of a Customer.

Schema and DataSet:
 
CREATE TABLE customers (
 customer_name VARCHAR(30)
);

INSERT INTO customers VALUES 
('Ankit Bansal'),
('Vishal Pratap Singh'),
('Michael'); 

-----------------------------------------------------------------------
Solution:
-----------------------------------------------------------------------
with cte as(
select *, LOCATE(' ',customer_name) as first_position ,LOCATE(' ',customer_name,LOCATE(' ',customer_name)+1) as second_position
from customers)
 
select *,case when first_position=0 then customer_name else  substring(customer_name,1,first_position-1) end  as first_name,
case when first_position=0 or second_position =0 then 'null' when second_position!=0 then
substring(customer_name,first_position+1,((second_position-1)-first_position)) end as middle_name,
case when first_position=0 then 'null' when second_position=0  then 
substring(customer_name,first_position+1) when second_position!=0 then 
substring(customer_name,second_position+1) end  as last_name
from cte;
