-- Table: Products
CREATE TABLE Products (
    Product_id INT NOT NULL PRIMARY KEY,
    Product_name CHAR(50) NOT NULL,
    Price INT NOT NULL,
    Type CHAR(10),
    Gauge DECIMAL,
    Colour CHAR(10),
    Height FLOAT,
    Weight FLOAT,
    Date DATE NOT NULL,
    Dimensions CHAR(50) NULL
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    Supplier_id INT NOT NULL PRIMARY KEY,
    Supplier_name CHAR(50) NOT NULL
);

-- Table: Products_Suppliers
CREATE TABLE Products_Suppliers (
    Product_id INT NOT NULL,
    Supplier_id INT NOT NULL,
    SupplyPrice INT NOT NULL,
    PRIMARY KEY (Product_id, Supplier_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id),
    FOREIGN KEY (Supplier_id) REFERENCES Suppliers(Supplier_id)
);

-- Table: Sales
CREATE TABLE Sales (
    Sale_id INT NOT NULL PRIMARY KEY,
    Sale_date DATE NOT NULL,
    Total_amount DECIMAL NOT NULL
);

-- Table: Sale_Details
CREATE TABLE Sale_Details (
    SalesDetail_id INT NOT NULL PRIMARY KEY,
    Sale_id INT NOT NULL,
    Product_id INT NOT NULL,
    Supplier_id INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (Sale_id) REFERENCES Sales(Sale_id),
    FOREIGN KEY (Product_id, Supplier_id) REFERENCES Products_Suppliers(Product_id, Supplier_id)
);


CREATE TABLE ExchangedItems (
    Exchange_Id INT IDENTITY(1,1) PRIMARY KEY,
    Original_Product_Id INT NOT NULL,
    Original_Supplier_Id INT NOT NULL,
    Exchange_Date DATETIME NOT NULL,
    Refurbishment_Cost DECIMAL(10, 2) NULL,
    Estimated_Resale_Value DECIMAL(10, 2) NULL,
    Actual_Resale_Value DECIMAL(10, 2) NOT NULL,
    Profit_Or_Loss DECIMAL(10, 2) NULL,
    Status CHAR(1) NOT NULL,
    CONSTRAINT FK_ExchangedItems_Products_Suppliers FOREIGN KEY (Original_Product_Id, Original_Supplier_Id) 
        REFERENCES Products_Suppliers(Product_Id, Supplier_Id)
);

ALTER TABLE ExchangedItems
ALTER column Status VARCHAR(5)



ALTER TABLE SalesDetails
ADD CONSTRAINT FK_SalesDetails_ExchangedItems FOREIGN KEY (Exchanged_Item_Id) 
    REFERENCES ExchangedItems(Exchange_Id);


CREATE TABLE RepairStatus (
    RepairStatus_id INT IDENTITY(1,1) PRIMARY KEY,
    Exchange_id INT NOT NULL, -- Reference to the ExchangedItems table
    Item_sent_Date DATE NOT NULL,
    Completion_Date DATE,
    Status VARCHAR(20) NOT NULL, -- E.g., "In Progress", "Completed", etc.
    Remarks VARCHAR(255), -- Optional comments or remarks about the repair process
    FOREIGN KEY (Exchange_id) REFERENCES ExchangedItems(Exchange_id) -- Link to the ExchangedItems table
);

