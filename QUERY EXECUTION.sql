/*
=================================================================
QUERY EXECUTION PART _PROJECT:- IT Industry Sales Performance SQL
=================================================================
*/

-- 1.1. Get all customers
SELECT * FROM customers;

-- 1.2. Get all employees
SELECT * FROM Sales_Employees;

-- 1.3. Get all products
SELECT * FROM Products;

-- 1.4. Count customers
SELECT COUNT(*) FROM Customers;

-- 1.5. Count orders
SELECT COUNT(*) FROM Sales_Orders;

-- 1.6. Customers from a specific city
SELECT * FROM Customers WHERE City = 'Mumbai';

-- 1.7. Customers in Tech industry
SELECT * FROM Customers WHERE Industry = 'Tech';

-- 1.8. Distinct industries,focus on which type of industries present
SELECT DISTINCT Industry FROM Customers;

-- 1.9. Highest product price
SELECT MAX(Price) FROM Products;

-- 1.10. Lowest product price
SELECT MIN(Price) FROM Products;

-- 1.11. Sort products by price
SELECT * FROM Products ORDER BY Price DESC;

-- 1.12. Recent customers
SELECT * FROM Customers ORDER BY SignupDate DESC LIMIT 10;

-- 1.13. Orders above 20K
SELECT * FROM Sales_Orders WHERE TotalAmount > 20000;

-- 1.14. Won deals
SELECT * FROM Sales_Orders WHERE DealStage='Won';

-- 1.15. Lost deals
SELECT * FROM Sales_Orders WHERE DealStage='Lost';

-- 1.16. Orders by stage
SELECT DealStage, COUNT(*) FROM Sales_Orders GROUP BY DealStage;

-- 1.17. Earliest order
SELECT MIN(OrderDate) FROM Sales_Orders;

-- 1.18. Latest order
SELECT MAX(OrderDate) FROM Sales_Orders;

-- 1.19. Leads list
SELECT * FROM Leads;

-- 1.20. Leads by status
SELECT Status, COUNT(*) FROM Leads GROUP BY Status;

-- 1.21. Leads from LinkedIn
SELECT * FROM Leads WHERE Source='LinkedIn';

-- 1.22. Employees by region
SELECT Region, COUNT(*) FROM Sales_Employees GROUP BY Region;

-- 1.23. Products by category
SELECT Category, COUNT(*) FROM Products GROUP BY Category;

-- 1. 24. Total payments
SELECT SUM(AmountPaid) FROM Payments;

-- 1.25. Orders in last 30 days
SELECT * FROM Sales_Orders 
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- 1.26. Avg product price
SELECT AVG(Price) FROM Products;

-- 1.27. Total quantity sold
SELECT SUM(Quantity) FROM Order_Details;

-- 1.28. Top 5 expensive orders
SELECT * FROM Sales_Orders ORDER BY TotalAmount DESC LIMIT 5;

-- 1.29. Customers count by country
SELECT Country, COUNT(*) FROM Customers GROUP BY Country;

-- 1.30. Payment methods count
SELECT PaymentMethod, COUNT(*) FROM Payments GROUP BY PaymentMethod;

-- 2.1  Orders with customer name  (Product Name)              
SELECT
	so.OrderID,
    p.ProductName,
    c.CompanyName
FROM sales_orders so
INNER JOIN customers c
ON c.CustomerID = so.CustomerID
INNER JOIN order_details od
ON so.OrderID = od.OrderID
INNER JOIN products P 
on P.ProductID = od.ProductID;

-- 2.2. Orders with employee name (PRODUCT NAME)
SELECT
	e.EmployeeID,
    e.Name,
    so.OrderID,
    p.ProductName
FROM sales_employees e
INNER JOIN sales_orders so
ON e.EmployeeID = so.EmployeeID
INNER JOIN order_details od
ON so.OrderID = od.OrderID
JOIN products p
ON p.ProductID = od.ProductID; 

-- 2.3. Orders(product name) with customer + employee
SELECT
	c.CustomerID,
    c.CompanyName,
    se.EmployeeID,
    se.Name,
    od.OrderID,
    p.ProductName
