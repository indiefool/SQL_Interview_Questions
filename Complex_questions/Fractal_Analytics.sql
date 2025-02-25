Given a database about battles from the popular TV show "Game of Thrones":
The database contains two tables: battle and king.
For each region, find the house that has won the maximum number of battles. Display the region, house, and number of wins.

-- Create the 'king' table
CREATE TABLE king (
 k_no INT PRIMARY KEY,
 king VARCHAR(50),
 house VARCHAR(50)
);

-- Create the 'battle' table
CREATE TABLE battle (
 battle_number INT PRIMARY KEY,
 name VARCHAR(100),
 attacker_king INT,
 defender_king INT,
 attacker_outcome INT,
 region VARCHAR(50),
 FOREIGN KEY (attacker_king) REFERENCES king(k_no),
 FOREIGN KEY (defender_king) REFERENCES king(k_no)
);

delete from king;
INSERT INTO king (k_no, king, house) VALUES
(1, 'Robb Stark', 'House Stark'),
(2, 'Joffrey Baratheon', 'House Lannister'),
(3, 'Stannis Baratheon', 'House Baratheon'),
(4, 'Balon Greyjoy', 'House Greyjoy'),
(5, 'Mace Tyrell', 'House Tyrell'),
(6, 'Doran Martell', 'House Martell');

delete from battle;
-- Insert data into the 'battle' table
INSERT INTO battle (battle_number, name, attacker_king, defender_king, attacker_outcome, region) VALUES
(1, 'Battle of Oxcross', 1, 2, 1, 'The North'),
(2, 'Battle of Blackwater', 3, 4, 0, 'The North'),
(3, 'Battle of the Fords', 1, 5, 1, 'The Reach'),
(4, 'Battle of the Green Fork', 2, 6, 0, 'The Reach'),
(5, 'Battle of the Ruby Ford', 1, 3, 1, 'The Riverlands'),
(6, 'Battle of the Golden Tooth', 2, 1, 0, 'The North'),
(7, 'Battle of Riverrun', 3, 4, 1, 'The Riverlands'),
(8, 'Battle of Riverrun', 1, 3, 0, 'The Riverlands');

--------------------------------------------------------------------------------------------------
Solution 1:
--------------------------------------------------------------------------------------------------
with cte as(
select attacker_king as king, region  from battle where attacker_outcome=1
union all
select defender_king as king, region  from battle where attacker_outcome=0
),

cte1 as
(
select a.region,b.house,count(*) as cnt,dense_rank() over(partition by a.region order by count(*) desc) as rn
 from cte a  inner join king b on a.king=b.k_no group by a.region,b.house
)

select region,house,cnt from cte1 where rn=1;

--------------------------------------------------------------------------------------------------
Solution 2:
--------------------------------------------------------------------------------------------------

with cte as(
select b.region,k.house from battle b inner join king k on k.k_no=case when b.attacker_outcome=1 then b.attacker_king else b.defender_king end
),
cte1 as(
select region,house ,count(*) as cnt, dense_rank() over(partition by region order by count(*) desc) as rn from cte
 group by region,house)
 
 select region,house,cnt from cte1 where rn=1;
