WITH params AS (
  SELECT DATE '2025-08-25' AS target_day  -- any day inside the desired week
)

-- RESULT
SELECT
  to_char(date_trunc('week', o.created_at), 'IYYY-"W"IW') AS iso_week,
  COUNT(*) AS orders_in_week
FROM orders o
JOIN params p ON TRUE
WHERE date_trunc('week', o.created_at) = date_trunc('week', p.target_day::timestamp)
GROUP BY 1;


-- PARAMETERS
WITH params AS (
  SELECT DATE '2025-08-30' AS target_date,  -- day to slice by hour
         'UTC'::text AS tz                  -- set to your local tz if desired (e.g., 'America/Chicago')
)

-- RESULT
SELECT
  lpad(CAST(EXTRACT(HOUR FROM (o.created_at AT TIME ZONE p.tz)) AS int)::text, 2, '0') || ':00' AS hour_of_day,
  COUNT(*) AS orders_count,
  ROUND(SUM(o.total_amount)::numeric, 2) AS sales_total
FROM orders o
JOIN params p ON TRUE
WHERE o.created_at::date = p.target_date
GROUP BY 1
ORDER BY 1;


SELECT
  o.created_at::date AS sales_day,
  ROUND(SUM(o.total_amount)::numeric, 2) AS day_total
FROM orders o
GROUP BY 1
ORDER BY day_total DESC
LIMIT 10;


SELECT
  it.id    AS item_id,
  it.name  AS item_name,
  COUNT(DISTINCT ii.inventory_id) AS inventory_components
FROM items it
LEFT JOIN item_ingredients ii ON ii.item_id = it.id
GROUP BY it.id, it.name
ORDER BY inventory_components DESC, item_name;


-- PARAMETERS
WITH params AS (
  SELECT DATE '2025-08-25' AS any_day_in_week  -- any date inside the target week
),

-- Normalize week window
week_window AS (
  SELECT date_trunc('week', any_day_in_week)::date AS week_start,
         (date_trunc('week', any_day_in_week) + INTERVAL '7 days')::date AS week_end
  FROM params
),

-- Daily sales within the week
daily_sales AS (
  SELECT
    o.created_at::date AS sales_day,
    SUM(o.total_amount) AS day_total
  FROM orders o, week_window w
  WHERE o.created_at::date >= w.week_start
    AND o.created_at::date <  w.week_end
  GROUP BY o.created_at::date
),

-- The lowest-sales day for that week
worst_day AS (
  SELECT sales_day, day_total
  FROM daily_sales
  ORDER BY day_total ASC, sales_day
  LIMIT 1
),

-- Item sales on the worst day (by quantity; change to SUM(oi.line_total) for revenue)
item_totals_on_worst AS (
  SELECT
    oi.item_id,
    SUM(oi.quantity) AS qty_sold
  FROM order_items oi
  JOIN orders o ON o.id = oi.order_id
  JOIN worst_day wd ON o.created_at::date = wd.sales_day
  GROUP BY oi.item_id
  ORDER BY qty_sold DESC, oi.item_id
  LIMIT 1
)

SELECT
  to_char(wd.sales_day, 'DD Mon YYYY') AS lowest_sales_day,
  ROUND(wd.day_total::numeric, 2)      AS lowest_sales_amount,
  to_char(ww.week_start, '"Week of" Mon DD, YYYY') AS week_label,
  it.name AS top_seller_item
FROM worst_day wd
CROSS JOIN week_window ww
LEFT JOIN item_totals_on_worst its ON TRUE
LEFT JOIN items it ON it.id = its.item_id;


--Peak Sales Day: select top 10 sums of order total grouped by day in descending order by order total
SELECT (day_item_total+day_modification_total) as day_order_total from ((select sum(price) as day_item_total from Past_Items group by order_date) inner join (select sum(price) as day_modification_total from Past_Modifications group by order_date));

