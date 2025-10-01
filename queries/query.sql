-- 1) Sanity check: What items are in the catalog (id, item_name, cost)?
SELECT id, item_name, cost
FROM items
ORDER BY id;

-- 2) Inventory breadth & price range: How many items are there, and what are the min/max prices?
SELECT COUNT(*) AS item_count,
       MIN(cost) AS min_price,
       MAX(cost) AS max_price
FROM items;

-- 3) Premium menu scan: What are the top 5 most expensive items?
SELECT id, item_name, cost
FROM items
ORDER BY cost DESC, id
LIMIT 5;

-- 4) Price distribution by category: What is the average price per category?
SELECT category,
       ROUND(AVG(cost)::numeric, 2) AS avg_price,
       COUNT(*) AS items_in_category
FROM items
GROUP BY category
ORDER BY category;

-- 5) Middle-price band: Which items are priced between $5.00 and $6.50?
SELECT id, item_name, cost
FROM items
WHERE cost BETWEEN 5.00 AND 6.50
ORDER BY cost, id;

-- 6) Active modifications: Which modifications can customers currently select?
-- Note: schema has (id, modificaion_name, category, cost, stock, mod_type, active)
SELECT id,
       modificaion_name AS modification_name,
       category,
       cost,
       stock,
       mod_type,
       active
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

-- 9) Price + mod example (category-aware):
-- For a specific item (e.g., id=0), show totals with each active mod that is either global (category=0)
-- or matches the item's category.
SELECT i.id AS item_id,
       i.item_name AS item_name,
       i.cost AS base_price,
       m.modificaion_name AS mod_name,
       m.cost AS mod_cost,
       ROUND((i.cost + m.cost)::numeric, 2) AS total_price
FROM items i
JOIN modifications m
  ON m.active = TRUE
 AND (m.category = 0 OR m.category = i.category)
WHERE i.id = 0  -- change this to try other items
ORDER BY total_price, mod_name;

-- 10) Item-specific mods coverage:
-- Which items have at least one item-specific modification (mod.category = items.category and mod.category <> 0)?
SELECT DISTINCT i.id, i.item_name
FROM items i
JOIN modifications m
  ON m.active = TRUE
 AND m.category = i.category
 AND m.category <> 0
ORDER BY i.id;

-- 11) “Build-a-drink” sanity: Show 3 random items with 3 random active mods (category-aware), computing totals.
WITH rand_items AS (
  SELECT id, item_name, cost, category
  FROM items
  ORDER BY RANDOM()
  LIMIT 3
),
rand_mods AS (
  SELECT id, modificaion_name, cost, category
  FROM modifications
  WHERE active = TRUE
  ORDER BY RANDOM()
  LIMIT 3
)
SELECT ri.id AS item_id,
       ri.item_name AS item_name,
       ri.cost AS base_price,
       rm.id AS mod_id,
       rm.modificaion_name AS mod_name,
       rm.cost AS mod_cost,
       ROUND((ri.cost + rm.cost)::numeric, 2) AS total
FROM rand_items ri
JOIN rand_mods rm
  ON (rm.category = 0 OR rm.category = ri.category)
ORDER BY item_id, mod_id;

-- 12) Menu quality check: Are there any duplicate item names or negative prices (data issues)?
-- 12a) Duplicate names
SELECT item_name, COUNT(*) AS occurrences
FROM items
GROUP BY item_name
HAVING COUNT(*) > 1
ORDER BY occurrences DESC, item_name;

-- 12b) Invalid/negative prices
SELECT id, item_name, cost
FROM items
WHERE cost IS NULL OR cost < 0
ORDER BY id;
