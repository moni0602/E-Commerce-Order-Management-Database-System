# Database Relationship Analysis using Joins

## INNER JOIN EXAMPLE.sql
- Input:
  
  ```sql
  SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Total_Amount
  FROM customers c
  INNER JOIN orders o
  ON c.Customer_ID = o.Customer_ID;
  ```
  
- Output:
  
  <img width="657" height="247" alt="image" src="https://github.com/user-attachments/assets/d1ee5665-efb6-4567-ac4a-3d82bc3bcb34" />


## LEFT JOIN EXAMPLE.sql
- Input:
  
  ```sql
  SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Total_Amount
  FROM Customers c
  LEFT JOIN Orders o
  ON c.Customer_ID = o.Customer_ID;
  ```

- Output:

  <img width="631" height="245" alt="image" src="https://github.com/user-attachments/assets/66dd507e-68ab-4921-9743-16da920c22a2" />


## RIGHT JOIN EXAMPLE.sql
-Input:
  
  ```sql
  SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Total_Amount
FROM customers c
RIGHT JOIN orders o
ON c.Customer_ID = o.Customer_ID;
```
- Output:
  
  <img width="613" height="255" alt="image" src="https://github.com/user-attachments/assets/80c7ff09-44cb-49c4-926e-b86da02f88db" />



## COMPLETE ORDER REPORT.sql

- Input:
  
```sql
SELECT
    c.Customer_Name,
    pr.Product_Name,
    od.Quantity,
    o.Order_Date,
    o.Total_Amount,
    p.Payment_Status
FROM customers c
INNER JOIN orders o
ON c.Customer_ID = o.Customer_ID
INNER JOIN Order_Details od
ON o.Order_ID = od.Order_ID
INNER JOIN products pr
ON od.Product_ID = pr.Product_ID
INNER JOIN payment p
ON o.Order_ID = p.Order_ID;
```

- Output:
  
<img width="802" height="310" alt="image" src="https://github.com/user-attachments/assets/450d435c-bb9b-4eea-b445-31451580c1f6" />

## Customer purchase history report.sql
- Input:

```sql
SELECT
    c.Customer_Name,
    pr.Product_Name,
    od.Quantity,
    o.Order_Date
FROM customers c
INNER JOIN orders o
ON c.Customer_ID = o.Customer_ID
INNER JOIN Order_Details od
ON o.Order_ID = od.Order_ID
INNER JOIN products pr
ON od.Product_ID = pr.Product_ID;
```

- Output:
  
<img width="618" height="317" alt="image" src="https://github.com/user-attachments/assets/8d1fcde5-1b07-4f1f-8593-cbd7a0fdd3b2" />

## BUSINESS REPORTS

### Report 1: Customer Order Report.sql
- Input:

```sql
SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Order_Status
FROM customers c
INNER JOIN orders o
ON c.Customer_ID = o.Customer_ID;
```

- Output:

<img width="631" height="235" alt="image" src="https://github.com/user-attachments/assets/74d63970-45c1-4e42-bc74-4d2561148198" />

### Report 2: Sales Report.sql
- Input:

```sql
SELECT
    pr.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * pr.Price) AS Total_Revenue
FROM products pr
INNER JOIN Order_Details od
ON pr.Product_ID = od.Product_ID
GROUP BY pr.Product_ID, pr.Product_Name;
```

- Output:

<img width="623" height="180" alt="image" src="https://github.com/user-attachments/assets/155fae13-76ed-4e27-a2a5-fd6898eeae44" />


### Report 3: Payment Analysis Report.sql
- Input:

```sql
SELECT
    p.Payment_Mode,
    COUNT(p.Payment_ID) AS Number_of_Transactions,
    SUM(
        CASE
            WHEN p.Payment_Status = 'SUCCESSFUL'
            THEN 1
            ELSE 0
        END
    ) AS Successful_Payments
FROM payment p
GROUP BY p.Payment_Mode;
```

- Output:

<img width="613" height="138" alt="image" src="https://github.com/user-attachments/assets/47e0461c-c4f7-4518-a85d-0964e8ec6987" />


























  
