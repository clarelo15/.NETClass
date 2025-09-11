--1.How many products can you find in the Production.Product table?
SELECT COUNT(*) AS Count FROM Production.Product;

--2.Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
--The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(*) AS Count FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

--3.Count how many products belong to each product subcategory.
	--Write a query that displays the result with two columns:
	--ProductSubcategoryID (the subcategory ID)， CountedProducts (the number of products in that subcategory).
SELECT ProductSubcategoryID, COUNT(*) AS Count FROM Production.Product
GROUP BY ProductSubcategoryID;

--4.How many products that do not have a product subcategory.
SELECT COUNT(*) AS Count FROM Production.Product
WHERE ProductSubcategoryID IS NULL;


--5.Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity) AS Total FROM Production.ProductInventory;


--6.Write a query to list the sum of products in the Production.ProductInventory table 
--and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
SELECT ProductID, SUM(Quantity) AS Total FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

--7. Write a query to list the sum of products with the shelf information in the Production.ProductInventory 
--table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
SELECT ProductID, Shelf, SUM(Quantity) AS Total FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) < 100;

--8.Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT AVG(Quantity) AS Average FROM Production.ProductInventory
WHERE LocationID = 10;

--9.Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
SELECT Shelf, AVG(Quantity) AS Average FROM Production.ProductInventory
GROUP BY Shelf
ORDER BY Shelf;

--10.Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
SELECT Shelf, AVG(Quantity) AS Average FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf
ORDER BY Shelf;

--11.List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. 
--Exclude the rows where Color or Class are null.
SELECT Color, Class, AVG(ListPrice) AS Average FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

--12.Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. 
--Join them and produce a result set similar to the following
SELECT c.Name AS Country, s.Name AS Province FROM Person.CountryRegion c
INNER Join Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode;

--13.Write a query that lists the country and province names from person. CountryRegion and person. 
--StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
SELECT c.Name AS Country, s.Name AS Province FROM Person.CountryRegion c
INNER Join Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada')
ORDER BY c.Name, s.Name;

-- Using Northwnd Database: (Use aliases for all the Joins)
--14.List all Products that has been sold at least once in last 25 years.
SELECT p.ProductName, o.OrderDate FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, GETDATE());

--15.List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) AS TotalSold FROM Orders o
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC;

--16.List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) AS TotalSold FROM Orders o
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
WHERE o.ShipPostalCode IS NOT NULL AND o.OrderDate >= DATEADD(YEAR, -25, GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC;

--17.List all city names and number of customers in that city.    
SELECT City, COUNT(*) AS NumberOfCustomers FROM Customers
GROUP BY City;

--18.List city names which have more than 2 customers, and number of customers in that city
SELECT City, COUNT(*) AS NumberOfCustomers FROM Customers
GROUP BY City
HAVING COUNT(*) > 2;

--19.List the names of customers who placed orders after 1/1/98 with order date.
SELECT c.CompanyName, MIN(o.OrderDate) AS[First Order Date after 1/1/98] FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01 00:00:00.000'
GROUP BY c.CompanyName;

--20.List the names of all customers with most recent order dates
SELECT c.CompanyName, MAX(o.OrderDate) AS[Most Recent Order Date] FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName;

--21.Display the names of all customers  along with the  count of products they bought
SELECT c.CompanyName, SUM(od.Quantity) AS Count FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
GROUP BY c.CompanyName;

--22.Display the customer ids who bought more than 100 Products with count of products.
SELECT c.CustomerID, SUM(od.Quantity) AS Count FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100;

--23.Show all the possible combinations of suppliers and shippers, representing every way a supplier can ship its products.
	--The result should display two columns:
	--Supplier CompanyName， Shipper CompanyName
SELECT su.CompanyName AS [Supplier CompanyName], sh.CompanyName AS [Shipper CompanyName]  
FROM Suppliers su
CROSS JOIN Shippers sh

--24.Display the products order each day. Show Order date and Product Name.
SELECT p.ProductName, o.OrderDate FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID;

--25.Displays pairs of employees who have the same job title.
SELECT e1.FirstName + ' ' + e1.LastName AS Employee1, e2.FirstName + ' ' + e2.LastName AS Employee2, e1.Title FROM Employees e1
INNER JOIN Employees e2
ON e1.Title = e2.Title
AND e1.EmployeeID < e2.EmployeeID;

--26.Display all the Managers who have more than 2 employees reporting to them.
SELECT m.FirstName + ' ' + m.LastName AS Manager, COUNT(e.EmployeeID) AS Count FROM Employees m
INNER JOIN Employees e
ON m.EmployeeID = e.ReportsTo
GROUP BY m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 2;

--27.List all customers and suppliers together, grouped by city.
--The result should display the following columns:
--City，CompanyName，ContactName，Type (indicating whether the record is a Customer or a Supplier).
SELECT City, CompanyName, ContactName, 'Customer' AS Type FROM Customers
UNION
SELECT City, CompanyName, ContactName, 'Supplier' AS Type FROM Suppliers
ORDER BY City, CompanyName;