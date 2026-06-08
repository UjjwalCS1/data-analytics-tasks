-- 1. Total Revenue
SELECT SUM(`Total Revenue`) AS total_revenue
FROM online_sales_data;

-- 2. Total Units Sold
SELECT SUM(`Units Sold`) AS total_units_sold
FROM online_sales_data;

-- 3. Average Unit Price
SELECT AVG(`Unit Price`) AS avg_unit_price
FROM online_sales_data;

-- 4. Revenue by Product Category
SELECT `Product Category`,
       SUM(`Total Revenue`) AS revenue
FROM online_sales_data
GROUP BY `Product Category`;

-- 5. Revenue by Region
SELECT Region,
       SUM(`Total Revenue`) AS revenue
FROM online_sales_data
GROUP BY Region
ORDER BY revenue DESC;

-- 6. Revenue by Payment Method
SELECT `Payment Method`,
       SUM(`Total Revenue`) AS revenue
FROM online_sales_data
GROUP BY `Payment Method`;

-- 7. Monthly Revenue
SELECT MONTH(`Date`) AS month,
       SUM(`Total Revenue`) AS revenue
FROM online_sales_data
GROUP BY MONTH(`Date`)
ORDER BY month;

-- 8. Top 5 Products by Revenue
SELECT `Product Name`,
       SUM(`Total Revenue`) AS revenue
FROM online_sales_data
GROUP BY `Product Name`
ORDER BY revenue DESC
LIMIT 5;

-- 9. Highest Revenue Transaction
SELECT *
FROM online_sales_data
ORDER BY `Total Revenue` DESC
LIMIT 1;

-- 10. Rank Products by Revenue top 15
SELECT `Product Name`,
       SUM(`Total Revenue`) AS revenue,
       RANK() OVER(
           ORDER BY SUM(`Total Revenue`) DESC
       ) AS rank_no
FROM online_sales_data
GROUP BY `Product Name` LIMIT 15;

-- 11. Rank Regions by Revenue
SELECT Region,
       SUM(`Total Revenue`) AS revenue,
       DENSE_RANK() OVER(
           ORDER BY SUM(`Total Revenue`) DESC
       ) AS rank_no
FROM online_sales_data
GROUP BY Region;

-- 12. Previous Month Revenue
SELECT month,
       revenue,
       LAG(revenue) OVER(ORDER BY month) AS previous_revenue
FROM (
    SELECT MONTH(`Date`) AS month,
           SUM(`Total Revenue`) AS revenue
    FROM online_sales_data
    GROUP BY MONTH(`Date`)
) t;

-- 13. Next Month Revenue
SELECT month,
       revenue,
       LEAD(revenue) OVER(ORDER BY month) AS next_revenue
FROM (
    SELECT MONTH(`Date`) AS month,
           SUM(`Total Revenue`) AS revenue
    FROM online_sales_data
    GROUP BY MONTH(`Date`)
) t;

-- 14. Month-over-Month Growth
SELECT month,
       revenue,
       revenue - LAG(revenue) OVER(ORDER BY month) AS growth
FROM (
    SELECT MONTH(`Date`) AS month,
           SUM(`Total Revenue`) AS revenue
    FROM online_sales_data
    GROUP BY MONTH(`Date`)
) t;

-- 15. Top Product in Each Category
SELECT *
FROM (
    SELECT `Product Category`,
           `Product Name`,
           SUM(`Total Revenue`) AS revenue,
           RANK() OVER(
               PARTITION BY `Product Category`
               ORDER BY SUM(`Total Revenue`) DESC
           ) AS rank_no
    FROM online_sales_data
    GROUP BY `Product Category`, `Product Name`
) t
WHERE rank_no = 1;