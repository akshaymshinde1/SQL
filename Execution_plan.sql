--=================
--EXECUTION PLAN
--=================
--To check the execution plan
--there are three buttons on tool bar beside 'Execute" buttone. estimated plan, actual plan, live plan.
--if there is difference in actual vs estimated plan i.e. there is issue like inaccurate statatistics or outdated indexes leading to poor performance.
--INDEX SEEK: a targeted search within index retrieving only specific info. This the best scanning method
/*
SELECT * INTO FactResellerSales_HP FROM FactResellerSales;
*/
/*
--***********
--HAPE TABLE
--***********
--1.
SELECT * FROM FactResellerSales_HP
ORDER BY SalesOrderNumber;

--2.
SELECT * FROM FactResellerSales_HP
WHERE CarrierTrackingNumber = '4911-403C-98';

--3.
SELECT p.EnglishProductName AS ProductName, SUM(s.SalesAmount) AS totalsales
FROM FactResellerSales_HP s
JOIN DimProduct p ON s.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName


--CREATE CLUSTERED COLUMNSTORE INDEX idx_FactResallersalesHP ON FactResellerSales_HP
--for aggrigation use columnstore index

--**************
--INDEXED TABLE
--**************
--1.
SELECT * FROM FactResellerSales
ORDER BY SalesOrderNumber; --THIS TABLE HAS INDEX

--2.
SELECT * FROM FactResellerSales
WHERE CarrierTrackingNumber = '4911-403C-98';

--3.
SELECT p.EnglishProductName AS ProductName, SUM(s.SalesAmount) AS totalsales
FROM FactResellerSales s
JOIN DimProduct p ON s.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName

--CREATE NONCLUSTERED INDEX idx_FactResaller_CTA ON FactResellerSales (CarrierTrackingNumber)
--in this execution plan ther are 2 steps 1 is for index and 2 is for to retreive all otheer columns






--in actual execution plan you will see difference between two same table query running
--TABLE SCAN : Scanning entire table page by page, row by row, "everything" which makes query slow
--after creating new index always check execution plan it is used in query or not

*/

/*
--*****
--HINTS
--*****
--use SQL HINTS to tell sql how query should be run
--test hints in all other project environments (DEV/PROD) as performance may vary.
--hints are not permanent fix. use it very carefully and if ther is emergency.

--1.
SELECT O.Sales, C.Country FROM Sales.Orders O
LEFT JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
OPTION (HASH JOIN)

--2.
SELECT O.Sales, C.Country FROM Sales.Orders O
LEFT JOIN Sales.Customers C (WITH FORCESEEK)
ON O.CustomerID = C.CustomerID
*/