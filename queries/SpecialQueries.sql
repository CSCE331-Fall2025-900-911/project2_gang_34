-- Special Query 1
SELECT
    DATEPART(WEEK, date) AS week_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM past_items
GROUP BY DATEPART(WEEK, date)
ORDER BY week_number;

--Realistic Sales History: select count of orders, sum of order total grouped by hour
SELECT count(order_id) as num_orders, sum(price) as total_sales from (select order_id, price from Past_Items union all select order_id, price from Past_Modifications) group by strftime('%H', order_date);
--Peak Sales Day: select top 10 sums of order total grouped by day in descending order by order total
SELECT (day_item_total+day_modification_total) as day_order_total from ((select sum(price) as day_item_total from Past_Items group by order_date) inner join (select sum(price) as day_modification_total from Past_Modifications group by order_date));

