--SELECT * FROM Sales.Customers
--SELECT * FROM Sales.Orders
/*
CREATE PROCEDURE usacustomers2 AS
BEGIN
SELECT C.CustomerID id, ISNULL(C.FirstName,'')+' '+ISNULL(C.LastName,'') customername, 
o.OrderDate orderdate, o.ProductID item 
FROM Sales.Customers C
JOIN Sales.Orders O ON C.CustomerID = O.CustomerID AND C.Country = 'USA'
OPTION (HASH JOIN)
END
*/

--EXEC usacustomers2;

--DROP PROCEDURE usacustomers2

/*
CREATE PROCEDURE salesbycountry @country NVARCHAR(50) AS
BEGIN
SELECT C.CustomerID id, ISNULL(C.FirstName,'') +' '+ ISNULL(C.LastName,'') customername, C.Country country,
O.OrderDate odate, O.OrderStatus ostatus
FROM Sales.Customers C
JOIN Sales.Orders O ON C.CustomerID = O.CustomerID AND C.Country = @country
END
*/

/*
ALTER PROCEDURE salesbycountry @country NVARCHAR(50) AS
BEGIN
SELECT C.CustomerID id, ISNULL(C.FirstName,'') +' '+ ISNULL(C.LastName,'') customername, C.Country country,
O.OrderDate odate, O.OrderStatus ostatus
FROM Sales.Customers C
JOIN Sales.Orders O ON C.CustomerID = O.CustomerID AND C.Country = @country
ORDER BY C.CustomerID
END
*/

EXEC salesbycountry @country = 'Germany';