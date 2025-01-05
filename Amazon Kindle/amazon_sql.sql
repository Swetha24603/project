SELECT * FROM amazon_book
LIMIT 10;

-- Total No of Rows
SELECT COUNT(*) FROM amazon_book;

-- Count of Distinct titles
SELECT COUNT(DISTINCT title)
FROM amazon_book;

-- Total Authors
SELECT COUNT(DISTINCT author)
FROM amazon_book;

-- Data Analysis
-- Average rating and reviews for best seller books
SELECT category_name,
	"isBestSeller",
	ROUND(AVG(stars)::numeric,2) as avg_rating,
	ROUND(AVG(reviews)::numeric,2) as avg_reviews
FROM amazon_book
	WHERE "isBestSeller" = True
	GROUP BY 1,2
	ORDER BY avg_rating DESC;

-- Price Distribution for best selling books
SELECT category_name,
	"isBestSeller",
	ROUND(AVG(price)::numeric,2) as avg_price,
	ROUND(MIN(price)::numeric,2) as min_price,
	ROUND(MAX(price)::numeric,2) as max_price
FROM amazon_book
	WHERE "isBestSeller" = True
GROUP BY 1,2;

-- Genre rating over periods
SELECT DISTINCT category_name,
	published_year,
		genre_rating
FROM amazon_book
ORDER BY published_year DESC;

-- Total Books Sold by each Sellers
SELECT "soldBy",
		COUNT(*) as total_books
FROM amazon_book
	GROUP BY 1
	ORDER BY total_books DESC;

-- Correlation for price,ratings
SELECT CORR(price,stars) as correlation
FROM amazon_book
	WHERE price > 0 AND stars > 0;


-- Total Books per Category
SELECT category_name,
		COUNT(*) AS total_books
FROM amazon_book
	WHERE "isGoodReadsChoice" = True
	GROUP BY 1
	ORDER BY total_books DESC;

-- Average rating by price
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

-- Top 25 Books by Reviews
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

-- Books Rating and Price trend by Quarter
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

-- Books Rating and Price trend by Year
SELECT published_year,
    ROUND(AVG(price)::NUMERIC, 2) AS avg_price,
    ROUND(AVG(stars)::NUMERIC, 2) AS avg_rating,
	ROUND(AVG(reviews)::NUMERIC, 2) AS avg_reviews,
    COUNT(*) AS total_books
FROM amazon_book
WHERE published_year IS NOT NULL AND published_year != 0
GROUP BY published_year
ORDER BY published_year DESC;

	
