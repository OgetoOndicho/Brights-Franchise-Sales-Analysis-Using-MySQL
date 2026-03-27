# BRIGHTS-FRANCHISE-SALES-ANALYSIS-USING-MySQL
This Project utilizes MySQL to explore, clean and draw insights from the data so as to enable stakeholders at Brights Franchise Limited to make proper decisions about Sales 

# OBJECTIVES
- Design and Set up a database for Brights Franchaise Limited to store all sales data made by the company.
- Organize, clean and transform the data into a consistent format.
- Provide both quantitative and qualitative analysis on the data.
- Design clean visuals inform of dashboards for reporting on fundamental Business Questions

# SAMPLE BUSINESS QUESTIONS
- Find the total sales
```sql
SELECT COUNT(*)  AS Total_sales
FROM retails_data;
```

- Find all unique customers from the data
```sql
SELECT COUNT( DISTINCT customer_id) AS Customers_count
FROM retails_data;
```

- What is the minimum age and maximum ages of the customers
```sql
SELECT
	MAX(age) AS Older_customers,
    MIN(age) AS Younger_customers
FROM retails_data;
```

- Find all transactions where Category is Clothing and Quantity sold is more than 4 in the Month of November 2022
```sql
SELECT * FROM retails_data
WHERE category = 'Clothing'
AND quantity > 2
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

- Calculate total transactions made by each gender in each category
```sql
SELECT gender, category, COUNT(*) AS All_transactions
FROM retails_data
GROUP BY gender, category
ORDER BY 3 DESC;
```

- Calculate the Average sales for each month , hence find the best selling month in each year
```sql
SELECT 
	EXTRACT(YEAR FROM sale_date) AS Year,
    EXTRACT(MONTH FROM sale_date) AS Month,
	AVG(total_sale) AS Average_sales
FROM retails_data
GROUP BY 1, 2
ORDER BY 3 DESC;
```

-  Create each shift and number of orders based on the time
```sql
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS Shift
FROM retails_data;
```

-  How many orders were made on each shift
```sql
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
```


# TOOLS USED
1. MySQL: For cleaning and organizations
2. PowerBI: For visualizations and reporting.


