INSERT INTO Products (Product_name, Price, Type, Gauge, Height, Weight, Date, Dimensions)
VALUES
('Steel Almirah', 5200, 'Light', 24.00, 6.0, NULL, '2023-09-24', NULL),
('Steel Almirah', 7500, 'Medium', 22.00, 6.0, NULL, '2023-09-24', NULL),
('Steel Almirah', 10000, 'Heavy', 20.00, 6.0, NULL, '2023-09-24', NULL),
('Steel Almirah', 7800, 'Medium', 22.00, 6.5, NULL, '2023-09-24', NULL),
('Steel Almirah', 10500, 'Heavy', 20.00, 6.5, NULL, '2023-09-24', NULL),
('Rack Stand', 800, 'Small', NULL, 3.0, NULL, '2023-09-24', NULL),
('Rack Stand', 1700, 'Light', NULL, 6.0, NULL, '2023-09-24', NULL),
('Rack Stand', 3000, 'Heavy', NULL, 6.0, NULL, '2023-09-24', NULL),
('Almirah Boots', 80, 'Small', NULL, 1.0, NULL, '2023-09-24', NULL),
('Almirah Boots', 120, 'Big', NULL, 1.0, NULL, '2023-09-24', NULL);


--Suppliers
INSERT INTO Suppliers (Supplier_name, Contact_number)
VALUES
('Eswarao', NULL),
('Ravi', NULL),
('Raghu', NULL),
('External', NULL),
('Bhaskar Plastics', NULL);


--Product_suppliers table
INSERT INTO Products_Suppliers (Product_id, Supplier_id, Supply_price)
VALUES
(1, 1, 5200.00),
(2, 1, 7500.00),
(3, 1, 10000.00),
(4, 1, 7800.00),
(5, 1, 10500.00);

INSERT INTO Products_Suppliers (Product_id, Supplier_id, Supply_price)
VALUES
(6, 2, 800.00),
(7, 2, 1700.00),
(8, 2, 3000.00);

INSERT INTO Products_Suppliers (Product_id, Supplier_id, Supply_price)
VALUES
(9, 5, 80.00),
(10, 5, 120.00);



-- colors
INSERT INTO Colors (Color_name) VALUES
('Red'),
('Green'),
('Blue'),
('MidGrey'),
('Silver'),
('Pink'),
('violet');

