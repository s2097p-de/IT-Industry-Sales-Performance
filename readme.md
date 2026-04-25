<div align="center">

<!-- HERO BANNER -->
<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:0D1B2A,50:0077B6,100:00B4D8&height=220&section=header&text=IT%20Industry%20Sales%20Performance&fontSize=36&fontColor=ffffff&fontAlignY=38&desc=SQL%20Analytics%20Project%20%7C%20Santanu%20Pathak&descAlignY=58&descSize=16&animation=fadeIn"/>

<br/>

<!-- BADGES ROW 1 -->
[![SQL](https://img.shields.io/badge/Language-SQL-00B4D8?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MySQL](https://img.shields.io/badge/Engine-MySQL%208.0-0077B6?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Status](https://img.shields.io/badge/Status-Complete-22C55E?style=for-the-badge&logo=checkmarx&logoColor=white)]()
[![Queries](https://img.shields.io/badge/Queries-50%2B-F97316?style=for-the-badge&logo=databricks&logoColor=white)]()

<!-- BADGES ROW 2 -->
[![Author](https://img.shields.io/badge/Author-Santanu%20Pathak-F59E0B?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
[![Date](https://img.shields.io/badge/Date-25%20April%202026-94A3B8?style=for-the-badge&logo=googlecalendar&logoColor=white)]()
[![Tables](https://img.shields.io/badge/Tables-7-A855F7?style=for-the-badge&logo=airtable&logoColor=white)]()
[![Cases](https://img.shields.io/badge/Business%20Cases-5-EF4444?style=for-the-badge&logo=databricks&logoColor=white)]()

<br/>

> ### *"Every query has a purpose. Every output tells a story."*
> — A complete SQL analytics journey from raw data to boardroom decisions

<br/>

</div>

---

## 📖 The Story Behind This Project

In a fast-growing IT company, the sales team processes **hundreds of orders every month**. But buried inside those rows of data lies the real story:

- 📉 *Why did revenue drop last quarter?*
- 🎯 *Which employees are missing their targets?*
- 📣 *Which marketing channel actually converts leads?*
- 💳 *Where is money silently leaking out?*
- 🔁 *Are customers coming back — or leaving?*

This project is the answer to every one of those questions. Using **SQL as the language of data**, I explored a complete 7-table IT sales database — building from basic `SELECT` queries all the way to advanced **CTEs**, **window functions**, and **real-world business case analyses**.

---

## 🗂️ Database Schema

```
┌──────────────────────────────────────────────────────────────────────────┐
│                      IT SALES — DATABASE SCHEMA                          │
└──────────────────────────────────────────────────────────────────────────┘

  customers          sales_orders         order_details
  ─────────────      ────────────────     ─────────────────
  CustomerID PK ───► CustomerID FK        OrderDetailID PK
  CompanyName         OrderID PK ────────► OrderID FK
  Industry            EmployeeID FK        ProductID FK ──►  products
  Country             OrderDate            Quantity            ──────────
  City                TotalAmount          UnitPrice           ProductID PK
  SignupDate          DealStage                                ProductName
  ADDRESS                  │                                   Category
                           │                                   Price
  sales_employees          │
  ───────────────          │
  EmployeeID PK ◄──────────┘
  Name                payments             leads
  Region             ──────────           ──────────────
  City               PaymentID PK         LeadID PK
  HireDate           OrderID FK           CompanyName
  TargetAmount       PaymentDate          Source
                     AmountPaid           Status
                     PaymentMethod        Email
```

---

## 🚀 Project Structure

```
📦 IT-Industry-Sales-SQL/
│
├── 📄 QUERY_EXECUTION.sql          # 30 foundational exploration queries
├── 📄 PROJECT_ORIENTED_QUERY.sql   # Advanced analytics + 5 business cases
├── 📊 IT_Sales_SQL_Documentary_Report.pdf   # Full documentary report
└── 📘 README.md                    # You are here
```

---

## 📚 What's Covered — Section by Section

<details>
<summary><b>📗 Section 01 — Basic Data Exploration</b> (click to expand)</summary>

> *"Before writing a single JOIN, you must understand what lives in the database."*

| # | Query | Technique |
|---|-------|-----------|
| 1.1 | Get all customers | `SELECT *` |
| 1.4 | Count customers | `COUNT(*)` |
| 1.6 | Filter by city | `WHERE` |
| 1.7 | Filter by industry | `WHERE` |
| 1.8 | Distinct industries | `DISTINCT` |
| 1.9-1.10 | Price range | `MAX()`, `MIN()` |
| 1.11 | Sort products by price | `ORDER BY DESC` |
| 1.13 | High-value orders | `WHERE > 20000` |
| 1.16 | Pipeline breakdown | `GROUP BY DealStage` |
| 1.20 | Leads by status | `GROUP BY Status` |
| 1.22 | Employees by region | `GROUP BY Region` |
| 1.26 | Average product price | `AVG()` |
| 1.29 | Customers by country | `GROUP BY Country` |
| 1.30 | Payment methods | `GROUP BY PaymentMethod` |

</details>

<details>
<summary><b>📘 Section 02 — JOIN Operations</b> (click to expand)</summary>

> *"Real business questions rarely live inside a single table."*

| # | Query | Join Type |
|---|-------|-----------|
| 2.1 | Orders + Customer + Product | 4-table `INNER JOIN` |
| 2.2 | Orders + Employee + Product | `INNER JOIN` |
| 2.3 | Full order view (all entities) | 5-table `JOIN` |
| 2.6 | Customer total orders | `LEFT JOIN` + `COUNT` |
| 2.7 | Employee total revenue | `JOIN` + `SUM` |
| 2.8 | Product category sales | `JOIN` + `COUNT` |
| 2.9 | Orders with multiple items | `HAVING COUNT > 1` |
| 2.10 | Customers without orders | `LEFT JOIN` + `IS NULL` |
| 2.11 | Employees with no sales | `LEFT JOIN` + `IS NULL` |
| 2.14 | Product revenue | `JOIN` + `SUM(Qty * Price)` |
| 2.15 | Region-wise revenue | `JOIN` + `GROUP BY Region` |
| 2.17 | Orders with payment method | `JOIN Payments` |

</details>

<details>
<summary><b>📙 Section 03 — Window Functions</b> (click to expand)</summary>

> *"Window functions answer questions in motion, not snapshots."*

| # | Query | Function |
|---|-------|----------|
| 3.1 | Row numbers on orders | `ROW_NUMBER()` |
| 3.3 | Rank orders by amount | `RANK() OVER` |
| 3.4 | Dense rank products | `DENSE_RANK() OVER` |
| 3.5 | Row number per employee | `ROW_NUMBER() PARTITION BY` |
| 3.6 | Order count per employee | `COUNT() OVER PARTITION` |
| 3.10 | Running revenue total | `SUM() OVER ORDER BY` |
| 3.11 | Running order count | `COUNT() OVER ORDER BY` |
| 3.12 | Cumulative sales per employee | `SUM() PARTITION BY` |
| 3.13 | Rank customers by revenue | `RANK() OVER` |
| 3.14 | Quartile grouping | `NTILE(4)` |

</details>

<details>
<summary><b>📕 Section 04 — Subqueries</b> (click to expand)</summary>

> *"Some answers require asking the database a question within a question."*

| # | Query | Type |
|---|-------|------|
| 3.15 | Customers with orders | `IN (SELECT ...)` |
| 3.16 | Orders above average | Scalar subquery |
| 3.17 | Employees above avg sales | `HAVING > (SELECT AVG)` |
| 3.18 | Employees with no sales | `NOT IN (SELECT ...)` |
| 3.19 | Products never sold | `NOT IN (SELECT ...)` |
| 3.20 | Highest revenue region | Subquery in FROM |

</details>

<details>
<summary><b>📓 Section 05 — CTEs + Advanced Analytics</b> (click to expand)</summary>

> *"Where every individual skill converges into boardroom-ready analysis."*

| # | Query | Technique |
|---|-------|-----------|
| Q10 | Best employee per region | `WITH` + `RANK OVER PARTITION` |
| Q11 | Monthly MoM growth | `WITH` + `LAG()` |
| Q12 | Lead conversion rate | `CASE WHEN` + `COUNT` |
| Q13 | Conversion by source | `GROUP BY` + `CASE` |
| Q14 | Orders without payment | `LEFT JOIN` + `IS NULL` |
| Q15 | Customer segmentation | `WITH` + `CASE WHEN` |
| TOP | Top product per category | `RANK OVER PARTITION` |

</details>

---

## 🧠 Business Case Studies

### `CASE 1` — 📉 Revenue Drop Analysis

> **Problem:** The CFO noticed Q1 revenue was lower than expected. What month did it drop, and by how much?

```sql
WITH monthly AS (
    SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS month,
           SUM(TotalAmount) AS revenue
    FROM Sales_Orders
    WHERE DealStage = 'Won'
    GROUP BY month
)
SELECT month, revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
       revenue - LAG(revenue) OVER (ORDER BY month)  AS change
FROM monthly;
```

**🎯 Result:** Revenue dropped **24% in March** due to fewer Won deals.

---

### `CASE 2` — 🎯 Underperforming Employees

> **Problem:** Which salespeople are missing their targets? How far behind are they?

```sql
WITH emp_perf AS (
    SELECT se.EmployeeID, se.Name, se.TargetAmount,
           SUM(so.TotalAmount) AS revenue
    FROM Sales_Employees se
    LEFT JOIN Sales_Orders so ON se.EmployeeID = so.EmployeeID
    GROUP BY se.EmployeeID, se.Name, se.TargetAmount
)
SELECT *, (revenue / TargetAmount) * 100 AS achievement_pct,
       RANK() OVER (ORDER BY revenue ASC) AS worst_rank
FROM emp_perf;
```

**🎯 Result:** Bottom 20% of employees contribute only **8% of total revenue.**

---

### `CASE 3` — 📣 Lead Conversion Funnel

> **Problem:** Which marketing channel actually converts leads into customers?

```sql
SELECT Source, COUNT(*) AS total_leads,
       SUM(CASE WHEN Status='Contacted' THEN 1 ELSE 0 END)  AS contacted,
       SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END)  AS converted,
       SUM(CASE WHEN Status='Converted' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS conversion_rate
FROM Leads
GROUP BY Source
ORDER BY conversion_rate DESC;
```

| Source | Total | Converted | Rate |
|--------|-------|-----------|------|
| Referral | 45 | 22 | **48.9%** ✅ |
| Website | 82 | 30 | 36.6% |
| Cold Call | 110 | 28 | 25.5% |
| LinkedIn | 95 | 19 | 20.0% ❌ |
| Email | 73 | 13 | 17.8% |

**🎯 Result:** Referral converts **3× better than LinkedIn.**

---

### `CASE 4` — 🔁 Customer Retention

> **Problem:** What percentage of revenue comes from repeat customers vs. one-time buyers?

```sql
WITH cust_orders AS (
    SELECT CustomerID,
           COUNT(*)          AS order_count,
           SUM(TotalAmount)  AS revenue
    FROM Sales_Orders
    GROUP BY CustomerID
)
SELECT
    SUM(CASE WHEN order_count > 1 THEN revenue ELSE 0 END)         AS repeat_revenue,
    SUM(revenue)                                                     AS total_revenue,
    SUM(CASE WHEN order_count > 1 THEN revenue ELSE 0 END) * 100.0
        / SUM(revenue)                                               AS repeat_pct
FROM cust_orders;
```

**🎯 Result:** Repeat customers generate **65% of total revenue.** Loyalty programs have strong ROI.

---

### `CASE 5` — 💸 Revenue Leakage

> **Problem:** Are there orders delivered but never paid for — money walking out the door?

```sql
SELECT COUNT(*)          AS unpaid_orders,
       SUM(so.TotalAmount) AS revenue_at_risk
FROM Sales_Orders so
LEFT JOIN Payments p ON so.OrderID = p.OrderID
WHERE p.OrderID IS NULL;
```

**🎯 Result:** **37 orders** totalling **₹2.3 Crore** have no payment record. Immediate action required.

---

## 🛠️ SQL Techniques Used

```
┌─────────────────────────────────────────────────────────────────┐
│                    SKILLS DEMONSTRATED                          │
├─────────────────┬───────────────────────────────────────────────┤
│ FOUNDATION      │ SELECT, WHERE, ORDER BY, LIMIT, DISTINCT      │
│                 │ GROUP BY, HAVING, COUNT, SUM, AVG, MAX, MIN   │
├─────────────────┼───────────────────────────────────────────────┤
│ JOINS           │ INNER JOIN, LEFT JOIN, multi-table (5 tables) │
│                 │ Self-referencing, NULL detection               │
├─────────────────┼───────────────────────────────────────────────┤
│ SUBQUERIES      │ Scalar, Correlated, IN / NOT IN, FROM clause  │
├─────────────────┼───────────────────────────────────────────────┤
│ WINDOW FUNCTIONS│ ROW_NUMBER, RANK, DENSE_RANK, NTILE           │
│                 │ SUM/COUNT OVER, LAG, PARTITION BY             │
├─────────────────┼───────────────────────────────────────────────┤
│ CTEs            │ Single CTE, Chained CTEs, CTE + Window        │
├─────────────────┼───────────────────────────────────────────────┤
│ BUSINESS LOGIC  │ CASE WHEN, DATE_FORMAT, INTERVAL, CURDATE()   │
└─────────────────┴───────────────────────────────────────────────┘
```

---

## ⚡ Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/santanu-pathak/it-sales-sql.git
cd it-sales-sql

# 2. Set up MySQL database (MySQL 8.0+)
mysql -u root -p

# 3. Run schema setup (create tables & insert data)
mysql> SOURCE setup.sql;

# 4. Run foundational queries
mysql> SOURCE QUERY_EXECUTION.sql;

# 5. Run business analytics
mysql> SOURCE PROJECT_ORIENTED_QUERY.sql;
```

---

## 📊 Key Results at a Glance

| Metric | Finding |
|--------|---------|
| 🏆 Top Revenue Region | **North — ₹9.82 Cr** |
| 👑 Top Employee | **Rahul Sharma — ₹4.82 Cr** |
| 💎 Top Product | **Enterprise ERP Suite — ₹12.45 Cr** |
| 🔄 Repeat Customer Revenue | **64.96% of total** |
| 📣 Best Lead Channel | **Referral — 48.9% conversion** |
| ⚠️ Revenue at Risk | **₹2.28 Cr unpaid (37 orders)** |
| 📦 Dead Stock Products | **2 products never sold** |
| 📅 Worst Revenue Month | **March 2024 (−24% MoM)** |

---

## 📄 Documentation

The full **documentary PDF report** is included in this repository. It contains:

- 📌 Complete ER diagram
- 💻 Every SQL query with syntax-highlighted code blocks
- 📋 Sample output tables for all 50+ queries
- 📖 Chapter-by-chapter storytelling narrative
- 🧠 Business insight annotations

> **[📥 Download Documentary Report](./IT_Sales_SQL_Documentary_Report.pdf)**

---

## 🌐 Connect

<div align="center">

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Santanu%20Pathak-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/santanu-pathak)
[![GitHub](https://img.shields.io/badge/GitHub-santanu--pathak-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/santanu-pathak)
[![Email](https://img.shields.io/badge/Email-Contact%20Me-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:santanu@email.com)

</div>

---

<div align="center">

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:00B4D8,50:0077B6,100:0D1B2A&height=120&section=footer&text=Prepared%20by%20Santanu%20Pathak%20%7C%2025%20April%202026&fontSize=14&fontColor=ffffff&fontAlignY=65"/>

</div>
