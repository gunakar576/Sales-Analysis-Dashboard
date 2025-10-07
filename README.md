#Sales Analysis Dashboard using  Power BI & SQL

## 📊 Project Overview
This project leverages **SQL queries** for comprehensive sales analysis and visualizes insights using **Power BI dashboards**. It focuses on evaluating performance across **categories, sub-categories, payment methods, cities, states, and customer segments**.

The project is structured into five key sections:
1. Category Analysis
2. Sub-Category Analysis
3. Payment Mode Analysis
4. City & State Analysis
5. Joined/Combined Analysis (Profit, Sales, Customers)

## 📂 Dataset Description
- **Orders Table:** Order ID, Customer Name, City, State, Order Date
- **Details Table:** Order ID, Category, Sub-Category, Quantity, Amount, Profit, Payment Mode

Tables are linked using `Order ID` for combined analysis.

## ⚙️ Tools Used
- **SQL** – Data extraction and aggregation
- **Power BI** – Data visualization and reporting
- **GitHub** – Version control and documentation

---

## 🔎 Part 1: Category Analysis
### SQL Queries
```sql
-- Calculate Total Sales Amount by Category
SELECT Category, SUM(Amount) AS Total_Amount
FROM details
GROUP BY Category;

-- Calculate Total Quantity Sold by Category
SELECT Category, SUM(Quantity) AS Total_Quantity
FROM details
GROUP BY Category;

-- Calculate Total Profit by Category
SELECT Category, SUM(Profit) AS Total_Profit
FROM details
GROUP BY Category;

-- Count Total Orders by Category
SELECT Category, COUNT(DISTINCT [Order ID]) AS Total_Orders
FROM details
GROUP BY Category;
```
### Insights & Business Implications
- **Electronics**: Highest revenue contributor, suggesting a strong market demand.  
- **Clothing**: Largest number of units sold and orders; indicates high customer preference.  
- **Furniture**: Lowest performance; requires targeted marketing and promotions.  
- **Action Points**: Optimize Electronics supply chain, strengthen customer loyalty in Clothing, and develop cross-selling strategies for Furniture.

---

## 🔎 Part 2: Sub-Category Analysis
### SQL Queries
```sql
-- List all unique Sub-Categories
SELECT DISTINCT Sub-Category FROM details;

-- Count total Sub-Categories
SELECT COUNT(DISTINCT Sub-Category) AS total_sub_category FROM details;

-- Top 5 Sub-Categories by Quantity Sold
SELECT Sub-Category, SUM(Quantity) AS Total_Quantity
FROM details
GROUP BY Sub-Category
ORDER BY SUM(Quantity) DESC
LIMIT 5;

-- Top 5 Sub-Categories by Sales Amount
SELECT Sub-Category, SUM(Amount) AS Total_Amount
FROM details
GROUP BY Sub-Category
ORDER BY SUM(Amount) DESC
LIMIT 5;

-- Top 5 Sub-Categories by Profit
SELECT Sub-Category, SUM(Profit) AS Total_Profit
FROM details
GROUP BY Sub-Category
ORDER BY SUM(Profit) DESC
LIMIT 5;
```
### Insights & Business Implications
- High-volume sub-categories: **Saree, Handkerchief, Stole** – opportunities for promotions and bundling.  
- High-profit sub-categories: **Printers, Bookcases** – focus on premium product marketing.  
- **Strategy**: Balance high-volume and high-margin products, optimize inventory, and enhance cross-category sales.

---

## 🔎 Part 3: Payment Mode Analysis
### SQL Queries
```sql
-- List all payment modes
SELECT DISTINCT PaymentMode FROM details;

-- Count distinct payment modes
SELECT COUNT(DISTINCT PaymentMode) AS distinct_paymentmode FROM details;

-- Total Quantity Sold per Payment Mode
SELECT PaymentMode, SUM(Quantity) AS Total_Quantity
FROM details
GROUP BY PaymentMode;

-- Total Transactions per Payment Mode
SELECT PaymentMode, COUNT(*) AS Total_Transactions
FROM details
GROUP BY PaymentMode
ORDER BY COUNT(*) DESC;

-- Category-wise Payment Mode Distribution
SELECT Category, PaymentMode, COUNT(*) AS Transactions
FROM details
GROUP BY Category, PaymentMode
ORDER BY COUNT(*) DESC;

-- Top 2 Sub-Categories per Category by Sales Amount
SELECT * FROM (
  SELECT Category, Sub-Category, SUM(Amount) AS Total_Amount,
         DENSE_RANK() OVER (PARTITION BY Category ORDER BY SUM(Amount) DESC) AS Rank
  FROM details
  GROUP BY Category, Sub-Category
) t
WHERE Rank <= 2;
```
### Insights & Business Implications
- **COD** dominates transactions and quantity sold.  
- **UPI & Debit Card** show growing digital adoption.  
- **EMI** is used selectively for high-value purchases.  
- **Action Points**: Improve COD logistics, encourage digital payment adoption, and market EMI options for premium products.

