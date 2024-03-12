select * from orders;

--Write SQL queries to retrieve the total number of orders, customers, and products in the dataset.
SELECT COUNT(*) as total_number
FROM orders;

SELECT COUNT(DISTINCT "Customer ID") AS total_customers
FROM orders;

SELECT COUNT(DISTINCT "Product Category") AS total_products
FROM orders;

--•	Calculate and display the total sales, average discount, and profit for each product category.
--•	Order the results by total sales in descending order.
SELECT DISTINCT("Product Category") AS Product_category, SUM("Sales") AS Total_Sales, AVG("Discount") AS Average_Discount, AVG("Profit") AS Average_Profit
FROM orders
GROUP BY "Product Category"
ORDER BY Total_sales DESC;

--•	Identify the top 10 customers with the highest total sales.
SELECT "Customer Name" AS Customer_Name, SUM("Sales") AS Total_Sales
FROM orders
GROUP BY "Customer Name", "Sales"
ORDER BY "Sales" DESC
LIMIT 10;

--•	Calculate the average order value for each customer segment.
SELECT "Customer Segment" AS Customer_Segment, AVG("Sales") AS Average_Sales
FROM orders
GROUP BY "Customer Segment";

--•	Analyze the sales trend over time by displaying the monthly sales for each year in the dataset.
SELECT EXTRACT(YEAR FROM "Order Date") AS Year,
       EXTRACT(MONTH FROM "Order Date") AS Month,
       SUM("Sales") AS Monthly_Sales
FROM orders
GROUP BY EXTRACT(YEAR FROM "Order Date"), EXTRACT(MONTH FROM "Order Date")
ORDER BY Year, Month;

--•	Identify the month with the highest sales.
SELECT EXTRACT (MONTH from "Order Date") AS Month, SUM("Sales") AS Total_Sales
FROM orders
GROUP BY EXTRACT (MONTH from "Order Date")
ORDER BY Total_Sales DESC
LIMIT 1;

--•	Determine the top 5 best-selling products based on the quantity sold.
SELECT DISTINCT("Product Sub-Category") AS Products, SUM("Quantity ordered new") AS Quantity_Sold
FROM orders
GROUP BY DISTINCT("Product Sub-Category")
ORDER BY Quantity_Sold DESC
LIMIT 5;

--•	Calculate the profit margin for each product and display the results.
SELECT "Product Sub-Category" AS Products, 
       (SUM("Profit") / SUM("Sales")) * 100 AS Profit_Margin
FROM orders
GROUP BY "Product Sub-Category"
ORDER BY Profit_Margin; 

--•	Analyze the impact of discounts on sales and profit.
SELECT "Product Category", AVG("Discount") AS Average_Discount, AVG("Sales") AS Average_Sales, AVG("Profit") AS Average_Profit,  AVG("Profit") - AVG("Profit") * AVG("Discount") AS Impact_on_Profit
FROM orders
GROUP BY "Product Category"
ORDER BY Impact_on_Profit DESC;

--•	Calculate the average discount for each product category.
SELECT DISTINCT("Product Sub-Category") AS Products, AVG("Discount") AS Average_Discount
FROM orders
GROUP BY DISTINCT("Product Sub-Category")
ORDER BY Average_Discount DESC;

--•	Create a segmentation analysis by dividing customers into different groups based on their total purchases.
--•	Provide insights into the characteristics of each customer group.

WITH customer_purchases AS (
    SELECT
        "Customer ID",
        SUM("Sales") AS total_purchases
    FROM
        orders
    GROUP BY
        "Customer ID"
)
SELECT
    CASE
        WHEN total_purchases >= 1000 THEN 'High Spenders'
        WHEN total_purchases >= 500 AND total_purchases < 1000 THEN 'Medium Spenders'
        ELSE 'Low Spenders'
    END AS customer_group,
    COUNT(*) AS num_customers,
    AVG(total_purchases) AS avg_purchases
FROM
    customer_purchases
GROUP BY
    customer_group;