FROM customers c
JOIN sales_orders so
ON c.CustomerID = so.CustomerID
JOIN sales_employees se
ON se.EmployeeID = so.EmployeeID
JOIN order_details od
ON od.OrderID = so.OrderID
JOIN products p
ON p.ProductID = od.ProductID;

-- 2.4 Order details with product
SELECT 
	p.ProductID,
    p.ProductName,
    od.OrderID,
    so.OrderDate
FROM products p
JOIN order_details od
ON p.ProductID = od.ProductID
JOIN sales_orders so
ON od.OrderID = so.OrderID; 

-- 2.5 Orders with payments
SELECT 
	so.OrderID, 
	p.AmountPaid
FROM Sales_Orders so
JOIN Payments p ON so.OrderID = p.OrderID;

-- 2.6 Customer total orders
SELECT 
	c.CompanyName, 
	COUNT(so.OrderID) AS TOTAL_ORDERS
FROM Customers c
LEFT JOIN Sales_Orders so ON c.CustomerID=so.CustomerID
GROUP BY c.CompanyName
ORDER BY TOTAL_ORDERS DESC ;

-- 2.7 Employee total revenue
SELECT
	se.Name,
    SUM(so.TotalAmount) AS TOTAL_REVENUE
FROM sales_employees se
JOIN sales_orders so
ON se.EmployeeID = so.EmployeeID
group by se.Name
ORDER BY SUM(so.TotalAmount) DESC;

-- 2.8. Product total sales
SELECT 
	p.Category,
    count(od.Quantity) AS TOTAL_SALES
FROM products p
JOIN order_details od
ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TOTAL_SALES DESC;	

-- 2.9. Orders with multiple items
SELECT OrderID, COUNT(*) 
FROM Order_Details 
GROUP BY OrderID 
HAVING COUNT(*)>1;    

-- 2.10. Customers without orders
SELECT c.CustomerID
FROM Customers c
LEFT JOIN Sales_Orders so 
ON c.CustomerID = so.CustomerID
WHERE so.CustomerID IS NULL;

-- 2.11. Employees without sales
SELECT se.EmployeeID
FROM Sales_Employees se
LEFT JOIN Sales_Orders so 
ON se.EmployeeID=so.EmployeeID
WHERE so.EmployeeID IS NULL;

-- 2.12. Revenue per order
SELECT 
	OrderID, 
	SUM(Quantity*UnitPrice) AS REVENUE_PER_ORDER
FROM Order_Details
GROUP BY OrderID;

-- 2.13. Customer revenue
SELECT 
	c.CompanyName, 
	SUM(so.TotalAmount)
FROM Customers c
JOIN Sales_Orders so 
ON c.CustomerID = so.CustomerID
GROUP BY c.CompanyName;

-- 2.14.  Product revenue
SELECT p.ProductName, 
SUM(od.Quantity*od.UnitPrice) AS PRODUCT_REVENUE
FROM Products p
JOIN Order_Details od 
ON p.ProductID=od.ProductID
GROUP BY p.ProductName;

-- 2.15.  Region-wise revenue
SELECT se.Region, 
SUM(so.TotalAmount) AS Revenue
FROM Sales_Employees se
JOIN Sales_Orders so 
ON se.EmployeeID=so.EmployeeID
GROUP BY se.Region;

-- 2.16.  Orders with city
SELECT so.OrderID, c.City
FROM Sales_Orders so
JOIN Customers c 
ON so.CustomerID=c.CustomerID;

-- 2.17.  Orders with payment method
SELECT so.OrderID, p.PaymentMethod
FROM Sales_Orders so
JOIN Payments p 
ON so.OrderID=p.OrderID;

-- 2.18 Leads with email
SELECT CompanyName, Email FROM Leads;

-- 2.19.  Leads converted count
SELECT COUNT(*) FROM Leads WHERE Status='Converted';

-- 2.20.  Orders per employee
SELECT EmployeeID, COUNT(*)
FROM Sales_Orders GROUP BY EmployeeID;

