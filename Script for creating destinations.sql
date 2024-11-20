CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID INT,                            
    ProductName NVARCHAR(50),                 
    ProductSubcategoryName NVARCHAR(50),      
    ProductCategoryName NVARCHAR(50),         
    ProductVendorName NVARCHAR(50),           
    Size NVARCHAR(15),                        
    Weight DECIMAL(10, 2),                    
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
    PhoneNumber NVARCHAR(50),                 
    Email NVARCHAR(100),                      
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

CREATE TABLE DimLocation (
    AddressKey INT IDENTITY(1,1) PRIMARY KEY, 
    AddressID INT,                           
    City NVARCHAR(50),                        
    ProvinceCode NVARCHAR(50),               
    CountryRegionCode NVARCHAR(50),           
    PostalCode NVARCHAR(20),                  
    StartDate DATETIME,              
    EndDate DATETIME,                    
    IsCurrent BIT Null                   
);

CREATE TABLE FactPurchaseOrder (
    PurchaseOrderKey INT IDENTITY(1,1) PRIMARY KEY, 
    ProductKey INT NOT NULL,                        
    AddressKey INT NOT NULL,                        
    ShipMethodKey INT NOT NULL,                     
    EmployeeKey INT NOT NULL,                       
    VendorKey INT NOT NULL,                         
    DateKey DATE,  
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


DROP TABLE IF EXISTS DW_Final_Purchasing.DimTime;
DECLARE @StartDate date = '20110101';
DECLARE @Year int = 4;
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, @Year, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    DateKey         	= CONVERT(datetime, d),
    TheDay         		= DATEPART(DAY,       d),
    TheDayName      	= DATENAME(WEEKDAY,   d),
    TheWeek         	= DATEPART(WEEK,      d),
    TheISOWeek      	= DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    	= DATEPART(WEEKDAY,   d),
    TheMonth        	= DATEPART(MONTH,     d),
    TheMonthName    	= DATENAME(MONTH,     d),
    TheQuarter      	= DATEPART(Quarter,   d),
    TheYear         	= DATEPART(YEAR,      d),
    TheFirstOfMonth 	= DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   	= DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    	= DATEPART(DAYOFYEAR, d)
  FROM d
)


SELECT * 
INTO DimTime 
FROM src
ORDER BY DateKey
OPTION (MAXRECURSION 0)

ALTER TABLE DimTime
ALTER COLUMN DateKey DATETIME NOT NULL;
ALTER TABLE DimTime
ADD CONSTRAINT PK_DimTime PRIMARY KEY (DateKey);
