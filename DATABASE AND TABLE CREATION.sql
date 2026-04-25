/* 
Project Name :- IT Industry Sales Performance SQL
-: Project Objective :-
Build a data-driven sales analytics system to track:-
. Revenue growth
. Sales team performance
. Product performance
. Customer behavior
. Regional trends
*/
/*
 ==========================================================
          CREATE DATABASE AND USE THIS DATA BASE
 ==========================================================
 */
CREATE DATABASE IT_Sales_Analytics;
USE IT_Sales_Analytics;

/*
==============================================================
			       Database Schema
==============================================================
*/
-- 1. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(150),
    Industry VARCHAR(100),
    Country VARCHAR(100),
    City VARCHAR(100),
    SignupDate DATE
);

ALTER TABLE Customers 
ADD COLUMN ADDRESS VARCHAR(100) 
AFTER SignupDate;

-- 2. Sales_Employees Table
CREATE TABLE Sales_Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(100),
    ManagerID INT,
    HireDate DATE,
    TargetAmount DECIMAL(12,2)
);

ALTER TABLE Sales_Employees 
ADD COLUMN City VARCHAR(100) 
AFTER Region;

ALTER TABLE Sales_Employees 
DROP COLUMN ManagerID ;

-- 3. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150),
    Category VARCHAR(100), -- SaaS, Hardware, Cloud, Security
    Price DECIMAL(10,2)
);

-- 4. Sales_Orders Table
CREATE TABLE Sales_Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(12,2),
    DealStage VARCHAR(50), -- Won, Lost, Pipeline
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Sales_Employees(EmployeeID)
);

-- 5. Order_Details Table
CREATE TABLE Order_Details (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Sales_Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 6. Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    AmountPaid DECIMAL(12,2),
    PaymentMethod VARCHAR(50), -- UPI, Card, Bank Transfer
    FOREIGN KEY (OrderID) REFERENCES Sales_Orders(OrderID)
);

-- 7. Leads Table (Sales Funnel Tracking)
CREATE TABLE Leads (
    LeadID INT PRIMARY KEY,
    CompanyName VARCHAR(150),
    Source VARCHAR(100), -- LinkedIn, Website, Referral
    Status VARCHAR(50), -- New, Contacted, Converted
    CreatedDate DATE,
    ConvertedDate DATE
);

ALTER TABLE Leads 
ADD COLUMN ContactName VARCHAR(50),
ADD COLUMN Email VARCHAR(100),
ADD COLUMN Phone BIGINT
AFTER CompanyName;


