-- Insert sample data into Products
INSERT INTO Products (Product_id, Product_name, Price, Type, Gauge, Colour, Height, Weight, Date, Dimensions)
VALUES 
(1, 'Steel Rod', 500, 'Rod', 1.5, 'Silver', 12.5, 5.0, '2023-08-01', '12x1x1'),
(2, 'Copper Wire', 300, 'Wire', 0.5, 'Copper', 25.0, 2.0, '2023-08-02', '25x0.5'),
(3, 'Aluminum Sheet', 700, 'Sheet', 2.0, 'Gray', 10.0, 15.0, '2023-08-03', '10x5x0.2');

-- Insert sample data into Suppliers
INSERT INTO Suppliers (Supplier_id, Supplier_name)
VALUES 
(1, 'Metal Suppliers Inc.'),
(2, 'Copper World Ltd.'),
(3, 'Aluminum Works Co.');

-- Insert sample data into Products_Suppliers
INSERT INTO Products_Suppliers (Product_id, Supplier_id, SupplyPrice)
VALUES 
(1, 1, 450),  -- Steel Rod from Metal Suppliers Inc.
(2, 2, 250),  -- Copper Wire from Copper World Ltd.
(3, 3, 650),  -- Aluminum Sheet from Aluminum Works Co.
(1, 3, 440);  -- Steel Rod from Aluminum Works Co.

-- Insert sample data into Sales
INSERT INTO Sales (Sale_id, Sale_date, Total_amount)
VALUES 
(1, '2023-08-05', 1150),  -- Total of Sale_Details for Sale_id = 1 should match 1150
(2, '2023-08-06', 650),   -- Total of Sale_Details for Sale_id = 2 should match 650
(3, '2023-08-07', 440);   -- Total of Sale_Details for Sale_id = 3 should match 440

-- Insert sample data into Sale_Details
INSERT INTO Sale_Details (SalesDetail_id, Sale_id, Product_id, Supplier_id, Quantity, Price)
VALUES 
(1, 1, 1, 1, 2, 900),   -- 2 Steel Rods from Supplier 1 (450 * 2 = 900)
(2, 1, 2, 2, 1, 250),   -- 1 Copper Wire from Supplier 2 (250 * 1 = 250)
(3, 2, 3, 3, 1, 650),   -- 1 Aluminum Sheet from Supplier 3 (650 * 1 = 650)
(4, 3, 1, 3, 1, 440);   -- 1 Steel Rod from Supplier 3 (440 * 1 = 440)
