--CONCAT, LOWER, UPPER, TRIM, LEN
/*
SELECT
CONCAT(c.firstname,' ',c.LastName) as FullName,
-- CONCAT(sales.customers.firstname,' ',Sales.Customers.LastName),
LOWER(c.firstname),
UPPER(c.lastname),
TRIM(c.firstname), -- trim all the leading trailing spaces
LEN(C.FIRSTNAME) -- counts the number of characters in string
FROM sales.Customers as c
*/



-- REPLACE, LEFT, RIGHT, SUBSTRING

/* SELECT 
'123-456-789' as anyRandomValue,
REPLACE('123-456-789','-','') AS replacedvalue   */
/*
SELECT c.FirstName,
LEFT(c.FirstName,2) AS FirstTwo,
RIGHT(c.FirstName,2) AS lastTwo,
SUBSTRING(c.firstname,2,2) --(value, satrt, no of char)
FROM Sales.Customers as c
*/

-- ROUND
SELECT
3.56545, ROUND(3.56545,2), ROUND(3.56545,0)