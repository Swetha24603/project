# Amazon Kindle Books Dataset Analysis
## Overview
 Using Python, SQL, and Power BI, the project demonstrates the complete data analysis lifecycle, from data cleaning and exploration to querying and visualization. The project showcases the integration of SQL and Python for effective data manipulation and analysis.
## Objective
* **Understand the Dataset**: Explore the dataset’s structure and features to identify key attributes for analysis.
* **Data Exploration**: Use SQL queries to extract insights on trends, patterns, and relationships within the dataset.
* **Sales and Rating Analysis**: Investigate relationships between pricing, ratings, and sales rank.
* **Top Books and Authors**: Highlight best-performing books and authors based on ratings and reviews.
## Tools and Technologies
* *Database Management System*: PostgreSQL
* *Query Language*: SQL
## Query Overview
1. ### **Basic Exploration**:
* *Preview Data*: Displayed the first 10 rows.
```
SELECT * FROM amazon_book
LIMIT 10;
```
* *Row Count*: Calculated the total number of rows in the dataset .
```
SELECT COUNT(*) FROM amazon_book;
```
* *Unique Counts*: Counted distinct book titles and authors to analyze dataset uniqueness.
```
SELECT COUNT(DISTINCT title)
FROM amazon_book;
```
2. ### **Data Analysis**:
* *Bestseller Analysis*:
     * Calculated the average rating and reviews for bestselling books grouped by category.
```
SELECT category_name,
	"isBestSeller",
	ROUND(AVG(stars)::numeric,2) as avg_rating,
	ROUND(AVG(reviews)::numeric,2) as avg_reviews
FROM amazon_book
	WHERE "isBestSeller" = True
	GROUP BY 1,2
	ORDER BY avg_rating DESC;
```
   Extracted pricing statistics (average, minimum, and maximum) for bestsellers across categories.
```
SELECT category_name,
	"isBestSeller",
	ROUND(AVG(price)::numeric,2) as avg_price,
	ROUND(MIN(price)::numeric,2) as min_price,
	ROUND(MAX(price)::numeric,2) as max_price
FROM amazon_book
	WHERE "isBestSeller" = True
GROUP BY 1,2;
```
* *Genre Analysis Over Time*:Identified distinct genres and their associated ratings over different publication years.
```
SELECT DISTINCT category_name,
	published_year,
		genre_rating
FROM amazon_book
ORDER BY published_year DESC;
```
3. ### **Seller Performance**:
   Analyzed the total number of books sold by each seller to identify top contributors.
```
SELECT "soldBy",
		COUNT(*) as total_books
FROM amazon_book
	GROUP BY 1
	ORDER BY total_books DESC;
```
4. ### **Distribution Insights**:
   Explored the price distribution for bestseller books, breaking it down by category.
```
SELECT category_name,
		COUNT(*) AS total_books
FROM amazon_book
	WHERE "isGoodReadsChoice" = True
	GROUP BY 1
	ORDER BY total_books DESC;
```
5. ### **Detailed Ratings Trends**:
   Investigated the relationship between ratings, reviews, and sales ranks to identify trends.
```
SELECT DISTINCT category_name,
	CASE
		WHEN price < 15 THEN 'Under $15'
		WHEN price BETWEEN 15 AND 30 THEN '$15 to $30'
		WHEN price BETWEEN 30 AND 50 THEN '$30 to $50'
		ELSE 'Above $50'
	END as price_category,
	ROUND(AVG(stars)::numeric,2) AS avg_ratings
FROM amazon_book
	WHERE price > 0 AND stars > 0
	GROUP BY category_name,price_category
	ORDER BY avg_ratings DESC ;
```
6. ### **Top 25 Books by Reviews**:
   Identify the top 25 best-selling books ranked by the number of reviews.
```
WITH cte as(
	SELECT category_name,
			title,
			reviews,
			DENSE_RANK() OVER(ORDER BY reviews DESC) as rank  
	FROM amazon_book
	WHERE "isBestSeller" = True
)
SELECT category_name,
		title,
		reviews
from cte
WHERE rank <=25
ORDER BY reviews DESC;
```
7. ### **Books Rating and Price Trend by Quarter**:
   Analyze the average rating and price trends across quarterly periods.
```
SELECT published_month,
	CASE 
	 WHEN published_month IN (1,2,3) THEN 'Q1'   
	 WHEN published_month IN (4,5,6) THEN 'Q2'
	 WHEN published_month IN (7,8,9) THEN 'Q3'
	ELSE 'Q4'
	END AS Quarter,
	ROUND(AVG(price)::numeric,2) AS avg_price,
	ROUND(AVG(stars)::numeric,2) AS avg_rating
FROM amazon_book
WHERE published_month IS NOT NULL AND published_month != 0
GROUP BY 1
ORDER BY 1;
```
8. ### **Books Rating and Price Trend by Year**:
   Identify annual trends in ratings, prices, reviews, and total books published.
```
SELECT published_year,
    ROUND(AVG(price)::NUMERIC, 2) AS avg_price,
    ROUND(AVG(stars)::NUMERIC, 2) AS avg_rating,
	ROUND(AVG(reviews)::NUMERIC, 2) AS avg_reviews,
    COUNT(*) AS total_books
FROM amazon_book
WHERE published_year IS NOT NULL AND published_year != 0
GROUP BY published_year
ORDER BY published_year DESC;
```
9. ### **Correlation for Price and Ratings**:

   Analyze the relationship between book prices and their ratings to determine if higher prices are associated with better ratings (or vice versa).
```
SELECT CORR(price,stars) as correlation
FROM amazon_book
	WHERE price > 0 AND stars > 0;
```
## Conclusion
This project highlights the power of SQL in analyzing large datasets efficiently. By connecting the dataset to Python for data preprocessing and running SQL queries, 

* Discovered key trends in pricing and ratings across genres and authors.

* Identified customer preferences based on ratings and review counts.

* Prepared cleaned and structured data for visualization in Power BI.
 
