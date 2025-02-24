The question is you have a table named A where the input is

1
2
3
4
5
Now, you need to get the output in the following format
1
2
2
3
3
3
4
4
4
4
5
5
5
5
5

Note: Do not use recursive cte
Schema and DataSet:
  
create table numbers (n int);
insert into numbers values (1),(2),(3),(4),(5);

# recursive cte approach

with  recursive cte as(
select n , n  as counter from numbers 
union all
select n,counter-1  from cte where counter > 1
)
select n from cte order by n;

# cross join approach

select n1.n from numbers n1 cross join numbers n2 on n1.n>=n2.n order by n1.n




