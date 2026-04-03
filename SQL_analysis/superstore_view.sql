
--View 1 total sales report , orders , profit , and margin profit....done
create view vs_revenue_overview as 
select 
count (DISTINCT order_id)  as total_orders, 
round (sum(sales), 2) as total_sales,
round(sum(profit), 2) as total_profit,
round(sum(profit)/sum(sales)*100 , 2) as profit_margin
from superstore_db;

--view 2 sales over time and by category.... done
create view vs_time_trend as 
select 
year(order_date) as Year,
month(order_date) as Month,
count(distinct order_id) as Orders, 
SUM(sales) as total_sales,
SUM(profit) as total_profit,
category
from superstore_db
group by year(order_date),month(order_date),category;

--View 3 Sales and profit by regions states/ regions which sales underperform and higher perform region
create view vs_regionalandcategorial_revenue as 
select 
	Region,
	state,category, sub_category,
	sum(sales) as total_sales,
	sum(profit) as total_profit
from superstore_db
group by  Region, state, category,sub_category;

--View 4 Profits incomparison to discounts, region 
CREATE VIEW vs_profitablity_discount_metrics AS
SELECT
  Region, 
  category,
  Sub_Category,
  discount,-- change to percentage for dashbaord on powerbi 
  ROUND(sum(profit), 2) AS total_Profit,
  -- SUM(PROFIT) / SUM(SALES)* 100 AS PROFIT_MARGIN_PCT i have created a measure on my powerBI instead
  SUM(Sales) as total_sales ,
  COUNT(distinct Order_ID) AS Total_Orders
FROM superstore_db
GROUP BY region, Category,Sub_Category, discount;
