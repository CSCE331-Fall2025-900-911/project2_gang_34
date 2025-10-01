
--Peak Sales Day: select top 10 sums of order total grouped by day in descending order by order total
SELECT (day_item_total+day_modification_total) as day_order_total from ((select sum(price) as day_item_total from Past_Items group by order_date) inner join (select sum(price) as day_modification_total from Past_Modifications group by order_date));

