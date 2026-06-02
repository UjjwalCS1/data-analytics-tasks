-- 1. Total Revenue
SELECT SUM(total_price) AS total_revenue
FROM sales_data;

-- 2. Total orders
SELECT COUNT(*) AS total_orders
FROM sales_data;

-- 3. Average order value
SELECT ROUND(AVG(total_price), 2) AS avg_order_value
FROM sales_data;

-- 4. Revenue by region
SELECT
    region,
    SUM(total_price) AS revenue
FROM sales_data
GROUP BY region
ORDER BY revenue DESC;


-- 5. Revenue by category
SELECT
    category,
    SUM(total_price) AS revenue
FROM sales_data
GROUP BY category
ORDER BY revenue DESC;


-- 6. Count unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data;


-- 7. Top 10 customers by spending
SELECT
    customer_id,
    SUM(total_price) AS total_spent
FROM sales_data
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 8. Revenue by gender
SELECT
    gender,
    SUM(total_price) AS revenue
FROM sales_data
GROUP BY gender;

-- 9. Monthly revenue trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_price) AS revenue
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 10. Most popular products
SELECT
    product_name,
    SUM(quantity) AS units_sold
FROM sales_data
GROUP BY product_name
ORDER BY units_sold DESC;

-- 11. Average order value by region
SELECT
    region,
    ROUND(AVG(total_price), 2) AS avg_order_value
FROM sales_data
GROUP BY region
ORDER BY avg_order_value DESC;

-- 12. Return rate
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN shipping_status = 'Returned' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS return_rate
FROM sales_data;


-- 13. Products with highest return rate
SELECT
    product_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN shipping_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        100.0 * SUM(CASE WHEN shipping_status = 'Returned' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS return_rate
FROM sales_data
GROUP BY product_name
ORDER BY return_rate DESC;


-- 14. Rank customers by revenue
SELECT
    customer_id,
    SUM(total_price) AS revenue,
    RANK() OVER (
        ORDER BY SUM(total_price) DESC
    ) AS customer_rank
FROM sales_data
GROUP BY customer_id limit 20;


-- 15. Top-selling product in each region
WITH product_sales AS (
    SELECT
        region,
        product_name,
        SUM(quantity) AS units_sold,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY SUM(quantity) DESC
        ) AS rn
    FROM sales_data
    GROUP BY region, product_name
)
SELECT *
FROM product_sales
WHERE rn = 1;

-- 16. Customers spending above average
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_price) AS total_spent
    FROM sales_data
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM customer_spending
);

-- 17. Revenue contribution by region
SELECT
    region,
    SUM(total_price) AS revenue,
    ROUND(
        100.0 * SUM(total_price) /
        SUM(SUM(total_price)) OVER (),
        2
    ) AS contribution_pct
FROM sales_data
GROUP BY region
ORDER BY revenue DESC;

-- 18. Month-over-month growth 
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_price) AS revenue
    FROM sales_data
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month)) * 100,
        2
    ) AS growth_pct
FROM monthly_sales
ORDER BY month;

-- 19. Pareto Analysis (Top 20% Customers)
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_price) AS revenue
    FROM sales_data
    GROUP BY customer_id
)
SELECT *
FROM customer_sales
ORDER BY revenue DESC
LIMIT 58;


-- 20. Executive Dashboard Metrics
--    Total Orders
--    Total Customers
--    Total Revenue
--    Average Order Value
--    Total Units Sold
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(total_price) AS revenue,
    AVG(total_price) AS avg_order_value,
    SUM(quantity) AS units_sold
FROM sales_data;
