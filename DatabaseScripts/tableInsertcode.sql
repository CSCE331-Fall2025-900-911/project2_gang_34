DROP TABLE Items;

CREATE TABLE Items (
    ID INT primary key,
    item_name TEXT,
    category INT,
    cost FLOAT,
    stock INT,
    active BOOLEAN
    
);


INSERT INTO Items (ID, item_name, category, cost, stock, active)

VALUES
(0, 'Latte', 1, 5.99, 100, TRUE),
(1, 'Americano', 1, 6.99, 100, TRUE),
(2, 'Cappuccino', 1, 5.49, 100, TRUE),
(3, 'Mocha', 1, 6.49, 100, TRUE),
(4, 'Espresso', 1, 3.99, 100, TRUE),
(5, 'Macchiato', 1, 4.49, 100, TRUE),
(6, 'Flat White', 1, 5.79, 100, TRUE),
(7, 'Cold Brew', 1, 4.99, 100, TRUE),
(8, 'Iced Latte', 1, 5.99, 100, TRUE),
(9, 'Iced Americano', 1, 5.49, 100, TRUE),
(10, 'Chai Latte', 1, 5.99, 100, TRUE),
(11, 'Matcha Latte', 1, 6.29, 100, TRUE),
(12, 'Hot Chocolate', 1, 4.79, 100, TRUE),
(13, 'Caramel Frappuccino', 1, 6.99, 100, TRUE),
(14, 'Vanilla Bean Frappuccino', 1, 6.79, 100, TRUE),
(15, 'Strawberry Smoothie', 1, 6.49, 100, TRUE);

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

CREATE TABLE Modifications (
    ID INT primary key,
    modificaion_name TEXT,
    category INT,
    cost FLOAT,
    stock INT,
    mod_type TEXT,
    active BOOLEAN 

);

INSERT INTO Modifications
VALUES
(1, 'Extra Espresso Shot', 1, 1.50, 100, 'add-on', TRUE),
(2, 'Vanilla Syrup', 1, 0.75, 80, 'flavor', TRUE),
(3, 'Caramel Syrup', 1, 0.75, 75, 'flavor', TRUE),
(4, 'Hazelnut Syrup', 1, 0.75, 70, 'flavor', TRUE),
(5, 'Oat Milk', 1, 0.50, 60, 'milk', TRUE),
(6, 'Almond Milk', 1, 0.50, 60, 'milk', TRUE),
(7, 'Soy Milk', 1, 0.50, 50, 'milk', TRUE),
(8, 'Whipped Cream', 1, 0.60, 90, 'topping', TRUE),
(9, 'Cocoa Powder', 1, 0.30, 100, 'topping', TRUE),
(10, 'Cinnamon Sprinkle', 1, 0.25, 100, 'topping', TRUE),
(11, 'Large Cup Upgrade', 1, 1.00, 200, 'size', TRUE),
(12, 'Iced Option', 1, 0.00, 999, 'preparation', TRUE);



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
    custom_note TEXT,
    order_date DATE
    
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
