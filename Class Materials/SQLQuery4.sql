--Trasaction Template

BEGIN TRY
    BEGIN TRANSACTION;

    -- 一组 SQL 语句
    SELECT 1;

    -- 如果一切正常
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- 如果出错
    ROLLBACK TRANSACTION;

    -- 可以打印错误信息
    PRINT ERROR_MESSAGE();
END CATCH

--

--setup
--初始化数据
drop table if exists Product
CREATE TABLE Product (
    ID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Quantity INT
);

-- 插入初始化数据
INSERT INTO Product (ID, ProductName, UnitPrice, Quantity)
VALUES 
(1, 'Green Tea', 2.00, 100),
(2, 'Latte', 3.00, 100),
(3, 'Cold Brew', 4.00, 100);

SELECT * 
FROM Product
--setup end



--TRAN ROLLBACK INSERT
--table 1 
SELECT * 
FROM Product

BEGIN TRAN
INSERT INTO Product VALUES (4, 'Flat White', 4, 100)
ROLLBACK --COMMIT  

SELECT * 
FROM Product
--TRAN ROLLBACK INSERT end


--TRAN COMMIT INSERT
--table 1
SELECT * 
FROM Product

BEGIN TRAN
INSERT INTO Product VALUES (4, 'Flat White', 4, 100)
COMMIT  

SELECT * 
FROM Product

--TRAN COMMIT INSERT end



--Transaction Level Demo
---初始化 Product 表 [0]
drop table if exists Product
CREATE TABLE Product (
    ID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Quantity INT
);

-- 插入初始化数据
INSERT INTO Product (ID, ProductName, UnitPrice, Quantity)
VALUES 
(1, 'Green Tea', 2.00, 100),
(2, 'Latte', 3.00, 100),
(3, 'Cold Brew', 4.00, 100);

SELECT * 
FROM Product
---初始化 Product 表 [0] end





--READ UNCOMMITTED : Dirty Read [1]
--Insert rows but do NOT commit yet
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN
INSERT INTO PRODUCT VALUES(5, 'CHAI', 5, 100)
INSERT INTO PRODUCT VALUES(6, 'Nitro Cold Brew', 6, 100)
INSERT INTO PRODUCT VALUES(7, 'Iced Latte', 4, 100)

--READ UNCOMMITTED : Dirty Read [3]
--Rollback the uncommitted changes
ROLLBACK
SELECT * 
FROM Product







--READ COMMITTED [4]
--Insert rows but do NOT commit yet
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
INSERT INTO PRODUCT VALUES(5, 'CHAI', 5, 100)
INSERT INTO PRODUCT VALUES(6, 'Nitro Cold Brew', 6, 100)
INSERT INTO PRODUCT VALUES(7, 'Iced Latte', 4, 100)

--READ COMMITTED [6]
--Rollback the uncommitted changes
ROLLBACK
select *
from Product



--Setup
SELECT * FROM Product



--READ COMMITTED: Lost Update[7]
--update Product Quantity to 100 - 1 = 99 in 10 seconds
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
DECLARE @qty int
SELECT @qty = Quantity FROM Product WHERE ID = 1

SET @qty = @qty - 1
WAITFOR DELAY '00:00:10'
UPDATE PRODUCT SET Quantity = @qty WHERE ID = 1
Commit

SELECT * 
FROM Product






--初始化数据 [8]
drop table if exists Product
CREATE TABLE Product (
    ID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Quantity INT
);

-- 插入初始化数据
INSERT INTO Product (ID, ProductName, UnitPrice, Quantity)
VALUES 
(1, 'Green Tea', 2.00, 100),
(2, 'Latte', 3.00, 100),
(3, 'Cold Brew', 4.00, 100);





--REPEATABLE READ [9]
--The data you read cant be updated by other session
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
DECLARE @qty1 int
SELECT @qty1 = Quantity FROM Product WHERE ID = 2

SET @qty1 = @qty1 - 1
WAITFOR DELAY '00:00:10'
UPDATE PRODUCT SET Quantity = @qty1 WHERE ID = 2
COMMIT



----REPEATABLE READ [10]
select * FROM Product WHERE ID = 2









--重置latte数量至100 [11]
UPDATE PRODUCT SET Quantity = 100 WHERE ID = 2



--2.READ COMMITTED issue: Non-Repeatable Read [12]
--UPDATE PRODUCT SET Quantity = 10 WHERE ID = 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
SELECT Quantity FROM Product WHERE ID = 2
WAITFOR DELAY '00:00:10'
SELECT Quantity FROM Product WHERE ID = 2
COMMIT







--重置latte数量至100 [13]
UPDATE PRODUCT SET Quantity = 10 WHERE ID = 2



--REPEATABLE READ [14]
--trasaction 2 happens after transaction1 is done
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT Quantity FROM Product WHERE ID = 2
WAITFOR DELAY '00:00:10'
SELECT Quantity FROM Product WHERE ID = 2
COMMIT












--REPEATABLE READ issue: phantom read [16]
--It places shared locks on existing rows you read, but it doesn’t lock the whole range of data
--t1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT * FROM Product
WAITFOR DELAY '00:00:10'
SELECT * FROM Product
COMMIT





--SERIALIZABLE [17]
--t1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
SELECT * FROM Product
WAITFOR DELAY '00:00:10'
SELECT * FROM Product
COMMIT


