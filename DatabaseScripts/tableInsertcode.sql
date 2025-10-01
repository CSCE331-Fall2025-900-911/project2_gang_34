DROP TABLE Items;

CREATE TABLE Items (
    ID INT primary key,
    item_name TEXT,
    cost FLOAT,
    stock INT,
    active BOOLEAN
    
);

\copy Items FROM '../GeneratedData/Items.csv' DELIMITER ',' CSV HEADER;

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
\copy Items FROM '../GeneratedData/Current_Items.csv' DELIMITER ',' CSV HEADER;

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
\copy Items FROM '../GeneratedData/Modifications.csv' DELIMITER ',' CSV HEADER;


DROP TABLE CurrentModifications;

CREATE TABLE Current_Modifications (
    ID INT primary key,
    current_item_ID INT,
    modification_ID INT,
    custom_cost FLOAT
    
);
\copy Items FROM '../GeneratedData/Current_Modifications.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE Suggested_Restocks (
    ID INT primary key,
    item_ID INT,
    modification_ID	INT,
    is_modification BOOLEAN,
    cost FLOAT,
    recommended_quantity INT
);

CREATE TABLE Past_Items (
    ID INT primary key,
    customer_ID INT,
    order_ID INT,
    item_ID INT,
    custom_cost FLOAT,
    custom_note TEXT
    
);

\copy Past_Items from 'Past_Items.csv' DELIMITER ',' CSV HEADER

CREATE TABLE Past_Modifications (
    ID INT primary key,
    customer_ID INT,
    order_ID INT,
    past_item_ID INT,
    modification_ID INT,
    custom_cost FLOAT
);

\copy Past_Modifications from 'Past_Modifications.csv' DELIMITER ',' CSV HEADER

CREATE TABLE Past_Restocks (
    odification ID	Is Modification	Cost	Quantity	Date	Custom Item	Custom Modification	Custom Note
    ID INT primary key,
    item_ID INT,
    modification_ID INT,
    is_modification BOOLEAN,
    cost FLOAT,
    quantity INT,
    purchase_date DATE
    custom_item TEXT,
    custom_modification TEXT,
    custom_note TEXT
    
);

\copy Past_Restocks from 'Past_Restocks.csv' DELIMITER ',' CSV HEADER
