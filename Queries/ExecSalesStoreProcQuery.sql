-- User Defined Table
DECLARE @SalesDetailsTVP SalesDetailsTypes;

-- Insert multiple rows into the table-valued parameter
INSERT INTO @SalesDetailsTVP (ProductId, SupplierId, Quantity, SalePrice, ProductColorId, Exchange_Item_id, Exchange_discount)
VALUES 
(5, 1, 1, 10500, 1, NULL, NULL), 
(10, 5, 1, 120, 1, NULL, NULL);

DECLARE @CustomerNumber VARCHAR(50) = '8919702675'; 
DECLARE @Name VARCHAR(100) = 'Harsha';
DECLARE @Price DECIMAL(10, 2) = 10620;
DECLARE @IsExchange BIT = 1;  -- Set to 1 for exchange, 0 for regular sale
DECLARE @OriginalProductId INT = 5;  -- Example original product ID
DECLARE @OriginalSupplierId INT = 1;  -- Example original supplier ID
DECLARE @RefurbishmentCost DECIMAL(10, 2) = 2500;  -- Example refurbishment cost
DECLARE @EstimateResaleValue DECIMAL(10, 2) = 4500;  -- Example estimated resale value
DECLARE @ActualResaleValue DECIMAL(10, 2) = NULL;  -- Example actual resale value
DECLARE @ProfitOrLoss DECIMAL(10, 2) = NULL;  -- Example profit or loss
DECLARE @CurrentStatus VARCHAR(10)  = 'Pending'; --'Pending' Or 'Completed'
DECLARE @Discount DECIMAL(10, 2) = 2000;
DECLARE @AdditionalComments VARCHAR(100) = 'Sold for ';

-- Sales
EXECUTE dbo.usp_InsertSales
    @MobileNumber = @CustomerNumber, 
    @CustomerName = @Name, 
    @SaleAmount = @Price,
    @IsExchange = @IsExchange,
    @OriginalProductId = @OriginalProductId,
    @OriginalSupplierId = @OriginalSupplierId,
    @RefurbishmentCost = @RefurbishmentCost,
    @EstimateResaleValue = @EstimateResaleValue,
    @ActualResaleValue = @ActualResaleValue,
    @ProfitOrLoss = @ProfitOrLoss,
	@Status = @CurrentStatus,
	@PriceCut = @Discount,
	@Comments = @AdditionalComments,
    @SalesDetails = @SalesDetailsTVP;

