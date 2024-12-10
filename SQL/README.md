# E-commerce Sales Analysis

## Overview
This project analyzes an e-commerce dataset using SQL to uncover insights into customer behavior, sales trends, and product performance. By querying the dataset, we generate actionable metrics, such as top-selling products and valuable customers, to aid in decision-making and business optimization.
## Objectives
- **Understand Customer Behavior** - Analyze customer purchasing patterns, segment customers based on their activities, and identify the most valuable customers.

- **Evaluate Product Performance** - Determine top-selling products, analyze product categories, and assess the contribution of each product to overall revenue.

- **Analyze Sales Trends** - Examine seasonal and monthly sales patterns to identify peak periods and improve forecasting accuracy.

- **Track Key Business Metrics** - Calculate key metrics like average order value (AOV), total revenue, and order frequency for informed decision-making.
## Tools and Technologies
- Database Management System:  PostgreSQL
- Query Language: SQL
- Dataset Source : [E-commerce Sales](https://www.kaggle.com/datasets/ayushparwal2026/online-ecommerce)
## SQL Querry Overview
1. ### **Database Structure and Setup**
```
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
```
- Primary Key: *Order_Number* Uniquely identifies each order, preventing duplicates.
- Geographic Info: *State_Code* Tracks the state for regional sales analysis.
- Customer and Order Details  :
  1. *Customer_Name*: Identifies the customer.
  2. *Order_Date & Status*: Capture the order date and its current state (e.g., completed, canceled).
- Product Information :
  1. *Product*, *Category*, and *Brand*: Describe the purchased item, essential for product and category insights.
- Cost and Sales Metrics : Includes *Cost*, *Sales*, *Quantity*, *Total_Cost*, and *Total_Sales* for financial and performance analysis.

2. ### **Database Exploration**
```
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
```
- *Missing Data Check* : This query identifies rows with any NULL values across all columns, ensuring data completeness.
```
SELECT COUNT(*) FROM ecommerce;
```
- *Total Records* : It counts the total number of rows in the table, providing an overview of dataset size.
```
SELECT COUNT(DISTINCT product)
FROM eommerce;
```
- *Unique Products* : It calculates the number of distinct products in the dataset, helping understand product diversity.
```
SELECT SUM(total_sales) AS sales_tot , 
		SUM(quantity) AS total_quantity
FROM ecommerce;
```
- *Sales and Quantity Summary* : This query computes total sales and total quantity sold, providing key metrics for overall performance evaluation.

3. ### **Data Analysis Overview**
- *Top 10 Most Sold Products* : Identifies the top 10 products based on total quantity sold, providing insights into popular products.
```
SELECT product , 
		SUM(quantity) AS total_quantity
FROM ecommerce
GROUP BY product
ORDER BY total_quantity DESC
LIMIT 10;
```
- *Count of Orders with Status Not Delivered* : Counts orders with statuses 'Processing' and 'Shipped', helping track pending deliveries.
```
SELECT status, 
    COUNT(*) AS status_count
FROM ecommerce
WHERE status 
	IN ('Processing', 'Shipped')
GROUP BY status;
```
- *Total Sales Per State* : Calculates total sales for each state, offering a geographical view of sales performance
```
SELECT state_code,
	SUM(total_sales) as sales
FROM ecommerce
	GROUP BY state_code
	ORDER BY SALES DESC;
```
- *Average Quantity Sold Per Category* : Computes the average quantity sold per product category, highlighting trends in product demand.
```
SELECT category , ROUND(AVG(quantity),2) as avg_quantity
FROM ecommerce
GROUP BY category
ORDER BY avg_quantity DESC;
```
- *Total Sales for Each Month* : Summarizes monthly sales data, allowing for trend analysis over time.
```
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
```
- *Average Sales Per Month and Best-Selling Month* : Finds the average sales per month and identifies the best-selling month each year
  
```
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
```
- *Total Quantity Sold by Assigned Supervisor* : Tracks total quantity sold by each supervisor, helping assess performance and responsibility distribution.
```
SELECT assigned_supervisor ,
	SUM(quantity) AS total_quantity
FROM ecommerce
	GROUP BY assigned_supervisor
	ORDER BY total_quantity DESC;
```
- *Most Sold Product Per Brand* : Identifies the best-selling product within each brand, useful for brand-level analysis.

```
SELECT product,brand,total_quantity
	FROM(SELECT product , brand ,
		SUM(QUANTITY) AS total_quantity,  
			ROW_NUMBER() OVER(PARTITION BY brand ORDER BY SUM(QUANTITY)DESC) AS rank
		FROM ecommerce
		GROUP BY 1,2 ) AS a
WHERE rank = 1
ORDER BY total_quantity DESC ;
```
- *Top 10 Customers by Average Spend* : Ranks customers by average spending, helping identify high-value customers.
```
SELECT customer_name,ROUND(AVG(amount_spent)) AS avg_amount
	FROM( 
SELECT order_number,customer_name,
		SUM(total_sales) AS amount_spent
FROM ecommerce
GROUP BY order_number,customer_name
) AS customer
GROUP BY 1
ORDER BY avg_amount DESC
LIMIT 10 ;
```
- *Unique Customers Per Category* : Counts the number of unique customers who purchased from each category, providing insights into customer engagement with different categories.
```
SELECT category,
	COUNT(DISTINCT order_number ) AS count_cus
FROM ecommerce
GROUP BY category
```
## Data Analysis Insights 
- **Top Products and Sales Trends**
The analysis of the top 10 most sold products and monthly sales trends shows that products like "2GB Graphic Card" with 791 units sold, followed by "26 LCD Display" with 402 units are in high demand.  This trend highlights a strong customer preference for computer hardware and accessories, particularly in the gaming and tech categories.

- **Order Fulfillment and Status**
The order fulfillment status analysis reveals a near-equal distribution between orders marked as "Shipped" (1273) and those still "Processing" (1278). It highlights the need for better tracking or improvement in delivery times to optimize customer satisfaction and operational efficiency.

- **Regional and Category Performance**
The sales data highlights that Maharashtra (MH) leads with the highest sales at 17.6 million, followed by Uttar Pradesh (UP) (9.26 million) and Gujarat (GJ) (9.14 million). These regions show strong market demand, indicating higher customer engagement. The disparity in sales suggests that targeted marketing efforts could boost performance in regions with lower sales

- **Customer Engagement and Spending**
The top 10 customers based on average spend and the number of unique customers per category indicate strong customer loyalty and engagement. Binod Kumar leads with the highest average spending of ₹65,260, indicating strong customer loyalty and high engagement. Their consistent purchases highlight the importance of retaining high-value customers for continued revenue growth.

- **Supervisor and Brand Insights**
Analysis of total quantity sold by assigned supervisors reveals performance disparities, with certain supervisors handling higher sales volumes. Aarvi Gupta leads with 2362 units sold, followed by Ajay Sharma with 2304. These top supervisors are key contributors to sales, highlighting their effective strategies and strong performance.

## Conclusion
This project provided valuable insights into the e-commerce dataset through SQL queries, revealing key trends in product sales, order fulfillment, and customer behavior. The analysis highlighted the most popular products, regions with high sales, and the performance of supervisors in driving sales. By examining customer spending patterns, the project also offered insights into customer loyalty and potential areas for growth. These findings enable businesses to refine their sales strategies, enhance customer satisfaction, and improve operational efficiency for better overall performance.







