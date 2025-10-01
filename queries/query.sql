-- test
-- 1) Sanity check: What items are in the catalog (id, name, price)?
SELECT id, name, price
FROM items
ORDER BY id;

-- 2) Inventory breadth & price range: How many items are there, and what are the min/max prices?
SELECT COUNT(*) AS item_count,
       MIN(price) AS min_price,
       MAX(price) AS max_price
FROM items;

-- 3) Premium menu scan: What are the top 5 most expensive items?
SELECT id, name, price
FROM items
ORDER BY price DESC, id
LIMIT 5;

-- 4) Price distribution by category: What is the average price per category?
-- (Assumes column 4 in Items is category_id as in your inserts.)
SELECT category_id,
       ROUND(AVG(price)::numeric, 2) AS avg_price,
       COUNT(*) AS items_in_category
FROM (
  SELECT id, name, price, CAST(column4 AS int) AS category_id  -- replace column4 with real column name if different
  FROM items
) t
GROUP BY category_id
ORDER BY category_id;

-- 5) Middle-price band: Which items are priced between $5.00 and $6.50?
SELECT id, name, price
FROM items
WHERE price BETWEEN 5.00 AND 6.50
ORDER BY price, id;

-- 6) Active modifications: Which modifications can customers currently select?
SELECT id, modificaion_name AS modification_name, item_id, cost, stock, mod_type, active
FROM modifications
WHERE active = TRUE
ORDER BY mod_type, cost, id;

-- 7) Mod coverage overview: How many active modifications exist by type and how much do they cost on average?
SELECT mod_type,
       COUNT(*) AS active_count,
       ROUND(AVG(cost)::numeric, 2) AS avg_cost
FROM modifications
WHERE active = TRUE
GROUP BY mod_type
ORDER BY mod_type;

-- 8) Out-of-stock check: Which modifications are out of stock (or critically low)?
SELECT id, modificaion_name AS modification_name, stock, mod_type
FROM modifications
WHERE stock <= 0
   OR stock IS NULL
ORDER BY stock NULLS FIRST, id;

-- 9) Price + mod example (global mods): For a specific item (e.g., Latte id=0), what would total be with each active global mod (item_id=0)?
-- Shows how totals will be presented at the register when a mod is added.
SELECT i.id AS item_id,
       i.name AS item_name,
       i.price AS base_price,
       m.modificaion_name AS mod_name,
       m.cost AS mod_cost,
       ROUND((i.price + m.cost)::numeric, 2) AS total_price
FROM items i
JOIN modifications m
  ON m.item_id = 0    -- treat item_id=0 as "applies to all items"
WHERE i.id = 0        -- change this to try other items
  AND m.active = TRUE
ORDER BY total_price, mod_name;

-- 10) Item-specific mods coverage: Which items have at least one item-specific modification (item_id = items.id)?
-- (If none yet, this will be empty and thus verify that all mods are currently global.)
SELECT DISTINCT i.id, i.name
FROM items i
JOIN modifications m
  ON m.item_id = i.id
WHERE m.active = TRUE
ORDER BY i.id;

-- 11) “Build-a-drink” sanity: Show 3 random items with 3 random active mods, computing totals.
-- Useful to quickly eyeball combinations during a demo.
WITH rand_items AS (
  SELECT id, name, price
  FROM items
  ORDER BY RANDOM()
  LIMIT 3
),
rand_mods AS (
  SELECT id, modificaion_name, cost
  FROM modifications
  WHERE active = TRUE
  ORDER BY RANDOM()
  LIMIT 3
)
SELECT ri.id AS item_id, ri.name AS item_name, ri.price AS base_price,
       rm.id AS mod_id, rm.modificaion_name AS mod_name, rm.cost AS mod_cost,
       ROUND((ri.price + rm.cost)::numeric, 2) AS total
FROM rand_items ri
CROSS JOIN rand_mods rm
ORDER BY item_id, mod_id;

-- 12) Menu quality check: Are there any duplicate item names or negative prices (data issues)?
-- First part: duplicates; second part: invalid prices. If both return empty, data quality looks good.
-- 12a) Duplicate names
SELECT name, COUNT(*) AS occurrences
FROM items
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY occurrences DESC, name;

-- 12b) Invalid/negative prices
SELECT id, name, price
FROM items
WHERE price IS NULL OR price < 0
ORDER BY id;
