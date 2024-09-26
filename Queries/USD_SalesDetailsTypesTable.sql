CREATE TYPE SalesDetailsTypes AS TABLE
(
    ProductId INT,
	SupplierId INT,
	Quantity INT,
	SalePrice DECIMAL(10,2),
	ProductColorId INT,
	Exchange_Item_id INT NULL,
	Exchange_discount DECIMAL(10, 2) NULL
);