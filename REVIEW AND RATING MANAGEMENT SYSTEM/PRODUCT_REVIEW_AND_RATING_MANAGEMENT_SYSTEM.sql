CREATE TABLE review (
    Review_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Review_Text VARCHAR(500),
    Review_Date DATE,
    
constraint pk_key primary key (Review_ID),
constraint fk_key foreign key (Customer_ID) references customers(Customer_ID),
constraint fk_key foreign key (Product_ID) references products(Product_ID)
);

DELETE FROM Review
WHERE Review_ID > 0;

DELETE FROM Review
WHERE Review_ID > 0;

INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES
(1, 1, 1, 5, 'Excellent product and good quality.', '2026-01-10'),

(2, 2, 2, 4, 'Good product, worth the price.', '2026-01-12'),

(3, 3, 3, 3, 'Average quality but delivery was fast.', '2026-01-15'),

(4, 4, 4, 5, 'Very satisfied with the product.', '2026-01-18'),

(5, 5, 5, 2, ' Product quality was not good.', '2026-01-20'),

(6, 6, 6, 4, 'Good quality and attractive design.', '2026-01-22'),

(7, 7, 7, 5, 'Amazing product. Highly recommended.', '2026-01-25'),

(8, 8, 8, 3, 'Product is okay for the price.', '2026-01-28'),

(9, 9, 9, 4, 'Good product but packaging could be better.', '2026-02-02'),

(10, 10, 10, 1, 'Very poor quality. Not satisfied.', '2026-02-05');

select * from review;

-- 1.Display all reviews for a product

SELECT * FROM products JOIN Review ON products.Product_ID = Review.Product_ID;

-- 2.Display customer name with their reviews.

SELECT * FROM customers JOIN Review ON customers.Customer_ID = Review.Customer_ID;

-- 3.Find products having maximum reviews.

SELECT 
    products.Product_Name,
    COUNT(Review.Review_ID)
FROM products
JOIN Review
ON products.Product_ID = Review.Product_ID
GROUP BY products.Product_ID, products.Product_Name
ORDER BY COUNT(Review.Review_ID) DESC
LIMIT 1;

-- 4.Display recent customer feedback

SELECT * FROM Review ORDER BY Review_Date DESC;

-- 5.Display the rating above 4.

SELECT * FROM Review WHERE Rating >4;

