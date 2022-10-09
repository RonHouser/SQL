--create a store database

create table store (id integer primary key, name text, price integer, aisle integer, discount integer);

insert into store values 
(1, "monkeys", 100, 2, 10),
(2, "cows", 500, 1, 0),
(3, "cats", 30, 14, 15),
(4, "dogs", 25, 4, 20),
(5, "mice", 1, 13, 75),
(6, "gerbals", 10, 13, 0),
(7, "birds", 5, 15, 10),
(8, "rabbits", 40, 12, 05),
(9, "fish", 05, 09, 05),
(10, "tigers", 5000, 14, 50),
(11, "zebras", 3500, 07, 35),
(12, "horses", 1500, 07, 0),
(13, "skunks", 60, 04, 90),
(14, "badgers", 55, 08, 10),
(15, "elephants", 7500, 20, 20);

--display the database ordered by price in descending order
select * from store order by price desc;

--How much would it cost to buy everything in the store?
select sum(price) from store;

--What is the average discount that the store is offering on aisle 14?
select avg(discount) from store where aisle = 14;