-- 3.1. Assign row numbers to orders
SELECT 
	OrderID,
    row_number() OVER() AS row_num
FROM sales_orders;

-- 3.2. Row number ordered by date
SELECT
	OrderID,
    OrderDate,
    row_number() OVER(ORDER BY OrderDate) AS Row_num
FROM sales_orders;
    
-- 3.3. Rank orders by amount
SELECT 
	OrderID, 
    TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS rank_no
FROM Sales_Orders;

-- 3.4. Dense rank products by price
SELECT 
	ProductName, 
	Price,
	DENSE_RANK() OVER (ORDER BY Price DESC) AS rank_no
FROM Products;

-- 3.5. Partition row number by employee
SELECT
	EmployeeID,
    OrderID,
    row_number() OVER(partition by EmployeeID order by OrderDate) AS Row_No
FROM sales_orders;

-- 3.6. Count orders per employee (window)
SELECT distinct
	EmployeeID,
    count(*) OVER(partition by EmployeeID) AS Total_Count
FROM sales_orders;

-- 3.7. Total revenue (window)
SELECT distinct
    sum(TotalAmount) OVER() AS Revenue
FROM sales_orders;

-- 3.8. Average order value
SELECT distinct
	avg(TotalAmount) Over() AS  AVG_or_Value
FROM sales_orders;

-- 3.9. Max & Min order amount
SELECT distinct
	MAX(TotalAmount) OVER () AS max_val
FROM Sales_Orders;

SELECT distinct
	MIN(TotalAmount) OVER () AS min_val
FROM Sales_Orders;

-- 3.10 Running total revenue
SELECT distinct 
	OrderDate,
	SUM(TotalAmount) OVER (ORDER BY OrderDate) AS running_total
FROM Sales_Orders;

-- 3.11. Running count of orders
SELECT distinct OrderDate,
COUNT(*) OVER (ORDER BY OrderDate) AS running_count
FROM Sales_Orders;

-- 3.12 Revenue per employee cumulative
SELECT 
	EmployeeID, 
	OrderDate,
	SUM(TotalAmount) OVER (PARTITION BY EmployeeID ORDER BY OrderDate) AS cum_sales
FROM Sales_Orders;

-- 3.13. Rank customers by revenue
SELECT 
	CustomerID, 
	SUM(TotalAmount) AS rev,
	RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS rank_
FROM Sales_Orders
GROUP BY CustomerID;

-- 3.14 Quartile grouping   The NTILE() function is a window function that divides an ordered result set into a specified number of roughly equal groups (buckets).
SELECT DISTINCT
	TotalAmount,
	NTILE(4) OVER (ORDER BY TotalAmount) AS quartile
FROM Sales_Orders;

-- 3.15 Customers who placed at least one order
SELECT 
	* 
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT 
		CustomerID 
	FROM Sales_Orders
);

-- 3.16 Orders above average order value
SELECT 
	* 
FROM Sales_Orders
WHERE TotalAmount > (
    SELECT 
		AVG(TotalAmount) 
	FROM Sales_Orders
);

-- 3.17. Employees with sales above average
SELECT 
	EmployeeID
FROM Sales_Orders
GROUP BY EmployeeID
HAVING SUM(TotalAmount) > (
    SELECT 
		AVG(TotalAmount) 
	FROM Sales_Orders
);

-- 3.18. Employees with no sales
SELECT 
	* 
FROM Sales_Employees
WHERE EmployeeID NOT IN (
    SELECT DISTINCT 
		EmployeeID 
	FROM Sales_Orders
);

-- 3.19. Products never sold
SELECT * FROM Products
WHERE ProductID NOT IN (
    SELECT ProductID FROM Order_Details
);

-- 3.20. Highest revenue region
SELECT Region
FROM (
    SELECT se.Region, SUM(so.TotalAmount) rev
    FROM Sales_Employees se
    JOIN Sales_Orders so ON se.EmployeeID=so.EmployeeID
    GROUP BY se.Region
    ORDER BY rev DESC
) t;