-- This query is used to reset the database files while in testing stage

DELETE FROM SalesDetails
DELETE FROM Sales
DELETE FROM Payments
DELETE FROM Customers


DBCC CHECKIDENT('Sales',RESEED, 0)
DBCC CHECKIDENT('SalesDetails',RESEED, 0)				  
DBCC CHECKIDENT('Payments',RESEED, 0)				  
DBCC CHECKIDENT('Customers',RESEED, 0)				  

--SELECT * FROM Sales
--SELECT * FROM SalesDetails
--SELECT * FROM Payments
--SELECT * FROM Customers

