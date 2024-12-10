-- Create table as ecommerce
CREATE TABLE ecommerce(
	Order_Number INT PRIMARY KEY , State_Code VARCHAR(5),
	Customer_Name VARCHAR(64) , Order_Date	DATE,
	Status VARCHAR(32) , Product	VARCHAR(75),
	Category VARCHAR(64) , Brand VARCHAR(64),
	Cost FLOAT , Sales FLOAT,
	Quantity INT , Total_Cost FLOAT,
	Total_Sales FLOAT , Assigned_Supervisor VARCHAR(64)
);

SELECT * FROM ecommerce
LIMIT 100;

--Data Exploration
SELECT * FROM ecommerce
WHERE Order_Number	IS NULL 
	OR  State_Code	IS NULL
	OR  Customer_Name IS NULL
	OR  Order_Date	IS NULL
	OR  Status	IS NULL
	OR  Product IS NULL
	OR  Category IS NULL
	OR  Brand	IS NULL
	OR  Cost IS NULL  
	OR  Sales IS NULL
	OR  Quantity IS NULL
	OR   Total_Cost IS NULL
	OR   Total_Sales IS NULL
	OR   Assigned_Supervisor IS NULL ;

SELECT COUNT(*) FROM ecommerce;

SELECT COUNT(DISTINCT product)
FROM eommerce;

SELECT SUM(total_sales) AS sales_tot , 
		SUM(quantity) AS total_quantity
FROM ecommerce;

-- Data Analysis
---- Top 10 Most sold product
SELECT product , 
		SUM(quantity) AS total_quantity
FROM ecommerce
GROUP BY product
ORDER BY total_quantity DESC
LIMIT 10;

---- Count of order status where not delivered 
SELECT status, 
    COUNT(*) AS status_count
FROM ecommerce
WHERE status 
	IN ('Processing', 'Shipped')
GROUP BY status;

----Sum of total sales per category
SELECT state_code,
	SUM(total_sales) as sales
FROM ecommerce
	GROUP BY state_code
	ORDER BY SALES DESC;

----Average Quantity Sold per Category
SELECT category , ROUND(AVG(quantity),2) as avg_quantity
FROM ecommerce
GROUP BY category
ORDER BY avg_quantity DESC;

----Total Sales for each month 
SELECT state_code,category,
	EXTRACT(MONTH FROM order_date) AS month,
	EXTRACT(YEAR FROM order_date) AS year,
	SUM(total_sales) AS monthly_sales
FROM ecommerce
	GROUP BY state_code,
	category,
	EXTRACT(YEAR FROM order_date),
	EXTRACT (MONTH FROM order_date)
	ORDER BY year,month ;

---- Average Sale for each Month and best selling month in each year
SELECT year,month,avg_sale
FROM (
SELECT 
	EXTRACT(YEAR FROM order_date) AS year,
	EXTRACT(MONTH FROM order_date) AS month,
	AVG(sales) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(MONTH FROM order_date) ORDER BY AVG(sales))
FROM ecommerce
GROUP BY 1,2) AS a
WHERE rank = 1
ORDER BY 1,2;

----Total quantity sold by assigned_supervisor
SELECT assigned_supervisor ,
	SUM(quantity) AS total_quantity
FROM ecommerce
	GROUP BY assigned_supervisor
	ORDER BY total_quantity DESC;
	
----Most sold product for each brand
SELECT product,brand,total_quantity
	FROM(SELECT product , brand ,
		SUM(QUANTITY) AS total_quantity,  
			ROW_NUMBER() OVER(PARTITION BY brand ORDER BY SUM(QUANTITY)DESC) AS rank
		FROM ecommerce
		GROUP BY 1,2 ) AS a
WHERE rank = 1
ORDER BY total_quantity DESC ;

----Top 10 Customers who spend average amount 
SELECT customer_name,ROUND(AVG(amount_spent)) AS avg_amount
	FROM( 
SELECT order_number,customer_name,
		SUM(total_sales) AS amount_spent
FROM ecommerce
GROUP BY order_number,customer_name
) AS customer
GROUP BY 1
ORDER BY avg_amount DESC
LIMIT 10

---- Number of unique customers who purchased items from each category
SELECT category,
	COUNT(DISTINCT order_number ) AS count_cus
FROM ecommerce
GROUP BY category





