-- JOIN MULTIPLE TABLE

SELECT OrderID,
--(sales.Customers.FirstName+' '+sales.Customers.LastName) AS CUSTNAME,
(isnull(c.FirstName, '')+' '+(isnull(c.LastName,''))) as CustName, 
product, Sales, Price, 
(isnull(sales.Employees.FirstName, '')+' '+(isnull(sales.Employees.LastName,''))) as EmpName
-- Sales.Employees.FirstName as EmpName 
FROM sales.orders
LEFT JOIN sales.customers AS c ON sales.orders.CustomerID = c.CustomerID
LEFT JOIN sales.Products ON sales.Orders.ProductID = sales.Products.ProductID
LEFT JOIN sales.Employees ON Sales.Orders.SalesPersonID = Sales.Employees.EmployeeID




--