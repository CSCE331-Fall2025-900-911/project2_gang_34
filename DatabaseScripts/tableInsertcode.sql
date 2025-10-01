DROP TABLE Items;

CREATE TABLE Items (
    ID INT primary key,
    item_name TEXT,
    cost FLOAT,
    stock INT,
    active BOOLEAN
    
);

INSERT INTO Items
VALUES
(00, 'Latte', 5.99, 1, '1'),
(01, 'Americano', 6.99, 1, '1'),
(02, 'Cappuccino', 5.49, 1, '1'),
(03, 'Mocha', 6.49, 1, '1'),
(04, 'Espresso', 3.99, 1, '1'),
(05, 'Macchiato', 4.49, 1, '1'),
(06, 'Flat White', 5.79, 1, '1'),
(07, 'Cold Brew', 4.99, 1, '1'),
(08, 'Iced Latte', 5.99, 1, '1'),
(09, 'Iced Americano', 5.49, 1, '1'),
(10, 'Chai Latte', 5.99, 1, '1'),
(11, 'Matcha Latte', 6.29, 1, '1'),
(12, 'Hot Chocolate', 4.79, 1, '1'),
(13, 'Caramel Frappuccino', 6.99, 1, '1'),
(14, 'Vanilla Bean Frappuccino', 6.79, 1, '1'),
(15, 'Strawberry Smoothie', 6.49, 1, '1');

-- SELECT * FROM Items;

DROP TABLE Current_Items;

CREATE TABLE Current_Items (
    ID INT primary key,
    item_ID INT,
    custom_cost FLOAT,
    custom_note TEXT
    
);

-- INSERT INTO CurrentItems
-- VALUES
-- (00,'Latte', 5.99, 1, '1');

-- SELECT * FROM Current_Items;

DROP TABLE Modifications;

INSERT INTO Modifications
VALUES
(1, 'Extra Espresso Shot', 0, 1.50, 100, 'add-on', TRUE),
(2, 'Vanilla Syrup', 0, 0.75, 80, 'flavor', TRUE),
(3, 'Caramel Syrup', 0, 0.75, 75, 'flavor', TRUE),
(4, 'Hazelnut Syrup', 0, 0.75, 70, 'flavor', TRUE),
(5, 'Oat Milk', 0, 0.50, 60, 'milk', TRUE),
(6, 'Almond Milk', 0, 0.50, 60, 'milk', TRUE),
(7, 'Soy Milk', 0, 0.50, 50, 'milk', TRUE),
(8, 'Whipped Cream', 0, 0.60, 90, 'topping', TRUE),
(9, 'Cocoa Powder', 0, 0.30, 100, 'topping', TRUE),
(10, 'Cinnamon Sprinkle', 0, 0.25, 100, 'topping', TRUE),
(11, 'Large Cup Upgrade', 0, 1.00, 200, 'size', TRUE),
(12, 'Iced Option', 0, 0.00, 999, 'preparation', TRUE);



DROP TABLE Current_Modifications;

CREATE TABLE Current_Modifications (
    ID INT primary key,
    current_item_ID INT,
    modification_ID INT,
    custom_cost FLOAT
    
);

DROP TABLE Suggested_Restocks;
CREATE TABLE Suggested_Restocks (
    ID INT primary key,
    item_ID INT,
    modification_ID	INT,
    is_modification BOOLEAN,
    cost FLOAT,
    recommended_quantity INT
);

DROP TABLE Past_Items;
CREATE TABLE Past_Items (
    ID INT primary key,
    customer_ID INT,
    order_ID INT,
    item_ID INT,
    custom_cost FLOAT,
    custom_note TEXT
    
);

\copy Past_Items from 'Past_Items.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Past_Modifications;
CREATE TABLE Past_Modifications (
    ID INT primary key,
    customer_ID INT,
    order_ID INT,
    past_item_ID INT,
    modification_ID INT,
    custom_cost FLOAT
);

\copy Past_Modifications from 'Past_Modifications.csv' DELIMITER ',' CSV HEADER;

DROP TABLE Past_Restocks;
CREATE TABLE Past_Restocks (
    ID INT primary key,
    item_ID INT,
    modification_ID INT,
    is_modification BOOLEAN,
    cost FLOAT,
    quantity INT,
    purchase_date DATE,
    custom_item TEXT,
    custom_modification TEXT,
    custom_note TEXT
    
);

\copy Past_Restocks from 'Past_Restocks.csv' DELIMITER ',' CSV HEADER;
