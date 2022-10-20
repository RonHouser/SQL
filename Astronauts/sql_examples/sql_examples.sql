/*
Coming up with a few questions to demonstrate basic SQL techniques

Skills used: Aggregate Functions, Group By, Order By, Having, Case.
*/

-- What were all the missions and how many astronauts shared in those missons?*/
select missions, count(*) from astronauts 
where missions is not null 
group by missions 
order by missions asc; 

-- What were the top 5 missions that astronauts shared with one another?*/
select missions, count(*) from astronauts 
where missions is not null 
group by missions 
order by count(*) desc
limit 5;

-- What was the avg number of space flight hours for male astronauts vs. female astronauts?*/
Select gender, count(*), avg(space_flight_hr) from astronauts
group by gender;

-- Which male had the most hours in space, and which female had the most hours in space and what were their hours in space?*/
Select name, gender, max(space_flight_hr) from astronauts
group by gender
order by max(space_flight_hr) desc;

-- Who spent the least amount of time in space?*/
select name, min(space_flight_hr) from astronauts
where space_flight_hr > 0;

-- Can you tell me the experience level of the astronauts who flew on the Apollo missions?*/
Select name,
    Case
        when space_flights = 1 then "novice"
        when space_flights <= 3 then "moderate"
        Else "expert"
        end as "Experience"
from astronauts
where missions like "%apollo%"
order by experience desc;

-- What is the military ranks of those who went on more than one space walk?*/
Select name, space_walks, military_rank from astronauts
group by military_rank
having space_walks > 1
order by space_walks;
