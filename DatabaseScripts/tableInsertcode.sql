DROP TABLE Items;

CREATE TABLE Items (
    ID INT primary key,
    item_name TEXT,
    cost FLOAT,
    stock INT,
    active BOOLEAN
    
);


-- INSERT INTO Items
-- VALUES
-- (00,'Latte', 5.99, 1, '1'),
-- (01, 'Americano', 6.99, 1, '1');

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
    item_ID INT,
    cost FLOAT,
    stock INT,
    mod_type TEXT,
    active BOOLEAN 
    
);


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
