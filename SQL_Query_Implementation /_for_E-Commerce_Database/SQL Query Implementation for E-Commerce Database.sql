-- 1. Basic SQL Queries
-- Display all customer details

SELECT * FROM customers;

-- Display all available products

SELECT * FROM products;

-- Retrieve product names and prices only

SELECT Product_Name, Price
FROM products;

-- Display all orders placed by customers

SELECT * FROM orders;

-- Retrieve payment details

SELECT * FROM payment;

-- 2. Filtering Conditions Using WHERE
-- Products with price greater than ₹5000

SELECT * FROM products WHERE Price > 500;

-- Products available in stock

SELECT * FROM products WHERE Stock_Quantity > 0;

-- Customers from Chennai

SELECT * FROM customers WHERE City = 'Chennai';

-- Display completed orders

SELECT * FROM orders WHERE Order_Status = 'Delivered';

-- Products with rating above 4

SELECT 
    products.Product_Name,
    Review.Rating
FROM products
JOIN Review
ON products.Product_ID = Review.Product_ID
WHERE Review.Rating > 4;

-- 3. Sort Data Using ORDER BY
-- Products from lowest to highest price

SELECT * FROM products ORDER BY Price ASC;

-- Customers alphabetically

SELECT * FROM customers ORDER BY Customer_Name ASC;

-- Top expensive products

SELECT * FROM products ORDER BY Price DESC LIMIT 5;

-- Latest orders first

SELECT * FROM orders ORDER BY Order_Date DESC;

-- 4. Retrieve Unique Values Using DISTINCT
-- Unique product categories

SELECT DISTINCT Category_ID
FROM products;

-- Different payment methods

SELECT DISTINCT Payment_Mode
FROM payment;

-- Unique customer locations

SELECT DISTINCT City
FROM customers;

-- 5. Search Products Based on Conditions
-- Products between ₹1000 and ₹5000

SELECT *
FROM products
WHERE Price BETWEEN 500 AND 1000;

-- Products belonging to a particular category

SELECT *
FROM products
WHERE Category_ID = 1;

-- Products currently available in inventory

SELECT *
FROM products
WHERE Stock_Quantity > 0;

-- Search products using product name

SELECT *
FROM products
WHERE Product_Name LIKE 'Wireless Bluetooth Headphones';

-- Find low-stock products

SELECT *
FROM products
WHERE Stock_Quantity < 50;

-- 6. Retrieve Customer and Product Information
-- Customer details with their orders

SELECT 
    customers.Customer_ID,
    customers.Customer_Name,
    orders.Order_ID,
    orders.Order_Date,
    orders.Total_Amount,
    orders.Order_Status
FROM customers
JOIN orders
ON customers.Customer_ID = orders.Customer_ID;

-- Product details with category information

SELECT 
    products.Product_ID,
    products.Product_Name,
    products.Price,
    categories.Category_Name
FROM products
JOIN categories
ON products.Category_ID = categories.Category_ID;

-- Customers who purchased a specific product

SELECT DISTINCT
    customers.Customer_ID,
    customers.Customer_Name
FROM customers
JOIN orders
ON customers.Customer_ID = orders.Customer_ID
JOIN Order_Details
ON orders.Order_ID = Order_Details.Order_ID
WHERE Order_Details.Product_ID = 1;

-- Products purchased by each customer

SELECT 
    customers.Customer_Name,
    products.Product_Name
FROM customers
JOIN orders
ON customers.Customer_ID = orders.Customer_ID
JOIN Order_Details
ON orders.Order_ID = Order_Details.Order_ID
JOIN products
ON Order_Details.Product_ID = products.Product_ID;

-- 7. Multiple Filtering Conditions
-- Electronics products costing more than ₹500

SELECT *
FROM products
WHERE Category_ID = 1
AND Price > 500;

-- Customers from Chennai or Bangalore

SELECT *
FROM customers
WHERE City IN ('Chennai', 'Tambaram');

-- Products containing the word "Wireless Bluetooth Headphones"

SELECT *
FROM products
WHERE Product_Name LIKE 'Wireless Bluetooth Headphones';

-- Orders within a specific date range

SELECT *
FROM orders
WHERE Order_Date BETWEEN '2026-08-21' AND '2026-08-23';

-- Report 1: Product Availability Report 

SELECT 
    Product_Name,
    Price,
    Stock_Quantity,
    CASE
        WHEN Stock_Quantity > 0 THEN 'Available'
        ELSE 'Out of Stock'
    END AS Availability_Status
FROM products;

-- Report 2: Customer Report

SELECT 
    'Total Customers' AS Report_Type,
    COUNT(*) AS Customer_Count
FROM customers

UNION ALL

SELECT 
    CONCAT('Customers in ', City) AS Report_Type,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY City;

-- Report 3: Order Report

SELECT 
    'Total Orders' AS Order_Type,
    COUNT(*) AS Order_Count
FROM orders

UNION ALL

SELECT 
    'Completed Orders' AS Order_Type,
    COUNT(*) AS Order_Count
FROM orders
WHERE Order_Status = 'Completed'

UNION ALL

SELECT 
    'Pending Orders' AS Order_Type,
    COUNT(*) AS Order_Count
FROM orders
WHERE Order_Status = 'Pending'

UNION ALL

SELECT 
    'Cancelled Orders' AS Order_Type,
    COUNT(*) AS Order_Count
FROM orders
WHERE Order_Status = 'Cancelled';

-- Report 4: Product Performance Report

SELECT 
    'Highest-Priced Product' AS Performance_Type,
    Product_Name,
    Price,
    NULL AS Number_of_Reviews,
    Stock_Quantity
FROM products
ORDER BY Price DESC
LIMIT 5;