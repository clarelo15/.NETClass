--section1
    --Anonymous block
begin
    print 'Hello anonymous block'
end


    --Stored Procedure
    --DROP PROCEDURE spHello;
CREATE PROC spHello
as
begin

    print 'Hello Stored Procedure'
end

EXECUTE spHello

--Section 2
--sql injection: some hackers inject some malicious code to our sql queries, thus destroy our db
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    Id INT,
    [Name] NVARCHAR(50),
    [Password] NVARCHAR(50)  
);

INSERT INTO Users (Id, [Name], [Password]) VALUES (1, 'Alice', '123456');
INSERT INTO Users (Id, [Name], [Password]) VALUES (2, 'Bob', 'abcdef');
INSERT INTO Users (Id, [Name], [Password]) VALUES (3, 'Charlie', 'pass123');
INSERT INTO Users (Id, [Name], [Password]) VALUES (4, 'Diana', 'qwerty');
INSERT INTO Users (Id, [Name], [Password]) VALUES (5, 'Tom', 'qwerty123');


SELECT * FROM Users;

select Id, [Name]
from users
where id = @id


select Id, [Name]
from users
where id = 5


select Id, [Name]
from users
where id = 1



--string sql = "SELECT Id, Name FROM Users WHERE Id = " + userInput;
--1 OR 1=1

select Id, [Name]
from users
where id = 1 or 1 = 1




--string sql = "SELECT Id, Name FROM Users WHERE Id = " + userInput;
--1 UNION SELECT Id, Password FROM Users

select Id, [Name]
from users
where id = 1 
UNION 
SELECT Id, [Password] 
FROM Users



--Section 3
--input
--DROP PROCEDURE spAddNumbers;
CREATE PROC spAddNumbers
 @a int,
 @b int
 as
begin
    print @a + @b
end

exec spAddNumbers 10, 20


--output
--DROP PROCEDURE spGetEmpName;

CREATE PROC spGetEmpName
@id int,
@name varchar(20) output
as
begin
    select @name = FirstName + ' ' + LastName
     from employees
     where EmployeeID = @id
end

 DECLARE @empName VARCHAR(20)
 EXEC spGetEmpName 2, @empName OUTPUT
  PRINT @empName 

--return
--DROP PROCEDURE spGetEmpCount
CREATE PROC spGetEmpCount
as
begin
 declare @rowcount INT
 select @rowcount = count(*)
 from Employees
 return @rowcount
end


declare @total int
EXEC @total = spGetEmpCount
PRINT @total


--return
--DROP PROCEDURE spGetAllEmp
CREATE PROC  spGetAllEmp
as
begin
    select  EmployeeId,Title,HomePhone
    from employees
end

EXEC spGetAllEmp
--Section 4
--Functions:
--Scalar-Valued Function
--Revenue = Unit Price × Quantity × (1 - Discount)

--DROP Function GetTotalRevenue

Create Function GetTotalRevenue (
    @price money,
    @discount real,
    @quantity smallint
)
returns money
as
begin
    declare @revenue money    --收入 = 单价 × 数量 × (1 - 折扣)
    set @revenue = @price * @quantity * (1- @discount)
    return @revenue
end


select UnitPrice, Discount, Quantity, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) as TotalRevenue
from [Order Details]


--Table-Valued Function
--drop Function ExpensiveProduct

Create Function ExpensiveProduct (@threshold money)
returns table
as
    return 
        select * from Products 
        where UnitPrice > @threshold


SELECT * FROM dbo.ExpensiveProduct(10);


 --SP vs. Function
-- Stored Procedure
--A reusable block of SQL code that may include queries, data changes, and transactions.
--Scalar Function
--Produces one single value (number, text, or date).
--Table-Valued Function (TVF)
--:Provides a virtual table you can query from.


--Section 5
--constraints

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee(
    Id INT,
    EName VARCHAR(20),
    Age INT
);

SELECT * FROM Employee;

INSERT INTO Employee VALUES (1, 'Sam', 45);

INSERT INTO Employee VALUES (NULL, NULL, NULL);

SELECT * FROM Employee;
--not null

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee(
    Id INT not null ,
    EName VARCHAR(20) not null,
    Age INT
);


INSERT INTO Employee VALUES (1, 'Sam', 45);

INSERT INTO Employee VALUES (NULL, NULL, NULL);

--unique
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee(
    Id INT unique,
    EName VARCHAR(20) not null,
    Age INT
);

INSERT INTO Employee VALUES (1, 'Sam', 30);
INSERT INTO Employee VALUES (1, 'Tom', 25);
INSERT INTO Employee VALUES (NULL, 'Lily', 28);


--pk
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
    Id INT primary key,
    EName VARCHAR(20) not null,
    Age INT
);

INSERT INTO Employee VALUES (1, 'Sam', 30);
INSERT INTO Employee VALUES (1, 'Tom', 25);
INSERT INTO Employee VALUES (NULL, 'Lily', 28);




--Referential Integrity (via Foreign Key)
--Insert restriction: A child table (e.g., Employee) can only reference keys that already exist in the parent table (e.g., Department).
--Delete restriction: A parent row (e.g., Department) cannot be deleted if it is still being referenced by the child table (e.g., Employee).
--Update restriction: If a parent key is modified, the child table must either update accordingly or block the change.

drop table if exists Department
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName NVARCHAR(50)
);


drop table if exists Employee
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName NVARCHAR(50),
    DeptID INT,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DeptID)
        REFERENCES Department(DeptID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
);

INSERT INTO Department VALUES (1, 'HR');
INSERT INTO Department VALUES (2, 'IT');
select * from Department


INSERT INTO Employee VALUES (100, 'Alice', 1);
--select * from Employee
INSERT INTO Employee VALUES (101, 'Bob', 3);




select  * from Employee 
select * from Department

update Department
set DeptID = 3
where deptid = 1

select  * from Employee 
