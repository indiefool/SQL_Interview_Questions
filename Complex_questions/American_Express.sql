You are given two tables- friends and likes. You need to give page recommendations to social media users based on pages that have been
liked by their friends but are not yet liked by them.

Task: Determine the user IDs and the corresponding page IDs of the pages that have been liked by their friends already, but have not been
liked by them. Arrange the final result in the increasing order of the user ID.

Note: All the pages that are liked by user's friend's are generally recommended to the user based on the social media algorithm

Schema and DataSet:

CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

-- Insert data into friends table
INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

-- Insert data into likes table
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');


Solution:


with user_likes as
(
select  distinct a.user_id,group_concat(distinct b.page_id) as user_liked_pages from friends a join likes b on a.user_id=b.user_id group by a.user_id
),
user_friend_likes as
(
select  distinct  a.user_id ,b.page_id from friends a join likes b on a.friend_id=b.user_id 
)

select a.user_id,a.page_id  from user_friend_likes a left join user_likes b on a.user_id=b.user_id 

and FIND_IN_SET(a.page_id, b.user_liked_pages) = 0 where b.user_liked_pages is  not null;

Output :

user_id    page_id
2	        C
2	        B
3	        A
4	        C
4	        A
