DROP TABLE Items;

CREATE TABLE Items (
    ID INT primary key,
    item_name TEXT,
    cost FLOAT,
    stock INT,
    active BOOLEAN
    
);
-- add hardcoded insert of menu items and other items and custom
INSERT INTO Items (ID,item_name,cost,stock,active) VALUES (0,Latte,5.99,100,1),(1,Americano,6.99,100,1),(2,"Cappuccino",7.99,100,1),(3,"Ristretto",6.99,100,1),(4,"Cortado",7.99,100,1),(5,"Espresso",6.99,100,1),(6,"Mocha",5.99,100,1),(7,"Robusta",6.99,100,1),(8,"Doppio",7.99,100,1),(9,"Frappuccino",6.99,100,1),(10,"Water",1.29,100,1),(11,"Chocolate Pastry",3.99,100,1),(12,"Cookie",3.99,100,1),(13,"Egg Sandwitch",4.99,100,1),(14,"Sausage Sandwitch",4.99,100,1),(15,"Breakfast Sandwitch",4.99,100,1),(16,"Croissont",3.99,100,1);
-- \copy Items FROM '../GeneratedData/Items.csv' DELIMITER ',' CSV HEADER;

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
-- add hardcoded insert of menu modifications and custom
INSERT INTO Modifications (ID,modificaion_name,item_ID,cost,stock,mod_type,active) VALUES (0,"Cream",0,0.99,100,1,1),(1,"Cream",1,0.99,100,1,1),(2,"Cream",2,0.99,100,1,1),(3,"Cream",3,0.99,100,1,1),(4,"Cream",4,0.99,100,1,1),(5,"Cream",5,0.99,100,1,1),(6,"Cream",6,0.99,100,1,1),(7,"Cream",7,0.99,100,1,1),(8,"Cream",8,0.99,100,1,1),(9,"Cream",9,0.99,100,1,1),(10,"Cream",10,0.99,100,1,1),(11,"Toasted",11,0.49,100,3,1),(12,"Toasted",12,0.49,100,3,1),(13,"Toasted",13,0.49,100,3,1),(14,"Toasted",14,0.49,100,3,1),(15,"Toasted",15,0.49,100,3,1),(16,"Toasted",16,0.49,100,3,1);
--\copy Items FROM '../GeneratedData/Modifications.csv' DELIMITER ',' CSV HEADER;


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
