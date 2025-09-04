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
