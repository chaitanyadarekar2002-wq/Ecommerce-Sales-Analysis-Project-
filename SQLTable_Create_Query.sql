CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(50),
    RegionID INT,
    CreatedAt DATE,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);
create table Region(
RegionID int primary key,
Regionname varchar (50),
country varchar(50)
)
create table Product(
ProductID int primary key,
Productname varchar (50),
category varchar (50),
Price Decimal (10,2),
) 
create table Orderss(
OrderID int primary key,
customerID int,
OrderDate date,
IsReturned Bit,
foreign key (customerID) References Customers(customerID)
)
create table OederDetails(
OrderDetailsID int primary key,
OrderID int,
ProductID int,
Quntity int,
foreign key (OrderID) References Orderss(OrderID),
foreign key (ProductID) References Product(ProductID)
)