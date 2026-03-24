
--total profit margin....done
select 
count (DISTINCT order_id)  as total_orders, 
round (sum(sales), 2) as total_sales,
round(sum(profit), 2) as total_profit,
round(sum(profit)/sum(sales)*100 , 2) as profit_margin
from superstore_db;

--•	Calculate total sales and profit, Profit margin, total orders with time...done
select 
year(order_date) as Year,
month(order_date) as Month,
count(distinct(order_id)) as Orders, 
SUM(sales) as total_sales,
SUM(profit) as total_profit,
round(sum(profit)/sum(sales)*  100, 2)as profit_margin, 
category
from superstore_db
group by category, year(order_date),
month(order_date);

--total sales and profit by regions / regions which sales underperform
select 
	Region,
	state,
	category, 
	Sub_Category,
	sum(sales) as total_sales,
	sum(profit) as total_profit
from superstore_db
group by  Region, state, Category,Sub_Category
order by region;

--discounts brought no profit, or by region , subcatagory
SELECT
  Region, 
  category,
  Sub_Category,
  discount,
  ROUND(sum(profit), 2) AS total_Profit,
  SUM(Sales) as total_sales ,
  COUNT(distinct Order_ID) AS Total_Orders
FROM superstore_db
GROUP BY region, Category,Sub_Category, discount;


