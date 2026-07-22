select * from pizza_sales;
use [Pizza DB];

-- Total revenue
select sum(total_price) as Total_Revenue from pizza_sales

-- Average Order Value
select (sum(total_price)/count(distinct order_id)) as Avg_Order_Value from pizza_sales

-- Total Pizzas Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales

-- Total Orders
select count(distinct order_id) as Total_orders from pizza_sales

-- Average pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_Per_order from pizza_sales

-- Daily Trend for Total Orders
select DATENAME(dw,order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(dw,order_date)

-- Hourly Trend for Total Orders
select DATEPART(hour,order_time) as order_hours, count(distinct order_id) as Total_orders
from pizza_sales
group by DATEPART(hour,order_time)
order by DATEPART(hour,order_time)

-- Percentage of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

-- % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- Top 5 Best Sellers by Total Pizzas Sold
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-- Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

