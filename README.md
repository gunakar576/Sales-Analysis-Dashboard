# 📊 E-Commerce Sales Analysis (SQL + Power BI)

## 📌 Project Overview
This project analyzes **E-commerce sales data** using **SQL** for querying and **Power BI** for visualization.  
The goal is to identify key sales trends, customer insights, and profitability metrics that can help improve decision-making.

---

## 🛠 Tech Stack
- **SQL (MySQL/PostgreSQL/SQL Server)** → Data exploration, aggregation, joins, and business queries  
- **Power BI** → Interactive dashboard with KPIs, charts, and filters  

---

## 🗄 Database Details
The project uses two main tables:  

- **`details`** → Transaction details  
  - Columns: Order ID, Category, Sub-Category, Amount, Quantity, Profit, Payment Mode  
- **`orders`** → Customer orders  
  - Columns: Order ID, CustomerName, State, City  

---

## 🧑‍💻 SQL Analysis
Key queries written in SQL include:  

- **Basic Counts**
```sql
SELECT COUNT(*) FROM details;
SELECT COUNT(*) FROM orders;

-- Create database
CREATE DATABASE Sales_db;
USE Sales_db;

-- View all data
SELECT * FROM details;
SELECT * FROM orders;

-- Count records
SELECT COUNT(*) FROM details;
SELECT COUNT(*) FROM orders;

-- Distinct categories
SELECT DISTINCT Category FROM details;
SELECT COUNT(DISTINCT Category) AS total_category FROM details;

-- Sales by category
SELECT Category, COUNT(*) AS Total_sales
FROM details
GROUP BY Category;

-- Total Amount
SELECT SUM(Amount) AS total_of_Amount FROM details;

-- Total Quantity
SELECT SUM(Quantity) AS Sum_of_Quantity FROM details;

-- Total Profit
SELECT SUM(Profit) AS Sum_of_Profit FROM details;

-- Amount by Category
SELECT Category, SUM(Amount) AS total_amount
FROM details
GROUP BY Category
ORDER BY total_amount DESC;

-- Profit by Category
SELECT Category, SUM(Profit) AS total_profit
FROM details
GROUP BY Category
ORDER BY total_profit DESC;

-- Quantity by Category
SELECT Category, SUM(Quantity) AS total_quantity
FROM details
GROUP BY Category
ORDER BY total_quantity DESC;

-- Distinct Sub-Category
SELECT DISTINCT `Sub-Category` FROM details;
SELECT COUNT(DISTINCT `Sub-Category`) AS total_sub_category FROM details;

-- Amount by Sub-Category (Top 5)
SELECT `Sub-Category`, SUM(Amount) AS total_amount
FROM details
GROUP BY `Sub-Category`
ORDER BY total_amount DESC
LIMIT 5;

-- Average Amount per Sub-Category
SELECT `Sub-Category`, AVG(Amount) AS Average_amount
FROM details
GROUP BY `Sub-Category`
ORDER BY Average_amount DESC;

-- Profit by Sub-Category (Top 5)
SELECT `Sub-Category`, SUM(Profit) AS total_profit
FROM details
GROUP BY `Sub-Category`
ORDER BY total_profit DESC
LIMIT 5;

-- Quantity by Sub-Category (Top 5)
SELECT `Sub-Category`, SUM(Quantity) AS total_quantity
FROM details
GROUP BY `Sub-Category`
ORDER BY total_quantity DESC
LIMIT 5;

-- Payment Modes
SELECT DISTINCT PaymentMode FROM details;
SELECT COUNT(DISTINCT PaymentMode) AS distinct_paymentmode FROM details;

-- Most used payment modes
SELECT PaymentMode, COUNT(*) AS total_use
FROM details
GROUP BY PaymentMode
ORDER BY total_use DESC;

-- Transactions by Category & PaymentMode
SELECT Category, PaymentMode, COUNT(*) AS total_use
FROM details
GROUP BY Category, PaymentMode
ORDER BY total_use DESC;

-- Distinct Customers, States, Cities
SELECT COUNT(DISTINCT CustomerName) FROM orders;
SELECT COUNT(DISTINCT State) FROM orders;
SELECT COUNT(DISTINCT City) FROM orders;

-- Top 5 States by customers
SELECT State, COUNT(CustomerName) AS Total_customer
FROM orders
GROUP BY State
ORDER BY Total_customer DESC
LIMIT 5;

-- Top 5 Cities by customers
SELECT City, COUNT(CustomerName) AS Total_customer
FROM orders
GROUP BY City
ORDER BY Total_customer DESC
LIMIT 5;

-- Top 5 States by Amount
SELECT o.State, SUM(d.Amount) AS total_amount
FROM details d
JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.State
ORDER BY total_amount DESC
LIMIT 5;

-- Top 5 Cities by Amount
SELECT o.City, SUM(d.Amount) AS total_amount
FROM details d
JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.City
ORDER BY total_amount DESC
LIMIT 5;

-- Top 10 Customers by Amount
SELECT o.CustomerName, SUM(d.Amount) AS total_amount
FROM details d
JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.CustomerName
ORDER BY total_amount DESC
LIMIT 10;

-- Window Function: Top 2 Sub-Categories by Amount in each Category
SELECT *
FROM (
    SELECT 
        Category,
        `Sub-Category`,
        SUM(Amount) AS total_amount,
        DENSE_RANK() OVER (PARTITION BY Category ORDER BY SUM(Amount) DESC) AS rnk
    FROM details
    GROUP BY Category, `Sub-Category`
) t
WHERE rnk <= 2;

-- Records per Category & Sub-Category
SELECT Category, `Sub-Category`, COUNT(*) AS total_records
FROM details
GROUP BY Category, `Sub-Category`
ORDER BY Category;


