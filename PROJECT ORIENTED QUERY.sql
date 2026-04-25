-- SECTION 1: Aggregation + Joins
/*
 1. Total revenue per customer
(Aggregation + Join)
*/
SELECT 
	c.CustomerID, 
	c.CompanyName,
	SUM(so.TotalAmount) AS total_revenue
FROM Customers c
JOIN Sales_Orders so 
ON c.CustomerID = so.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY total_revenue DESC;
/*
2. Revenue by region
 (Join + Grouping)
*/
SELECT se.Region,
SUM(so.TotalAmount) AS revenue
FROM Sales_Employees se
JOIN Sales_Orders so 
ON se.EmployeeID = so.EmployeeID
GROUP BY se.Region;
/*
3. Product-level revenue
(Join + Aggregation)
*/
SELECT p.ProductName,
SUM(od.Quantity * od.UnitPrice) AS revenue
FROM Products p
JOIN Order_Details od 
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY revenue DESC;

-- SECTION 2: Subqueries (Business Logic)

/*
4. Customers above average revenue
(Subquery)
*/
SELECT CustomerID, SUM(TotalAmount) total_rev
FROM Sales_Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(TotalAmount) total
        FROM Sales_Orders
        GROUP BY CustomerID
    ) t
);

-- 5. Orders greater than overall average
SELECT *
FROM Sales_Orders
WHERE TotalAmount > (
    SELECT AVG(TotalAmount) FROM Sales_Orders
);
-- 6. Products never sold
SELECT *
FROM Products
WHERE ProductID NOT IN (
    SELECT ProductID FROM Order_Details
);
-- SECTION 3: Window Functions (Advanced Analytics)
-- 7. Rank customers by revenue(Window + Aggregation)

SELECT CustomerID,
SUM(TotalAmount) AS revenue,
RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS rank_no
FROM Sales_Orders
GROUP BY CustomerID;

-- 8. Running revenue trend (Window)

SELECT OrderDate,
SUM(TotalAmount) OVER (ORDER BY OrderDate) AS running_revenue
FROM Sales_Orders;

-- 9. Top 3 orders per employee (Partition + Window)

SELECT *
FROM (
    SELECT EmployeeID, OrderID, TotalAmount,
    ROW_NUMBER() OVER (
        PARTITION BY EmployeeID 
        ORDER BY TotalAmount DESC
    ) rn
    FROM Sales_Orders
) t
WHERE rn <= 3;

-- SECTION 4: CTE + Window + Join
-- 10. Best employee per region (CTE + Window + Join)

WITH emp_rev AS (
    SELECT se.EmployeeID, se.Region,
    SUM(so.TotalAmount) rev
    FROM Sales_Employees se
    JOIN Sales_Orders so 
    ON se.EmployeeID = so.EmployeeID
    GROUP BY se.EmployeeID, se.Region
)
SELECT *
FROM (
    SELECT *,
    RANK() OVER (PARTITION BY Region ORDER BY rev DESC) rnk
    FROM emp_rev
) t
WHERE rnk = 1;

-- 11. Monthly revenue with growth (CTE + Window)

WITH monthly AS (
    SELECT MONTH(OrderDate) m,
    SUM(TotalAmount) rev
    FROM Sales_Orders
    GROUP BY m
)
SELECT m, rev,
LAG(rev) OVER (ORDER BY m) AS prev_rev,
rev - LAG(rev) OVER (ORDER BY m) AS growth
FROM monthly;

-- SECTION 5: Full Business Problems
 -- 12. Lead conversion rate (Aggregation + Case)

SELECT 
COUNT(*) total,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END) converted,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END)*100.0/COUNT(*) AS rate
FROM Leads;

-- 13. Conversion rate by source (Group + Business logic)

SELECT Source,
COUNT(*) total,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END) converted,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END)*100.0/COUNT(*) rate
FROM Leads
GROUP BY Source;
-- 14. Orders without payment (revenue leakage) (Join + Subquery logic)

SELECT so.OrderID
FROM Sales_Orders so
LEFT JOIN Payments p 
ON so.OrderID = p.OrderID
WHERE p.OrderID IS NULL;

-- 15. Customer segmentation (High / Medium / Low) (CTE + Case)

