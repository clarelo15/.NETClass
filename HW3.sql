--1.List all cities that have both Employees and Customers.
SELECT DISTINCT e.City FROM Employees e
INNER JOIN Customers c ON e.City = c.City;

--2List all cities that have Customers but no Employee.
--a.      Use sub-query
SELECT DISTINCT City FROM Customers
WHERE City NOT IN (SELECT DISTINCT City FROM Employees);

--b.      Do not use sub-query
SELECT DISTINCT c.City FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL;

--3.  List all products and their total order quantities throughout all orders.
SELECT p.ProductName, SUM(od.Quantity) AS Total FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--4.  List all Customer Cities and total products ordered by that city.
SELECT c.City, SUM(od.Quantity) AS Total FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

--5. List all Customer Cities that have at least two customers.
--a.      Use union
SELECT City, COUNT(*) AS Count FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2
UNION
SELECT City, COUNT(*) AS Count FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2;

--b.      Use sub-query and no union
SELECT DISTINCT City, COUNT(*) AS Count FROM Customers
WHERE City IN (
    SELECT City FROM Customers
    GROUP BY City
    HAVING COUNT(*) >= 2
)
GROUP BY City;

--6.List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, COUNT(DISTINCT od.ProductID) AS Count FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

--7. List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT DISTINCT c.CompanyName, c.City, o.ShipCity FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity;

--8. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
WITH ProductCTE AS (
    SELECT ProductID, SUM(Quantity) AS Total FROM [Order Details]
    GROUP BY ProductID
),
TopProducts AS (
    SELECT TOP 5 pc.ProductID, pc.Total FROM ProductCTE pc
    ORDER BY pc.Total DESC
),
ProductCityCount AS (
    SELECT od.ProductID, c.City, SUM(od.Quantity) AS TotalCount, AVG(od.UnitPrice) AS AvgeragePrice FROM [Order Details] od
    INNER JOIN Orders o ON od.OrderID = o.OrderID
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY od.ProductID, c.City
)
SELECT p.ProductName, pcc.AvgeragePrice, pcc.City AS City, pcc.TotalCount FROM TopProducts tp
INNER JOIN Products p ON tp.ProductID = p.ProductID
INNER JOIN ProductCityCount pcc ON tp.ProductID = pcc.ProductID
WHERE pcc.TotalCount = (SELECT MAX(pcc2.TotalCount) FROM ProductCityCount pcc2
    WHERE pcc.ProductID = pcc2.ProductID
)
ORDER BY tp.Total DESC;

--9.List all cities that have never ordered something but we have employees there.
--a.      Use sub-query
SELECT e.City FROM Employees e
WHERE e.City Not IN (SELECT c.City FROM Customers c
    WHERE c.CustomerID IN (SELECT CustomerID FROM Orders));

--b.      Do not use sub-query
SELECT e.City FROM Employees e
LEFT JOIN Customers c ON e.City = c.City
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--10.List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
SELECT EmployeeTopCity.City FROM (
    SELECT TOP 1 e.City, COUNT(*) AS OrderCount FROM Employees e
    INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
    ORDER BY COUNT(*) DESC
) AS EmployeeTopCity
INNER JOIN (
    SELECT TOP 1 c.City, SUM(od.Quantity) AS TotalQuantity FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.City
    ORDER BY SUM(od.Quantity) DESC
) AS CustomerTopCity
ON EmployeeTopCity.City = CustomerTopCity.City;

--11.How do you remove the duplicates record of a table?
--Use a Common Table Expression (CTE) with the ROW_NUMBER() window function.
--Use PARTITION BY to specify the columns that define a duplicate. Rows with the same values in these columns will be grouped together. 
--Use DELETE From the CTE, deleting the duplicate records where ROW_NUMBER() is greater than 1.
WITH CTE_Duplicates AS (
    SELECT Column1, Column2, Column3,
        ROW_NUMBER() OVER (PARTITION BY Column1, Column2 ORDER BY Column3) AS RowNum
    FROM
        TableName
)
DELETE FROM CTE_Duplicates
WHERE RowNum > 1;