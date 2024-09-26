--User Defined Table
DECLARE @SalesDetailsTVP SalesDetailsTypes;


-- Insert multiple rows into the table-valued parameter
INSERT INTO @SalesDetailsTVP (ProductId, SupplierId, Quantity, SalePrice, ProductColorId, Exchange_Item_id, Exchange_discount)
VALUES 
(3,1,1,10000,1,NULL, NULL), 
(9,5,1,80,1, NULL, NULL);


DECLARE @CustomerNumber VARCHAR(50) = '8919702674';
DECLARE @Name VARCHAR(10) = 'harsha';
DECLARE @Price DECIMAL(10,2) = 10080;

--Sales
EXECUTE dbo.usp_InsertSales
@MobileNumber = @CustomerNumber , @CustomerName = @Name, @SaleAmount = @Price,
@SalesDetails = @SalesDetailsTVP;