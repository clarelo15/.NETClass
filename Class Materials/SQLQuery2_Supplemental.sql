-- Window Function: operate on a set of rows and return a single aggregated value for each row by adding extra column
-- RANK(): give us the rank based on certain values -- there will be a value gap when there is a tie
	-- rank for product price
	SELECT ProductID, ProductName, UnitPrice,
       RANK() OVER (ORDER BY UnitPrice DESC) AS RNK
FROM Products;


	-- product with the 2nd highest price
	select * from(
	SELECT ProductID, ProductName, UnitPrice,
       RANK() OVER (ORDER BY UnitPrice DESC) AS RNK
FROM Products ) tmp
where tmp.rnk= 2

	-- DENSE_RANK():
	SELECT ProductID, ProductName, UnitPrice,
       RANK() OVER (ORDER BY UnitPrice DESC) AS RNK,
       DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS Dense_RNK
FROM Products;



	-- ROW_NUMBER(): 
	SELECT ProductID, ProductName, UnitPrice,
       RANK() OVER (ORDER BY UnitPrice DESC) AS RNK,
       DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS Dense_RNK,
       ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS RowNum
FROM Products;


-- partition by: used to divide the result set into partitions and perform computation on each subset of partitioned data

	--1. list number of orders per customer and country;
		select c.ContactName, c.Country,
		count(o.OrderID) AS NumOfOrders
		from Orders o
		inner join Customers c
		on o.CustomerID = c.CustomerID
		group by c.ContactName, c.Country



	--2. use partition to group customers for each country together with ranking ;
		select c.ContactName,c.Country, COUNT(o.OrderID) as [cnt], rank() over (partition by c.country order by count(o.OrderID)) as [rank]
		FROM Customers c
		JOIN Orders o ON c.CustomerID = o.CustomerID
		GROUP BY c.ContactName, c.Country;



	-- use rank to find top 3 customers from every country with the most orders
	select * from (
	select c.ContactName,c.Country, COUNT(o.OrderID) as [cnt], rank() over (partition by c.country order by count(o.OrderID) desc) as [rank]
		FROM Customers c
		JOIN Orders o ON c.CustomerID = o.CustomerID
		GROUP BY c.ContactName, c.Country) as tmp
		where tmp.[rank] <= 3



--CTE
--all customers and total num of orders each customer makes
with cte as (
	 SELECT CustomerID, COUNT(OrderID) AS TotalCount
		FROM Orders
	GROUP BY CustomerID
)
select * from Customers  c inner join cte  on c.CustomerID = cte.CustomerID

select * from Customers  c 
inner join  (
	 SELECT CustomerID, COUNT(OrderID) AS TotalCount
		FROM Orders
	GROUP BY CustomerID
) tmp
on c.CustomerID = tmp.CustomerID


--Recursive CTE
-- get employee levels
-- level 1: Andrew
-- level 2: Nancy, Janet, Margaret, Steven, Laura
-- level 3: Michael, Robert, Anne

With empHierarchyCTE AS (
	 SELECT EmployeeID, FirstName, ReportsTo, 1 AS lvl
		FROM Employees
		where ReportsTo is null
	
	 union ALL
	 SELECT e.EmployeeID, e.FirstName, e.ReportsTo, cte.lvl + 1
	 FROM Employees e
	 JOIN empHierarchyCTE cte 
     ON e.ReportsTo = cte.EmployeeID

)
select * from empHierarchyCTE 


-- temporary table: special type of table so that we can store data temporarily
	-- # -> local temp table: only be accessed in the session that it's created
		--CREATE TABLE #LocalTemp (
		--	Number INT
		--);
		--DECLARE @Variable INT = 1;
		--WHILE (@Variable <= 10)
		--BEGIN
		--	INSERT INTO #LocalTemp(Number) VALUES(@Variable);
		--	SET @Variable = @Variable + 1;
		--END;

		--select * from #LocalTemp 
		--> Global Temp Table
		CREATE TABLE ##LocalTemp (
			Number INT
		);
		DECLARE @Variable INT = 1;
		WHILE (@Variable <= 10)
		BEGIN
			INSERT INTO ##LocalTemp(Number) VALUES(@Variable);
			SET @Variable = @Variable + 1;
		END;
		select * from ##LocalTemp 
-- temp table vs. table variables
-- 1. temp tables and table variables are stored in tempDB
-- 2. scope: local/global; current batch
-- 3. size: >100 rows; <100 rows
-- 4. structure: can create index/constraints except foreign key; cannot; constaints are: Foreign keys, Default constraints

DECLARE @today DATETIME
SET @today = GETDATE()
PRINT @today

DECLARE @WeekDays TABLE (
    DayNum INT,
    DayAbb VARCHAR(10),
    WeekName VARCHAR(10)
);

INSERT INTO @WeekDays
VALUES
(1, 'Mon', 'Monday'),
(2, 'Tue', 'Tuesday'),
(3, 'Wed', 'Wednesday'),
(4, 'Thu', 'Thursday'),
(5, 'Fri', 'Friday'),
(6, 'Sat', 'Saturday'),
(7, 'Sun', 'Sunday');

SELECT * FROM @WeekDays;


-- view: virtual table that contains the data from one or multiple tables





-- Pagination: divide a large data into smaller discrete pages --avoid consume all bandwith, loading all data, improve user experience 
-- OFFSET: skip
-- FETCH next N rows only: how many rows will be displayed; must be used with OFFSET


--static pagination
SELECT CustomerID, ContactName, City
FROM Customers
order by CustomerID
OFFSET 20 ROWS
FETCH next 10 rows only

--dynamic pagination
DECLARE @PageNumber AS INT = 1
DECLARE @RowsOfPage AS INT = 10
DECLARE @MaxTablePage AS FLOAT  --101

SELECT @MaxTablePage = COUNT(*) FROM Customers
SELECT @MaxTablePage =  Ceiling(@MaxTablePage / @RowsOfPage)   --Ceiling(10.1)  Ceiling(10)


WHILE @MaxTablePage >= @PageNumber
BEGIN
	   SELECT CustomerID, ContactName, City
		FROM Customers
		ORDER BY CustomerID
		OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
		FETCH next  @RowsOfPage rows only

		set @PageNumber =  @PageNumber + 1
END
