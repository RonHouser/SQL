/*
The following commands were in accordance with completeing the "Break Into Tech" Certification Course.
I was asked to query a database containing multiple tables including customer information and sales per month.
The questions were provided and I was tested on my ability to correctly use SQL to present a solution.

Skills used: Subquery, Joins, Aggregate Functions, Group By, Order By, Having, Like, IN, Case.
*/


--1. Which product was the cheapest one sold in January, and what was the price?
SELECT DISTINCT price, product
    FROM BIT_DB.JanSales
    WHERE price IN (SELECT MIN(price)
    FROM BIT_DB.JanSales);

--2. Select the customer account numbers for all the orders that were placed in February.
SELECT acctnum
    FROM BIT_DB.customers
    RIGHT JOIN BIT_DB.FebSales
    ON customers.order_id = FebSales.orderID;

--3. What is the total revenue for each product sold in January?
SELECT product, ROUND(sum(quantity)*price, 2) as revenue
    FROM BIT_DB.JanSales
    GROUP BY product
    ORDER BY Revenue asc;

--4. Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue?
SELECT product, quantity, sum(quantity) * price as revenue
    FROM BIT_DB.FebSales
    Where location = "548 Lincoln St, Seattle, WA 98101"
    GROUP BY product;

--5. How many customers ordered more than 2 products at a time in February, and what was the average amount spent for those customers?
SELECT count(c.acctnum), ROUND(avg(quantity)*price, 2)
    FROM BIT_DB.FebSales AS f
    LEFT JOIN BIT_DB.customers AS c
    ON C.order_id = F.orderID
    WHERE F.quantity > 2;

--6. List all the products sold in Los Angeles in February, and include how many of each were sold.
SELECT product, SUM(quantity)
    FROM BIT_DB.FebSales
    WHERE location like "%Los Angeles%"
    GROUP BY product;

--7. Which locations in New York received at least 3 orders in January, and how many orders did they each receive?
SELECT location, COUNT(orderID) as c_o
    FROM BIT_DB.JanSales
    WHERE location like '%NY%'
    GROUP BY location
    Having c_o > 2
    Order by orderdate desc;
    
--8. How many of each type of headphone were sold in February?
SELECT DISTINCT product, sum(quantity)
    FROM BIT_DB.FebSales
    WHERE product LIKE '%head%'
    GROUP BY product;
    
--9. What was the average amount spent per account in February?
SELECT acctnum, avg(price * quantity)
    FROM BIT_DB.FebSales AS feb
    LEFT JOIN BIT_DB.customers AS cus
    ON feb.orderID = cus.order_id
    GROUP BY acctnum;
    
--10. What was the average quantity of products purchased per account in February?
select sum(quantity)/count(cus.acctnum)
    FROM BIT_DB.FebSales Feb
    LEFT JOIN BIT_DB.customers cus
    ON FEB.orderid=cus.order_id;
    
--11. Which product brought in the most revenue in January and how much revenue did it bring in total?
SELECT product, SUM(price*quantity) as revenue
    FROM BIT_DB.JanSales
    GROUP BY product
    ORDER BY revenue desc
    LIMIT 5;
