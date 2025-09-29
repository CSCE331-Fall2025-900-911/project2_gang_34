-- DROP TABLE Items;

-- CREATE TABLE Items (
--     ID INT primary key,
--     modifcation_name TEXT,
--     cost FLOAT,
--     stock INT,
--     active BOOLEAN
    
-- );

-- INSERT INTO Items
-- VALUES
-- (00,'Latte', 5.99, 1, '1'),
-- (01, 'Americano', 6.99, 1, '1');

-- SELECT * FROM Items;

DROP TABLE CurrentItems;

CREATE TABLE Current_Items (
    ID INT primary key,
    item_ID INT,
    custom_cost FLOAT,
    custom_note TEXT
    
);

-- INSERT INTO CurrentItems
-- VALUES
-- (00,'Latte', 5.99, 1, '1');

SELECT * FROM Current_Items;