CREATE database Sales_db;
use Sales_db;
select *from details;
select * from orders;

select count(*) from details;
select count(*) from orders;

 select distinct Category  from details;
select count(distinct Category) as total_category from details;

select Category ,count(*) as Total_sales
 from details
 group by Category;
 
-- Total Amount 
select sum(Amount) as total_of_Amount from details;

-- Total sum of Quantity
select sum(Quantity) as Sum_of_Quantity from details;

-- Total Profit
select sum(Profit) as Sum_of_Profit from details;

-- SUM OF AMOUNT BY CATEGORY
select Category, sum(Amount) as total_amount
  from details
  group by Category
  order by sum(Amount) desc;
  
  -- SUM OF PROFIT BY CATEGORY
  select Category,sum(Profit) as total_profit
   from details
   group by Category 
   order by sum(Profit) desc;
   
  --  SUM OF QUANTITY BY CATEGORY
  
  select Category, sum(Quantity) as total_quantity
  from details
  group by Category
  order by sum(Quantity) desc;


-- Total sub-category
select distinct "Sub-Category" from details;
  -- group by 'Sub-Category'
--   order by count('Sub-Category') desc;
--   
  
 -- sum of Amount by sub-category-- 
SELECT DISTINCT `Sub-Category`
FROM details;

-- count the number of distinct sub-category
SELECT count(DISTINCT `Sub-Category`) as total_sub_category
FROM details;

-- total amount by sub_category
select `Sub-Category`,sum(Amount)
 from details
  group by `Sub-Category`
  order by sum(Amount) desc
  limit 5;
  
  -- Average amount per sub_category
       select `Sub-Category`,avg(Amount) as Average_amount
        from details
         group by `Sub-Category`
         order by avg(Amount) desc;
         
         
  -- Total Profit by sub_category
  select `Sub-Category`,sum(Profit)
   from details
     group by `Sub-Category`
     order by sum(Profit) desc
     limit 5;
     
    --  Total Quantity by sub-category
    select `Sub-Category`,sum(Quantity)
      from details
       group by `Sub-Category`
       order by sum(Quantity) desc
       limit 5;
       
    -- Distinct  PaymentMode  
    select  distinct PaymentMode from details;
    -- Total distinct paymentmode
    select count(distinct PaymentMode) as distinct_paymentmode from details;
    
   --  Which payment mode is used most frequently, and how many times was each payment mode used?
    select PaymentMode,count(*) as total_use
     from details
     group by PaymentMode
     order by count(*) desc;
     
   --   Count transactions for each Category and PaymentMode, grouped by both and ordered by count
    select Category,PaymentMode,count(*)
     from details
     group by Category,PaymentMode
     order by count(*) desc;
     
     --  ORDERS_TABLE
     
     -- list of  distinct customer
     select distinct CustomerName from orders;
     -- count of distinct customer
     select count(distinct CustomerName) from orders;
    --  LIST ALL THE DISTINCT STATE
    select distinct State from orders;
    -- COUNT ALL THE DISTINCT STATE
    select count(distinct State) from orders;

 --  LIST ALL THE DISTINCT CITY
    select distinct City from orders;
    -- COUNT ALL THE DISTINCT CITY
    select count(distinct City) from orders;
     
     
     -- Find the top 5 states with the most customers, showing state and total customer count.
     select State,count(CustomerName) as Total_customer
	 from orders
	 group by State
	 order by count(CustomerName) desc
	 limit 5;
        
	--  Find the top 5 cities with the most customers, showing city and total customer count.
	select City,count(CustomerName) as Total_customer
	from orders
	group by City
	order by count(CustomerName) desc
	limit 5;
    
        
        
          -- JOIN  ON DETAILS AND ORDER TABLES
          
--  Top 5 state by amount 
          
SELECT o.State, SUM(d.Amount) AS total_amount
FROM details AS d
RIGHT JOIN orders AS o
    ON d.`Order ID` = o.`Order ID`
GROUP BY o.State
order by sum(d.Amount) desc
limit 5;

            
-- TOP 5 CITY BY AMOUNT 
        
 select o.City ,SUM(d.Amount) AS total_amount
  from details as d
  right join orders as o
   ON d.`Order ID` = o.`Order ID`
   GROUP BY o.City
order by sum(d.Amount) desc
limit 5;
            
-- top 10 customer by amount            
            
    select o.CustomerName ,SUM(d.Amount) AS total_amount
  from details as d
  right join orders as o
   ON d.`Order ID` = o.`Order ID`
   GROUP BY o.CustomerName
order by sum(d.Amount) desc
limit 10;   

                        --    WINDOW FUNCTION 
--  top 5 sub-category product in each category    

SELECT 
    Category,



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




WITH sub_totals AS (
    SELECT 
        Category,
        `Sub-Category`,
        SUM(Amount) AS TotalAmount
    FROM details
    GROUP BY Category, `Sub-Category`
),
ranked AS (
    SELECT 
        Category,
        `Sub-Category`,
        TotalAmount,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY TotalAmount DESC) AS rn
    FROM sub_totals
)
SELECT Category, `Sub-Category`, TotalAmount
FROM ranked
WHERE rn <= 1;

   
            
            