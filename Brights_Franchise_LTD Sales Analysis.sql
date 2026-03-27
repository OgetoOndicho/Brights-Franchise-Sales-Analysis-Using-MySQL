CREATE DATABASE Brights_Franchise_LTD;

USE Brights_Franchise_LTD;

-- Grant access to the database
SET sql_safe_updates = 0;

-- View our data in the Table inside the Database
SELECT * FROM retails_data;

-- View the data types in our table inside the DB
DESCRIBE retails_data;

-- PART A Data Cleaning
-- Rename the first columnn transaction_id properly--
ALTER TABLE retails_data
RENAME COLUMN ï»¿transactions_id TO transactions_id;

-- Rename 'quantiy' column to 'Quantity' --
ALTER TABLE retails_data
RENAME COLUMN quantiy TO quantity;

-- Change the data type of sale_date to a DATE type-- 
ALTER TABLE retails_data
MODIFY COLUMN sale_date DATE;

-- Change sale_time to DATE type --
UPDATE retails_data
SET sale_time = STR_TO_DATE(sale_time, '%H:%i:%s');

ALTER TABLE retails_data
MODIFY sale_time TIME;

-- What is the total count of the data in the table --
SELECT COUNT(*) AS Total_retail_count
FROM retails_data;

-- Check for columns with NULLs --
SELECT * FROM retails_data
WHERE 
	transactions_id IS NULL
	 OR sale_date IS NULL
	OR sale_time IS NULL 
	 OR customer_id IS NULL 
	OR gender IS NULL 
	OR age IS NULL 
	OR category IS NULL 
	OR quantity IS NULL 
	OR price_per_unit IS NULL 
	OR cogs IS NULL 
	OR total_sale IS NULL;
    
-- PART B; Conduct Exploratory Analysis --
-- Q1 Find the total sales --
SELECT COUNT(*)  AS Total_sales
FROM retails_data;

-- Q2 Find all unique customers from the data --
SELECT COUNT( DISTINCT customer_id) AS Customers_count
FROM retails_data;

-- Q3. Obtain all unique categories from the data --
SELECT COUNT(DISTINCT category) AS Category_count
FROM retails_data;

-- Q4. What is the minimum age and maximum ages of the customers --
SELECT
	MAX(age) AS Older_customers,
    MIN(age) AS Younger_customers
FROM retails_data;

-- PART C; Data Analysis to answer Business Quetions --
-- Q5. Retrieve all data for sales made on the '2022-11-05'
SELECT * FROM retails_data
WHERE sale_date = '2022-11-05'; 

-- Q6. Find all transactions where Category is Clothing and Quantity sold is more than 4 in the Month of November 2022 --
SELECT * FROM retails_data
WHERE category = 'Clothing'
AND quantity > 2
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q7. Calculate the average age of customers who purchased items from the Beauty Category --
SELECT category, ROUND(AVG(age),2) AS Avg_customer_age
FROM retails_data
WHERE category  = 'Beauty';

-- Q8. Find all transactions wheretotal sales is over 1000 --
SELECT * FROM retails_data
WHERE total_sale > 1000;

-- Q9. Calculate total transactions made by each gender in each category --
SELECT gender, category, COUNT(*) AS All_transactions
FROM retails_data
GROUP BY gender, category
ORDER BY 3 DESC;

-- Q10. Calculate the Average sales for each month , hence find the best selling month in each year --
SELECT 
	EXTRACT(YEAR FROM sale_date) AS Year,
    EXTRACT(MONTH FROM sale_date) AS Month,
	AVG(total_sale) AS Average_sales
FROM retails_data
GROUP BY 1, 2
ORDER BY 3 DESC;


-- Q11. Find the top 5 customers based on the highest total sales --
SELECT customer_id, SUM(total_sale) AS Total_sales
FROM retails_data
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;


-- Q12. Find unique customers who purchased items fro each category --
SELECT category, COUNT(DISTINCT customer_id) AS Unique_customers
FROM retails_data
GROUP BY category
ORDER BY 2 DESC;

-- Q13. Create each shift and number of orders based on the time --
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS Shift
FROM retails_data;

-- Q14. How many orders were made on each shift ?--
WITH hourly_sale AS (
	SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS Shift
FROM retails_data
)
SELECT Shift, COUNT(*) AS Total_orders
FROM hourly_sale
GROUP BY Shift;
 

