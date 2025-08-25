--===================
--TABLE PARTITIONING
--===================
--**************************
--STEP 1: CREATING PARTITION
--**************************
/*
CREATE PARTITION FUNCTION partitionbyyear8 (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31','2024-12-31','2025-12-31')
*/
--TO CHECK THE FUNCTION
--Query lists all existing Partition Function
/*
SELECT
	name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
FROM sys.partition_functions
*/
--**************************
--STEP 2: CREATING FILEGROPS 
--**************************
--It is a logical container of one or more data files to help organise partition
/*
ALTER DATABASE SalesDB ADD FILEGROUP FG_20231
ALTER DATABASE SalesDB ADD FILEGROUP FG_20241
ALTER DATABASE SalesDB ADD FILEGROUP FG_20251
ALTER DATABASE SalesDB ADD FILEGROUP FG_20261
*/

--To remove file group
--ALTER DATABASE SalesDB REMOVE FILEGROUP FG_20261;

--To check the list of filegroups
/*
SELECT * FROM sys.filegroups
WHERE type = 'FG';
*/

 --**************************************************
--STEP 3: CREATING .ndf DATA FILES IN EACH FILEGROUP
--**************************************************
/*
ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_20231, --logical name
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_20231.ndf'
) TO FILEGROUP FG_20231;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_20241, --logical name
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_20241.ndf'
) TO FILEGROUP FG_20241;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_20251, --logical name
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_20251.ndf'
) TO FILEGROUP FG_20251;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_20261, --logical name
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_20261.ndf'
) TO FILEGROUP FG_20261;
*/

-- to check the metadata and file size of created files
/*
SELECT 
	fg.name as FilegroupName,
	nf.name as LogicalFileNmae,
	nf.physical_name as PhysicalFilePath,
	nf.size /128 as sizeinMB
FROM
	sys.filegroups fg
JOIN
	sys.master_files nf ON fg.data_space_id = nf.data_space_id
WHERE 
	nf.database_id = DB_ID('SalesDB');
*/

--**********************************
--STEP 4 : CREATING PARTITION SCHEME
--**********************************
--connecting the files to table
/*
CREATE PARTITION SCHEME SchemePartitionByYear8
AS PARTITION partitionbyyear8
TO (FG_20231,FG_20241,FG_20251,FG_20261)
*/

--query to list all partition scehme
/*
SELECT
	ps.name as partitionschemename,
	pf.name as partitionfunctionname,
	ds.destination_id as partitionnumber,
	fg.name as filegroupname
FROM sys.partition_schemes ps
JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_scheme_id
JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id
*/

--**********************************
--STEP 5: CREATING PARTITIONED TABLE
--**********************************
/*
CREATE TABLE Sales.Orders_Partitioned
(
	OrderID INT,
	OrderDate DATE,
	Sales INT
) ON SchemePartitionByYear8 (OrderDate)  --Scheme name given in step:4
*/
--*********************************
--STEP 6: INSERTING VALUES IN TABLE
--*********************************

--INSERT INTO Sales.Orders_Partitioned VALUES (1,'2023-05-15',100)
--INSERT INTO Sales.Orders_Partitioned VALUES (2,'2024-05-15',200),(3,'2025-05-15',300),(4,'2026-05-15',400),(5,'2023-05-15',500)
