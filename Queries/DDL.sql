CREATE TABLE Products(
Product_id INT PRIMARY KEY IDENTITY(1,1),
Product_name VARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Type VARCHAR(15) NOT NULL,
Gauge DECIMAL(10,2) NULL,
Height DECIMAL(10,2) NOT NULL,
Weight DECIMAL(10,2) NULL,
Date DATE NOT NULL,
Dimensions VARCHAR(15) NULL
)


--Suppliers Table
CREATE TABLE Suppliers(
Supplier_id INT PRIMARY KEY IDENTITY(1,1),
Supplier_name VARCHAR(20) NOT NULL,
Contact_number INT NULL
)


--Products_suppliers table which is an junction table for products and suppliers
CREATE TABLE Products_Suppliers (
    Product_id INT NOT NULL,
    Supplier_id INT NOT NULL,
    Supply_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Product_id, Supplier_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id),
    FOREIGN KEY (Supplier_id) REFERENCES Suppliers(Supplier_id)
);


--Create Sales table
CREATE TABLE Sales (
    Sale_id INT PRIMARY KEY IDENTITY(1,1),
    Sale_date DATE NOT NULL,
    Total_amount DECIMAL(10, 2) NOT NULL
);


--Sale details table
CREATE TABLE SalesDetails (
    SalesDetail_id INT PRIMARY KEY IDENTITY(1,1),
    Sale_id INT NOT NULL,
    Product_id INT NOT NULL,
    Supplier_id INT NOT NULL,
    Quantity INT NOT NULL,
    Sale_price DECIMAL(10, 2) NOT NULL,
    Product_color_id INT NULL,
    Exchanged_Item_Id INT NULL,
    Exchange_discount DECIMAL(10, 2) NULL,
    FOREIGN KEY (Sale_id) REFERENCES Sales(Sale_id),
    FOREIGN KEY (Product_id, Supplier_id) REFERENCES Products_Suppliers(Product_id, Supplier_id)
);


CREATE TABLE Colors (
    Color_id INT PRIMARY KEY IDENTITY(1,1),
    Color_name VARCHAR(50) NOT NULL UNIQUE  -- Ensure color names are unique
);

ALTER TABLE SalesDetails
ADD CONSTRAINT FK_Product_Color 
FOREIGN KEY (Product_color_id) REFERENCES Colors(Color_id);


-- Customers table
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY IDENTITY(1,1),  -- Auto-generated primary key
    Customer_name VARCHAR(50) NOT NULL,          -- Customer's name
    Contact_number VARCHAR(15) NULL               -- Customer's contact number
);



--Alter sales
ALTER TABLE Sales
ADD Customer_id INT NOT NULL

ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Customers
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id);


SELECT * FROM Sales


CREATE TABLE Payments (
    Payment_id INT PRIMARY KEY IDENTITY(1,1),
    Sale_id INT NOT NULL,
    Payment_amount DECIMAL(10, 2) NOT NULL,
    Payment_date DATE NOT NULL,
    Payment_type VARCHAR(10) NOT NULL CHECK (Payment_type IN ('Partial', 'Final')), -- Specify if the payment is partial or final
    Remaining_balance DECIMAL(10, 2) NOT NULL,  -- Balance remaining after this payment
    FOREIGN KEY (Sale_id) REFERENCES Sales(Sale_id) ON DELETE CASCADE  -- Ensures referential integrity
);
