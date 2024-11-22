CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID INT,                            
    ProductName NVARCHAR(50),                 
    ProductSubcategoryName NVARCHAR(50),      
    ProductCategoryName NVARCHAR(50),         
    ProductVendorName NVARCHAR(50),           
    Size NVARCHAR(15),                                          
    Color NVARCHAR(15),                       
    StartDate DATETIME NOT NULL,              
    EndDate DATETIME NULL,                    
    IsCurrent BIT NULL                    
);

CREATE TABLE DimVendor (
    VendorKey INT IDENTITY(1,1) PRIMARY KEY,  
    VendorID INT,                             
    Address NVARCHAR(255),                    
    CompanyName NVARCHAR(255),                                     
    StartDate DATETIME NOT NULL,              
    EndDate DATETIME NULL,                    
    IsCurrent BIT NULL                    
);

CREATE TABLE DimShipMethod (
    ShipMethodKey INT IDENTITY(1,1) PRIMARY KEY, 
    ShipMethodID INT,                            
    ShippingCompanyName NVARCHAR(255),          
    ShipBase DECIMAL(10, 2),                    
    ShipRate DECIMAL(10, 2),                    
    StartDate DATETIME NOT NULL,                
    EndDate DATETIME NULL,                      
    IsCurrent BIT Null                      
);

CREATE TABLE DimEmployee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY, 
    EmployeeID INT,                            
    FirstName NVARCHAR(50),                    
    LastName NVARCHAR(50),                     
    JobTitle NVARCHAR(100),                    
    Email NVARCHAR(100),                       
    PhoneNumber NVARCHAR(50),                  
    StartDate DATETIME,               
    EndDate DATETIME,                     
    IsCurrent BIT Null                  
);

CREATE TABLE FactPurchaseOrder (
    PurchaseOrderKey INT IDENTITY(1,1) PRIMARY KEY, 
    ProductKey INT NOT NULL,                                               
    ShipMethodKey INT NOT NULL,                     
    EmployeeKey INT NOT NULL,                       
    VendorKey INT NOT NULL,                          
    OrderQuantity INT,                              
    OrderStatus NVARCHAR(50),                       
    ReceivedQty INT,                                 
    RejectedQty INT,                                 
    StockedQty INT,                                 
    RevisionNumber INT,                             
    UnitPrice DECIMAL(10, 2),                       
    LineTotal DECIMAL(18, 2),                       
    Freight DECIMAL(18, 2),                        
    SubTotal DECIMAL(18, 2),                       
    TaxAmt DECIMAL(18, 2),                         
    OrderTotalCost DECIMAL(18, 2),                 
    OrderDate DATETIME,                            
    DueDate DATETIME,                              
    ShipDate DATETIME,              
);


