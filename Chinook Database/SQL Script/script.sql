/*
The inquiries used below are examples of potential questions to consider when analyzing raw data. 
This example showcases my thought process when looking into data and performing SQL commands to retrieve the necessary information.

Skills used: Joins, Alias, Aggregate Functions
*/

-- 1. Show Customers (their full names, customer ID, and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country 
    FROM chinook.customers 
    WHERE Country <> "USA";

-- 2. Show only the Customers from Brazil.
SELECT * 
    FROM chinook.customers 
    WHERE Country = "Brazil" ;

-- 3. Find the Invoices of customers who are from Brazil. The resulting table should show the customer's full name, Invoice ID, Date of the invoice, and billing country.
SELECT cus.FirstName, cus.LastName, inv.InvoiceId, inv.BillingCountry, inv.InvoiceDate
    FROM chinook.invoices as inv 
    LEFT JOIN chinook.customers as cus 
    ON inv.CustomerId = cus.CustomerId 
    WHERE inv.BillingCountry = "Brazil";

-- 4. Show the Employees who are Sales Agents.
SELECT * FROM chinook.Employees
    WHERE Title = "Sales Support Agent";

-- 5. Find a unique list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry 
    FROM chinook.Invoices;

-- 6. Provide a query that shows the invoices associated with each sales agent.
SELECT emp.LastName, emp.Firstname, inv.InvoiceId
    FROM chinook.Employees emp 
    JOIN chinook.Customers AS cus ON cust.SupportRepId = emp.EmployeeId
    JOIN chinook.Invoices Inv ON Inv.CustomerId = cust.CusomerId;

-- 7. Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers. 
SELECT emp.LastName, emp.Firstname, cust.FirstName, cust.LastName, cust.Country, inv.total
    FROM chinook.employees AS emp 
    JOIN chinook.Customers AS cus 
    ON cus.SupportRepId = emp.EmployeeId
    JOIN chinook.Invoices AS inv 
    ON inv.CustomerId = cus.CustomerId;

-- 8. How many Invoices were there in 2009?
SELECT COUNT(*)
    FROM chinook.Invoices
    WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';

-- 9. What are the total sales for 2009? 
SELECT SUM(Total)
    FROM chinook.Invoices
    WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';

-- 10. Write a query that includes the purchased track name with each invoice line ID.
SELECT trk.Name, inv.InvoiceLineId
    FROM chinook.Invoice_items AS inv
    JOIN chinook.Tracks AS trk 
    ON inv.TrackId = trk.TrackId;

-- 11. Write a query that includes the purchased track name AND artist name with each invoice line ID. 
SELECT art.name AS Artist, trk.Name AS Track, inv.InvoiceLineId
    FROM chinook.Invoice_items AS inv
    LEFT JOIN chinook.tracks AS trk 
    ON inv.TrackID = trk.TrackID
    INNER JOIN chinook.albums AS alb
    ON alb.AlbumID = trk.AlbumID
    LEFT JOIN chinook.artists AS art
    ON art.ArtistID = alb.ArtistID;

-- 12. Provide a query that shows all the Tracks, and include the Album name, Media type, and Genre. 
SELECT trk.Name AS 'Track Name', alb.Title AS 'Album Title', med.Name AS 'Media Type', gen.Name AS 'Genre'
    FROM chinook.tracks AS trk
    JOIN chinook.Albums AS alb 
    ON alb.AlbumId = trk.AlbumId
    JOIN chinook.Media_Types AS med
    ON med.MediaTypeId = trk.MediaTypeId
    JOIN chinook.Genres AS gen
    ON gen.GenreId = trk.GenreId;

-- 13. Show the total sales made by each sales agent.
SELECT emp.FirstName, emp.LastName, ROUND(SUM(inv.Total), 2) AS 'Total Sales' 
    FROM chinook.Employees AS emp
    JOIN chinook.Customers AS cus 
    ON cus.SupportRepId = emp.EmployeeId
    JOIN chinook.Invoices AS inv 
    ON inv.CustomerId = cus.CustomerId
    WHERE emp.Title = 'Sales Support Agent' 
    GROUP BY emp.FirstName;

-- 14. Which sales agent made the most dollars in sales in 2009?
SELECT emp.FirstName, emp.LastName, ROUND(SUM(inv.Total), 2) as 'Total Sales' 
    FROM chinook.Employees emp
    JOIN chinook.Customers cus 
    ON cus.SupportRepId = emp.EmployeeId
    JOIN chinook.Invoices AS inv 
    ON inv.CustomerId = cus.CustomerId
    WHERE emp.Title = 'Sales Support Agent' 
    AND inv.InvoiceDate LIKE '2009%' 
    GROUP BY emp.FirstName
    ORDER BY (round(sum(inv.Total), 2))  DESC LIMIT 1;