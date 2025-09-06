--1 find employees who have dealt with any orders
--join would return matching records from both tables
select * from employees
select * from orders

 select e.EmployeeID, e.firstname + ' ' + e.lastname as EmployeeName, o.OrderDate 
 from employees e
 inner join orders o
 on e.employeeid = o.employeeid

--2 get customers information and corresponding order date
select * from Customers
select * from orders

select c.CompanyName, c.City, c.country, o.orderdate
from Customers c 
inner join orders o 
on c.CustomerID = o.CustomerID
order by c.CompanyName


--3 join multiple tables:
-- get customer name, the corresponding employee who is responsible for this order, and the order date

select c.CompanyName, e.firstname + ' ' + e.LastName as EmployeeName, o.OrderDate
from Customers c 
inner join orders o 
on c.CustomerID = o.CustomerID
inner join Employees e
on e.EmployeeID = o.EmployeeID

--OUTER JOIN
--4 LEFT OUTER JOIN: return all the records from the left table, and matched records from the right table, 
--    for the non-matching records in the right table, the result set will return null values
-- list all customers whether they have made any purchase or not

select c.ContactName, o.OrderID
from Customers c
left join orders o 
on c.CustomerID = o.CustomerID
order by o.OrderID 

--5 RIGHT OUTER JOIN: return all records from the right table, and matching records from the left table, 
--    if not matching, null values will be returned

select c.ContactName, o.OrderID
from orders o 
right join Customers c
on c.CustomerID = o.CustomerID
order by o.OrderID 




--6 FULL OUTER JOIN: return all rows from the left and right table, if the join condition is not met, it will return null
-- Match all customers and suppliers by country

select * from Customers c
select * from Suppliers s

select c.ContactName, c.Country AS CustomerCountry, s.Country as SupplierCountry, s.CompanyName
from Customers c
full join Suppliers s
on c.Country = s.Country

--7 CROSS JOIN: create the cartesian product of two tables
-- table 1: 10 rows, table 2: 20 rows --> cross join --> 200 rows

select * from Customers cross join orders


--8 SELF JOIN: join the table with itself, either inner join or outer join

select e.firstname + ' ' + e.LastName as Employee,
 m.firstname + ' ' + m.LastName as Manager
from employees e
inner join  employees m
on e.reportsto = m.employeeid




--9 SELF Left JOIN: join the table with itself to include Andrew
select e.firstname + ' ' + e.LastName as Employee,
 isnull(m.firstname + ' ' + m.LastName, 'N/A' )as Manager
from employees e
left  join  employees m
on e.reportsto = m.employeeid



-- Aggregation functions: perform a calculation on a set of values and returns a single value
--10  COUNT(): returns the number of rows


select count(OrderID) as TotalNumOfOrders
from orders

--COUNT(*)
--count(orderid)

--11 sum the cost on product up in order to calculate the total cost of each order
select orderid, sum(UnitPrice * Quantity)  as TotalCost

from  [order details]

group by OrderID



--12
 SELECT field1, aggregate(fields)
 FROM table 
 WHERE criteria -- optional
 GROUP BY fields
 HAVING criteria -- optional
 ORDER BY field -- optional

-- WHERE vs. HAVING
-- 1) both are used as filters; HAVING will apply only to groups as a whole, must use aggregate function in having clause
--    but WHERE applies to individual rows
-- 2) WHERE goes before aggregations, but HAVING filters after aggregations
-- FROM / JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY

--13 customer from "USA" with number of orders >= 10

select c.CustomerID, count(o.OrderID)
from customers c 
inner join orders o 
on c.CustomerID = o.CustomerID
where c.Country = 'USA'
group by c.CustomerID
having count(o.OrderID) >= 10


-- Subquery: is a SELECT statement that is embedded in a clause of another SQL statement

--14 find the customers from the same city where Alejandra Camino lives
select ContactName, City
from customers
where city in (
select city from Customers where ContactName = 'Alejandra Camino')

--15 adds a column TotalOrders to each customer in select query to show how many orders they placed.

select c.ContactName,
(	select count(*)
	from orders o
	where c.customerid = o.CustomerID
) as TotalOrders

from Customers c

--16 Sorts customers by how many orders they¡¯ve placed (most orders first).

select  ContactName, CustomerID
from Customers 
order by (
	select count(*)
	from orders o
	where o.customerID = Customers.customerID
)desc


--17 Returns customers who have placed more than average number of orders.


select customerID, count(*) as OrderCount
from orders 
group by CustomerID
having count(*) > (


	select avg(OrderCount) from (
		select count(*) as OrderCount from orders group by customerid ) as orderStats
)

--subquery vs. join; Subquery is easy to understand; Joins have better performance
--18 customers who never placed any order
	--1 join
	select c.CustomerID, c.ContactName, c.City, c.Country
	from customers c 
	left join orders  o
	on c.CustomerID = o.CustomerID
	where o.OrderID  is null 



	--2 subquery
	
	select c.CustomerID, c.ContactName, c.City, c.Country
	from customers c  
	where c.CustomerID not in (
		select distinct customerid 
		from orders 
	)




-- Union vs. Union ALL: is used to combine different result sets vertically by adding rows from multiple results sets together
-- common features
-- both are used to combine result sets vertically
--19 combine the city and country where the customers or employees reside in
	--UNION

	select city, country 
	from customers 
	union 
	select city, country 
	from Employees
	order by city

	--Union all
	select city, country 
	from customers 
	union all
	select city, country 
	from Employees
	order by city
	



--differences:
		-- UNION will remove duplicate records, UNION ALL will not


--20. criteria:
	--1 number of columns must be the same
	select city, country 
	from customers
	union all
	select city, country, region
	from employees

	--2 data type of coumns must be the same

	select city, country, contactname 
	from customers union all
	select city, country, employeeid
	from employees


	--3 column should make sense after being combined

	select city, country, contactname 
	from customers union all
	select city, country, region
	from employees


	--4 alias must be given in the first SELECT statement

	select city, country  as cty
	from customers union all
	select city, country
	from employees


















