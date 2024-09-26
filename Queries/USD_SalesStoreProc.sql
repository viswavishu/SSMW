-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Viswanadh
-- Create date: 26-09-2024
-- Description:	This store proc is used to Create New customers if not existed and insert new sales for the customer
-- =============================================
-- =============================================
-- =============================================
--DROP PROCEDURE usp_InsertSales
CREATE PROCEDURE usp_InsertSales
    @MobileNumber VARCHAR(15),
    @CustomerName VARCHAR(100),
    @SaleAmount DECIMAL(10,2),
	--Exchange Variables:
	@IsExchange BIT, -- New parameter to indicate if it's an exchange
    @OriginalProductId INT = NULL,
    @OriginalSupplierId INT = NULL,
    @RefurbishmentCost DECIMAL(10, 2) = NULL,
    @EstimateResaleValue DECIMAL(10, 2) = NULL,
    @ActualResaleValue DECIMAL(10, 2) = NULL,
    @ProfitOrLoss DECIMAL(10, 2) = NULL,
	@Status VARCHAR(10) = NULL,
	@PriceCut DECIMAL(10, 2) = NULL,
	@Comments VARCHAR(100) = NULL,
	@SalesDetails SalesDetailsTypes READONLY

AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        DECLARE @CustomerID INT;
        DECLARE @Date DATETIME;
		DECLARE @Exchange_Item_Id INT; --Exchange Variables:

        SET @Date = GETDATE();

        -- Check if the customer already exists
        SELECT @CustomerID = Customer_ID
        FROM Customers
        WHERE Contact_number = @MobileNumber;

        -- If the customer does not exist, insert the new customer
        IF @CustomerID IS NULL
        BEGIN
            INSERT INTO Customers (Customer_name, Contact_number)
            VALUES (@CustomerName, @MobileNumber);

            SET @CustomerID = SCOPE_IDENTITY();
            PRINT 'New customer inserted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Customer already exists with ID: ' + CAST(@CustomerID AS VARCHAR);
        END

        
		--Exchange Logic Begin

		IF @IsExchange = 1
    BEGIN
        -- Insert Exchange record
INSERT INTO ExchangedItems (Original_product_id, Original_supplier_id, Exchange_date, Refurbishment_cost, Estimated_Resale_Value, Actual_Resale_Value, Profit_Or_Loss, Status, Price_Cut, Comments)
VALUES (@OriginalProductId, @OriginalSupplierId, GETDATE(), @RefurbishmentCost, @EstimateResaleValue, @ActualResaleValue, @ProfitOrLoss, @Status, @PriceCut, @Comments);


        SET @Exchange_Item_Id = SCOPE_IDENTITY();
    END

	-- Insert into Sales
		INSERT INTO Sales(Sale_date, Total_amount, Customer_id, Created_at, IsExchanged, ExchangeID)
        VALUES(@Date, @SaleAmount, @CustomerID,  GETDATE(), @IsExchange,
        CASE WHEN @IsExchange = 1 THEN @Exchange_Item_Id ELSE NULL END);

        DECLARE @saleId INT = SCOPE_IDENTITY();  -- Get the last inserted Sale ID



	 -- Insert into SalesDetails
    INSERT INTO SalesDetails(Sale_id, Product_id, Supplier_id, Quantity, Sale_price, Product_color_id, Exchanged_Item_Id)
    SELECT @SaleID, ProductId, SupplierId, Quantity, SalePrice, ProductColorId, CASE WHEN @IsExchange = 1 THEN @Exchange_Item_Id ELSE NULL END
    FROM @SalesDetails;

		--Exchange Logic Ends

        ---- Insert into SalesDetails using the table-valued parameter
        --INSERT INTO SalesDetails (
        --    Sale_id, Product_id, Supplier_id, Quantity, Sale_price, Product_color_id, Exchanged_Item_Id, Exchange_discount
        --)
        --SELECT 
        --    @saleId, ProductId, SupplierId, Quantity, SalePrice, ProductColorId, Exchange_Item_id, Exchange_discount
        --FROM @SalesDetails;  -- Insert all rows from the TVP

        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;  -- Rollback on error
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
GO

