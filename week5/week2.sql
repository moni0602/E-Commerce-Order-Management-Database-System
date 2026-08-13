-- Seller and Inventory Management System

-- Create Seller table

create table sellers (

seller_id INT Primary Key Auto_Increment,
store_name VARCHAR(120)  NOT NULL UNIQUE,
contact_email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(20), 
city VARCHAR(50),
created_at TIMESTAMP DEFAULT current_timestamp
);

create table inventory (

item_id INT Primary Key Auto_Increment,
item_name VARCHAR(150) NOT NULL,
seller_id INT(10),
sku VARCHAR(50) UNIQUE,
unit_price DECIMAL(10, 2) NOT NULL,
stock_quantity INT NOT NULL DEFAULT 0,
reorder_level INT DEFAULT 10,
last_restocked TIMESTAMP DEFAULT current_timestamp,

CONSTRAINT fk_inventory_sellers
		FOREIGN KEY (seller_id)
		REFERENCES sellers(seller_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
INSERT INTO sellers (store_name, contact_email, phone_number, city)
VALUES ('ABC Store', 'abc@gmail.com', '9876543210', 'Chennai');

INSERT INTO sellers (store_name, contact_email, phone_number, city)
VALUES ('Fresh Mart', 'fresh@gmail.com', '9876543211', 'Chennai');

INSERT INTO sellers (store_name, contact_email, phone_number, city)
VALUES ('Tech World', 'tech@gmail.com', '9876543212', 'Bangalore');

INSERT INTO sellers (store_name, contact_email, phone_number, city)
VALUES ('Daily Needs', 'daily@gmail.com', '9876543213', 'Coimbatore');

INSERT INTO sellers (store_name, contact_email, phone_number, city)
VALUES ('Smart Shop', 'smart@gmail.com', '9876543214', 'Madurai');

INSERT INTO inventory (item_name, seller_id, sku, unit_price, stock_quantity)
VALUES ('Laptop', 1, 'SKU001', 50000, 10);

INSERT INTO inventory (item_name, seller_id, sku, unit_price, stock_quantity)
VALUES ('Mouse', 2, 'SKU002', 500, 25);

INSERT INTO inventory (item_name, seller_id, sku, unit_price, stock_quantity)
VALUES ('Keyboard', 3, 'SKU003', 1000, 20);

INSERT INTO inventory (item_name, seller_id, sku, unit_price, stock_quantity)
VALUES ('Headphones', 4, 'SKU004', 1500, 15);

INSERT INTO inventory (item_name, seller_id, sku, unit_price, stock_quantity)
VALUES ('Monitor', 5, 'SKU005', 12000, 8);

UPDATE sellers
SET city = 'Chennai'
WHERE seller_id = 1;

UPDATE sellers
SET phone_number = '9000000001'
WHERE seller_id = 2;

UPDATE sellers
SET city = 'Bangalore'
WHERE seller_id = 3;

UPDATE sellers
SET phone_number = '9000000004'
WHERE seller_id = 4;

UPDATE sellers
SET city = 'Madurai'
WHERE seller_id = 5;

UPDATE inventory
SET unit_price = 52000
WHERE item_id = 1;

UPDATE inventory
SET stock_quantity = 30
WHERE item_id = 2;

UPDATE inventory
SET unit_price = 1200
WHERE item_id = 3;

UPDATE inventory
SET stock_quantity = 20
WHERE item_id = 4;

UPDATE inventory
SET reorder_level = 15
WHERE item_id = 5;

-- Report 1: Comprehensive Availability & Stock Classification Report
-- Evaluates every product's operational state (Available, Low Stock Alert, or Unavailable / Out ofStock).
SELECT
s.store_name,
i.item_id,
i.item_name,
i.sku,
i.unit_price,
i.stock_quantity,
i.reorder_level,
CASE
WHEN i.stock_quantity = 0 THEN 'Unavailable (Out of Stock)'
WHEN i.stock_quantity <= i.reorder_level THEN 'Available (Low Stock Alert)'
ELSE 'Available (Optimal Stock)'
END AS inventory_status
FROM inventory i
INNER JOIN sellers s ON i.seller_id = s.seller_id
ORDER BY s.store_name, i.stock_quantity ASC;

-- Report 2: Unavailable Product Breakdown (Out-of-Stock Audit)
-- Isolates all stock-out occurrences across vendors to prioritize replenishment orders.
SELECT
s.seller_id,
s.store_name,
s.contact_email,
i.sku,
i.item_name,
i.unit_price,
i.last_restocked
FROM inventory i
INNER JOIN sellers s ON i.seller_id = s.seller_id
WHERE i.stock_quantity = 0
ORDER BY s.store_name, i.item_name;

-- Report 3: Seller Portfolio Valuation & Availability Aggregation
-- Provides executive summary metrics for each seller, counting total SKUs, active available items,unavailable items, and total financial valuation.
SELECT
s.seller_id,
s.store_name,
s.city,
COUNT(i.item_id) AS total_skus_managed,
SUM(CASE WHEN i.stock_quantity > 0 THEN 1 ELSE 0 END) AS available_skus,
SUM(CASE WHEN i.stock_quantity = 0 THEN 1 ELSE 0 END) AS unavailable_skus,
COALESCE(SUM(i.stock_quantity), 0) AS total_units_in_stock,
COALESCE(ROUND(SUM(i.unit_price * i.stock_quantity), 2), 0.00) AS
total_inventory_valuation
FROM sellers s
LEFT JOIN inventory i ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.store_name, s.city
ORDER BY total_inventory_valuation DESC;