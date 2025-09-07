--SELECT All Rows

select top 1 * from dbo.Employees


--Selecting Specific Columns

select EmployeeID, LastName, FirstName  from dbo.Employees


--Schema and Full Table Name

--Database Owner
--HR.Employees;   Sales.Employees

select * from dbo.Employees
select * from Employees



--select distinct value
select *  from dbo.Employees
select distinct City from dbo.Employees

select distinct Country from dbo.Employees

select * from dbo.Employees

select distinct postalcode, country from dbo.Employees


--Column Aliases
select distinct PostalCode + ' ' + Country FROM Employees

select distinct PostalCode + ' ' + Country as 'Postal code and Country' FROM Employees


--Identifiers in SQL
--identifiers: name we give to db, tables, columns, views
--表名（Table Name）


--列名（Column Name）


--变量（Variable）


--临时表（Temporary Table）


--约束 / 别名（Constraint, Alias）

--[] ""

--(a–z / A–Z)、@ 或#
declare @today datetime
select @today = getdate()
print @today


declare @tod$#ay datetime
select @tod$#ay = getdate()
print @tod$#ay


select [sum], "max" from [table]


select FirstName as [First Name] from dbo.Employees
[] ""






--filter rows in where clause

select * from  dbo.Employees where EmployeeID > 3

select * from  dbo.Employees where BirthDate > '1948-12-08'
select * from  dbo.Employees where BirthDate > 1948-12-08

select * from  dbo.Employees where country <> 'USA'
select * from  dbo.Employees where country !=  'USA'

select * from  dbo.Employees where country =  'USA'

--between operator: retrieve in a consecutive range; inclusive! [x,y]
--<=, >=

select * from Products where UnitPrice between 20 and 30
select * from Products where  UnitPrice >= 20 AND UnitPrice <= 30








--IN / NOT IN

select * from  dbo.Employees

select * from  dbo.Employees where country not in ('usa', 'uk')
select * from  dbo.Employees where country in ('usa', 'uk')



--NULL Handling
--NULL
0 ''

select * from  dbo.Employees

select * from  dbo.Employees where region is null
select * from  dbo.Employees where region is not null
select * from  dbo.Employees where region > null


--Like operator: create a search expression

select * from  dbo.Employees where LastName like 'D%'
select * from  dbo.Employees where LastName like  '%g%'
select * from  dbo.Employees where PostalCode like '__[0-3]%'
select * from  dbo.Employees where PostalCode like '[a-z]%'
--% → 匹配0 或多个字符
--_ → 匹配恰好一个字符
--[ ] → 匹配范围（如 [a-z]，[0-9]）
--order by statement: sort the result set in ascending or descending order

select * from Orders order by OrderDate asc

select * from Orders order by RequiredDate asc

select * from Orders order by RequiredDate



--TOP
select top 1 * from Employees

select  top 1 * from Employees order by hiredate asc


select  top 1 * from Employees order by hiredate desc




Microsoft SQL Server Management Studio 21


Visual Studio


Visual Studio Code


Northwind SQL


