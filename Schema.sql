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
