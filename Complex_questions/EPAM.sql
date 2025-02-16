On an online recruiting platform, each recruiting company can make a request for their candidates to complete a personalized skill assessment.
The assessment can contain tasks in 3 categories: SQL, Algo, Bug fixing. Following the assessment, the company receives a report containing for
for each candidate

Their declared years of experience (an integer between 0 to 100) and their score in each category. The score is the number of points from 0 to 100
or Null which means there was no task in this category.

You are given a table, assessments, with the following structure:

CREATE TABLE assessments (
id INTEGER NOT NULL,
experience INTEGER NOT NULL,
`sql` INTEGER,
algo INTEGER,
bug_fixing INTEGER,
UNIQUE(id)
);
insert into assessments values 
(1,3,100,null,50),
(2,5,null,100,100),
(3,1,100,100,100),
(4,5,100,50,null),
(5,5,100,100,100)

Your task is to write an SQL query that, for each different length of experience, counts the number of candidates with precisely that amount of experience
and how many of them got a perfect score in each category in which they were requested to solve tasks (so a NULL score is here treated as a perfect score).

Your query should return a table containing the following columns: exp (each candidate's years of experience), max (number of assessments achieving the 
maximum score), count (total number of assessments). Rows should be ordered by decreasing exp.

Solution:

select  experience, count(*) as total_assesments , sum(case when (`sql`=100 or `sql` is null) and (algo=100 or algo is null) 
and (bug_fixing =100 or bug_fixing is null) then 1 else 0 end) as perfect_score
 from assessments group by experience;