WITH cust_rev AS (
    SELECT CustomerID,
    SUM(TotalAmount) rev
    FROM Sales_Orders
    GROUP BY CustomerID
)
SELECT CustomerID,
CASE 
WHEN rev > 100000 THEN 'High'
WHEN rev > 50000 THEN 'Medium'
ELSE 'Low'
END segment
FROM cust_rev;

/*
CASE 1: Revenue Drop Analysis
Question :
Revenue dropped last quarter. Identify:
Monthly revenue trend
Month-over-month drop
SQL Solution
*/
WITH monthly AS (
    SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    SUM(TotalAmount) AS revenue
    FROM Sales_Orders
    WHERE DealStage = 'Won'
    GROUP BY month
)
SELECT 
month,
revenue,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
(revenue - LAG(revenue) OVER (ORDER BY month)) AS changee
FROM monthly;
/*
🎯 Insight
Detect exact drop month
Quantify decline
👉 “Revenue dropped 18% MoM due to fewer won deals”
*/
/*
CASE 2: Underperforming Sales Employees
 Question
Find employees:
Not meeting targets
Rank them by performance
✅ SQL Solution
*/
WITH emp_perf AS (
    SELECT 
    se.EmployeeID,
    se.Name,
    se.TargetAmount,
    SUM(so.TotalAmount) AS revenue
    FROM Sales_Employees se
    LEFT JOIN Sales_Orders so 
    ON se.EmployeeID = so.EmployeeID
    GROUP BY se.EmployeeID, se.Name, se.TargetAmount
)
SELECT *,
(revenue / TargetAmount) * 100 AS achievement_pct,
RANK() OVER (ORDER BY revenue ASC) AS worst_rank
FROM emp_perf;
/*
🎯 Insight
Identify weakest performers
👉 “Bottom 20% employees contribute only 8% revenue”
*/
/*
CASE 3: Lead Conversion Funnel Breakdown
Question
Analyze:
Total leads
Contacted
Converted
Conversion rate by source
✅ SQL Solution
*/
SELECT 
Source,
COUNT(*) AS total_leads,
SUM(CASE WHEN Status='Contacted' THEN 1 ELSE 0 END) AS contacted,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END) AS converted,
SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END)*100.0/COUNT(*) AS conversion_rate
FROM Leads
GROUP BY Source
ORDER BY conversion_rate DESC;

/*🎯 Insight
Find best/worst marketing channel
👉 “Referral converts 3x better than LinkedIn”*/
/*
🧠 CASE 4: Customer Retention & Repeat Buyers
 Question
Identify:
Repeat customers
Their revenue contribution
✅ SQL Solution
*/
WITH cust_orders AS (
    SELECT 
    CustomerID,
    COUNT(*) AS order_count,
    SUM(TotalAmount) AS revenue
    FROM Sales_Orders
    GROUP BY CustomerID
)
SELECT 
SUM(CASE WHEN order_count > 1 THEN revenue ELSE 0 END) AS repeat_revenue,
SUM(revenue) AS total_revenue,
SUM(CASE WHEN order_count > 1 THEN revenue ELSE 0 END)*100.0 / SUM(revenue) AS repeat_pct
FROM cust_orders;

/*🎯 Insight
Measure loyalty
👉 “Repeat customers generate 65% of revenue”*/

/*🧠 CASE 5: Revenue Leakage (Unpaid Orders)
 Question

Find:
Orders without payment
Total revenue at risk
✅ SQL Solution*/

SELECT 
COUNT(*) AS unpaid_orders,
SUM(so.TotalAmount) AS revenue_at_risk
FROM Sales_Orders so
LEFT JOIN Payments p 
ON so.OrderID = p.OrderID
WHERE p.OrderID IS NULL;
/*🎯 Insight
Identify financial risk
👉 “₹2.3M revenue is pending due to missing payments”*/

-- Top Product per Category
SELECT *
FROM (
    SELECT 
    p.Category,
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS revenue,
    RANK() OVER (
        PARTITION BY p.Category 
        ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
    ) rnk
    FROM Products p
    JOIN Order_Details od 
    ON p.ProductID = od.ProductID
    GROUP BY p.Category, p.ProductName
) t
WHERE rnk = 1;