---

## 🔎 Part 4: City & State Analysis
### SQL Queries
```sql
-- Count of unique customers
SELECT COUNT(DISTINCT CustomerName) FROM orders;

-- List all unique states
SELECT DISTINCT State FROM orders;

-- Count of distinct states
SELECT COUNT(DISTINCT State) FROM orders;

-- List all unique cities
SELECT DISTINCT City FROM orders;

-- Count of distinct cities
SELECT COUNT(DISTINCT City) FROM orders;

-- Top 5 Cities by Total Orders
SELECT City, COUNT(*) AS Total_Orders_Per_City
FROM orders
GROUP BY City
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Top 5 States by Total Orders
SELECT State, COUNT(*) AS Total_Orders_Per_State
FROM orders
GROUP BY State
ORDER BY COUNT(*) DESC
LIMIT 5;
```
### Insights & Business Implications
- 336 unique customers across 25 cities and 19 states.  
- High-order states: **Maharashtra, Madhya Pradesh** – key for inventory planning and marketing focus.  
- **Action Points**: Allocate resources strategically to top-performing regions and plan city-level promotional campaigns.

---

## 🔎 Part 5: Joined/Combined Analysis
### SQL Queries
```sql
-- Monthly Profit Analysis
SELECT MONTH(STR_TO_DATE(o.`Order Date`, '%d-%m-%Y')) AS Month_Number,
       MONTHNAME(STR_TO_DATE(o.`Order Date`, '%d-%m-%Y')) AS Month_Name,
       SUM(d.Profit) AS Total_Profit
FROM orders o
INNER JOIN details d ON o.`Order ID` = d.`Order ID`
GROUP BY MONTH(STR_TO_DATE(o.`Order Date`, '%d-%m-%Y')),
         MONTHNAME(STR_TO_DATE(o.`Order Date`, '%d-%m-%Y'))
ORDER BY Month_Number;

-- Top 5 Cities by Profit
SELECT o.City, SUM(d.Profit) AS Total_Profit
FROM details d
RIGHT JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.City
ORDER BY SUM(d.Profit) DESC
LIMIT 5;

-- Top 5 States by Profit
SELECT o.State, SUM(d.Profit) AS Total_Profit
FROM details d
RIGHT JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.State
ORDER BY SUM(d.Profit) DESC
LIMIT 5;

-- Top 10 Customers by Purchase Amount
SELECT o.CustomerName, SUM(d.Amount) AS Total_Amount
FROM details d
RIGHT JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.CustomerName
ORDER BY SUM(d.Amount) DESC
LIMIT 10;

-- Top 5 Cities by Sales Amount
SELECT o.City, SUM(d.Amount) AS Total_Amount
FROM details d
RIGHT JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.City
ORDER BY SUM(d.Amount) DESC
LIMIT 5;

-- Top 5 States by Sales Amount
SELECT o.State, SUM(d.Amount) AS Total_Amount
FROM details d
RIGHT JOIN orders o ON d.`Order ID` = o.`Order ID`
GROUP BY o.State
ORDER BY SUM(d.Amount) DESC
LIMIT 5;
```
### Insights & Business Implications
- Profits peak in **November & January**; losses observed in May.  
- High-profit cities: **Indore, Pune**; high-profit states: **Madhya Pradesh, Maharashtra**.  
- Top customers: **Harivansh, Madhav** – opportunities for loyalty programs.  
- **Action Points**: Plan seasonal promotions, implement customer retention strategies, and target resources to high-revenue regions.

---

## 💎 Final Business Conclusion
- **Electronics**: Revenue backbone.  
- **Clothing**: Strong customer loyalty and high order frequency.  
- **Furniture**: Requires targeted strategies to boost performance.  
- **COD**: Preferred payment mode; digital payments increasing.  
- **Key Regions**: Maharashtra & Madhya Pradesh.  
- Seasonal trends and top customers are critical for planning.

## 🚀 Future Recommendations
- Implement predictive analytics for seasonal demand forecasting.  
- Develop customer segmentation and churn analysis models.  
- Enhance Power BI dashboards with interactive and drill-down capabilities.


