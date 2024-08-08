CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NULL,
    Address VARCHAR(200) NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(200) NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    CategoryID INT NULL
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(200) NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NULL,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NULL,
    Phone VARCHAR(20) NULL,
    Email VARCHAR(100) NULL
);
--falta
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    WarehouseID INT NULL,
    CONSTRAINT FK_Inventory_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--falta
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NULL,
    Position VARCHAR(50) NULL
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(200) NULL
);

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(200) NULL
);

CREATE TABLE EmployeeRoles (
    EmployeeRoleID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    RoleID INT NOT NULL,
    CONSTRAINT FK_EmployeeRoles_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT FK_EmployeeRoles_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE CustomerAddresses (
    CustomerAddressID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    Address VARCHAR(200) NOT NULL,
    CONSTRAINT FK_CustomerAddresses_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE ProductImages (
    ProductImageID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    Image VARCHAR(200) NOT NULL,
    CONSTRAINT FK_ProductImages_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductReviews (
    ProductReviewID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    Review VARCHAR(200) NOT NULL,
    Rating INT NOT NULL,
    CONSTRAINT FK_ProductReviews_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_ProductReviews_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderStatus (
    OrderStatusID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Date DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_OrderStatus_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    Carrier VARCHAR(100) NOT NULL,
    TrackingNumber VARCHAR(100) NOT NULL,
    Date DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Shipping_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NULL,
    Reason VARCHAR(200) NOT NULL,
    Date DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Returns_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_Returns_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--falta
CREATE TABLE GiftCards (
    GiftCardID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Date DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_GiftCards_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Code VARCHAR(10) NOT NULL
);

CREATE TABLE Regions (
    RegionID INT PRIMARY KEY IDENTITY(1,1),
    CountryID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Regions_Countries FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Provinces (
    ProvinceID INT PRIMARY KEY IDENTITY(1,1),
    RegionID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Provinces_Regions FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY IDENTITY(1,1),
    ProvinceID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Cities_Provinces FOREIGN KEY (ProvinceID) REFERENCES Provinces(ProvinceID)
);

CREATE TABLE Districts (
    DistrictID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Districts_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

CREATE TABLE ZipCodes (
    ZipCodeID INT PRIMARY KEY IDENTITY(1,1),
    DistrictID INT NOT NULL,
    Code VARCHAR(20) NOT NULL,
    CONSTRAINT FK_ZipCodes_Districts FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID)
);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

ALTER TABLE Products
ADD SupplierID INT NULL;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Suppliers
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);