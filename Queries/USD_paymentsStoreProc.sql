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
-- Author: Viswa
-- Create date: 26-09-2024
-- Description:	This store proc is used insert payments data into payments table.
-- What data is needed for working with this store proc?
-- 1. SalesId of customers to which sale we are updating the Payments Info.
-- 2. Parameters needed: Example @SaleId = 1,@PaymentAmount = 5100.00, @PaymentType = 'Final' or 'Partial';
-- =============================================

CREATE PROCEDURE usp_InsertPayment
    @SaleId INT,
    @PaymentAmount DECIMAL(10, 2),
    @PaymentType VARCHAR(10),
    @RemainingBalance DECIMAL(10, 2) = 0  -- Default value for full payments
AS
BEGIN
    BEGIN TRANSACTION;

    -- Check if the SaleId exists
    IF EXISTS (SELECT 1 FROM Sales WHERE Sale_id = @SaleId)
    BEGIN
        -- Insert the payment
        INSERT INTO Payments (Sale_id, Payment_amount, Payment_date, Payment_type, Remaining_balance)
        VALUES (@SaleId, @PaymentAmount, GETDATE(), @PaymentType, @RemainingBalance);
        
        -- Update the remaining balance if it's a partial payment
        IF @PaymentType = 'Partial' OR @PaymentType = 'Final'
        BEGIN
            DECLARE @TotalPaid DECIMAL(10, 2);
            SELECT @TotalPaid = SUM(Payment_amount) FROM Payments WHERE Sale_id = @SaleId;
            
            DECLARE @TotalSaleAmount DECIMAL(10, 2);
            SELECT @TotalSaleAmount = Total_amount FROM Sales WHERE Sale_id = @SaleId;
            
            SET @RemainingBalance = @TotalSaleAmount - @TotalPaid;
            
			IF @RemainingBalance != 0
			BEGIN
			UPDATE Sales
            SET Remaining_balance = @RemainingBalance, Payment_status = 'Unpaid', Updated_at = GETDATE()
            WHERE Sale_id = @SaleId;
			END
			ELSE
			BEGIN
			UPDATE Sales
            SET Remaining_balance = @RemainingBalance, Payment_status = 'Paid', Updated_at = GETDATE()
            WHERE Sale_id = @SaleId;
			END

        END

        COMMIT TRANSACTION;
        PRINT 'Payment inserted successfully.';
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Sale ID does not exist.';
    END
END
GO

