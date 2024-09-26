--Executing Payments SP
EXECUTE usp_InsertPayment
    @SaleId = 1,
    @PaymentAmount = 5000.00,
    @PaymentType = 'Final'; -- Take two input values 'Partial' Or 'Final'