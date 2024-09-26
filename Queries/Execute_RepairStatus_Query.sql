-- Use below query to insert reparStaus data.
-- Manually needed data
INSERT INTO RepairStatus (Exchange_id, Item_sent_Date, Completion_Date, Refurbishment_Cost, Status, Remarks)
VALUES (1, '2024-09-26', NULL, 2500.00, 'In Progress', 'Sent to repair center for refurbishing');


--Use below query for updating the product once work was done
UPDATE RepairStatus
SET Actual_Completion_Date = GETDATE(),
    Status = 'Completed',
    Remarks = 'Repair completed and item received back.'
WHERE Exchange_id = @ExchangeId;

