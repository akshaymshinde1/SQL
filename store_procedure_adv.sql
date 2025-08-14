/*
ALTER PROCEDURE getcustomersummary @country NVARCHAR (50) ='USA'
AS
BEGIN
	BEGIN TRY
		DECLARE @totalcustomers INT, @avgscore FLOAT;
		--=================================
		--Step 1 : Prepare and Cleanup Data
		--=================================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @country)
		BEGIN
			PRINT('Updating null score to 0');
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @country;
		END
		ELSE
		BEGIN
			PRINT('No null score found');
		END;
		--=================================
		--Step 2 : Generating Summary Reprt
		--=================================
		--Calculate total customers and avg score for specific country
		SELECT 
			@totalcustomers = COUNT(*),
			@avgscore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @country;
		PRINT 'Total Customers from'+' ' + @country + ':' + CAST(@totalcustomers AS NVARCHAR);
		PRINT 'Average Score from'+' ' + @country + ':' + CAST(@avgscore AS NVARCHAR);

		--Calculate total number of orders and total sales for specif country
		SELECT
			COUNT(OrderID) totalorders,
			SUM(Sales) totalsales
		FROM Sales.Orders o
		JOIN Sales.Customers c ON o.CustomerID = C.CustomerID
		WHERE c.Country = @country;
	END TRY
	BEGIN CATCH
		--========================
		-- Step 3 : Error Handling
		--========================
		PRINT('An error occured.');
		PRINT('Error Message:'+ERROR_MESSAGE());
		PRINT('Error Number:'+CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Error Line:'+CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure:'+ERROR_PROCEDURE());
	END CATCH
END
*/


--EXEC getcustomersummary	@country ='Germany'

SELECT * FROM Sales.Customers
--here the customer table got update score from null to 0.