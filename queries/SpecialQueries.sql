-- Special Query 1
SELECT
    DATEPART(WEEK, date) AS week_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM past_items
GROUP BY DATEPART(WEEK, date)
ORDER BY week_number;

-- Special Query 2
SELECT
    DATEPART(HOUR, date) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(custom_cost) AS total_sales
FROM past_items
GROUP BY DATEPART(HOUR, date)
ORDER BY hour_of_day;

-- Special Query 3
SELECT TOP 10
    CAST(date AS DATE) AS sales_day,
    SUM(custom_cost) AS total_sales
FROM past_items
GROUP BY CAST(date AS DATE)
ORDER BY total_sales DESC;

-- Special Query 4

-- Special Query 5

-- Special Query 6