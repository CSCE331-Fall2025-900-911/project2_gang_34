-- Special Query 1
SELECT
    EXTRACT(WEEK FROM order_date) AS week_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM past_items
GROUP BY EXTRACT(WEEK FROM order_date)
ORDER BY week_number;


-- Special Query 2
SELECT
    EXTRACT(HOUR FROM order_date) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(custom_cost) AS total_sales
FROM past_items
GROUP BY EXTRACT(HOUR FROM order_date)
ORDER BY hour_of_day;


-- Special Query 3
SELECT
    CAST(order_date AS DATE) AS sales_day,
    SUM(custom_cost) AS total_sales
FROM past_items
GROUP BY CAST(order_date AS DATE)
ORDER BY total_sales DESC
LIMIT 10;


-- Special Query 5

-- Special Query 6