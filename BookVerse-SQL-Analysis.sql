-- Create database
CREATE DATABASE BookVerse_DB;

USE BookVerse_DB;

-- Create Books table
CREATE TABLE Books
(
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(250) NOT NULL,
    Author VARCHAR(150) NOT NULL,
    Genre VARCHAR(80),
    Published_Year YEAR,
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Customers table
CREATE TABLE Customers
(
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(120),
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);


-- Create Orders table
CREATE TABLE Orders
(
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY(Customer_ID)
        REFERENCES Customers(Customer_ID),

    CONSTRAINT FK_Order_Book
        FOREIGN KEY(Book_ID)
        REFERENCES Books(Book_ID)
);

-- 1. What is the total number of books?
SELECT COUNT(*) AS Total_Books
FROM Books;

-- 2. What is the total number of customers?
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- 3. What is the total number of orders?
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- 4. What are the different genres?
SELECT DISTINCT Genre
FROM Books;


-- 5. What are the different countries?
SELECT DISTINCT Country
FROM Customers
ORDER BY Country;

-- 6. What is the total quantity of books sold?

SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM Orders;

-- 7. What is the total revenue generated?
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

-- 8. What is the average order value?
SELECT AVG(Total_Amount) AS Average_Order_Value
FROM Orders;

-- 1. What is the overall sales performance?
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Total_Amount) AS Total_Revenue,
    AVG(Total_Amount) AS Average_Order_Value
FROM Orders;

-- 2. Which books generate the highest revenue?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre
ORDER BY Revenue DESC
LIMIT 10;

-- 3. Which books sell the highest number of copies?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- 4. Which authors generate the highest revenue?
SELECT
    b.Author,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Revenue DESC
LIMIT 10;

-- 5. Which genres generate the most revenue?
SELECT
    b.Genre,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- 6. What is the monthly sales trend?
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Quantity) AS Quantity_Sold,
    SUM(Total_Amount) AS Revenue
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- 7. What is the yearly sales performance?
SELECT
    YEAR(Order_Date) AS Year,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Quantity_Sold,
    SUM(Total_Amount) AS Revenue
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- 8. Which books are high-value books?
SELECT
    b.Book_ID,
    b.Title,
    b.Price,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Price
ORDER BY Revenue DESC
LIMIT 10;

-- 9. Which books are high-volume books?
SELECT
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- 1. Which customers have placed multiple orders?
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Number_of_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) > 1
ORDER BY Number_of_Orders DESC;

-- 2. Who are the highest-spending customers?
SELECT
    c.Customer_ID,
    c.Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spending DESC
LIMIT 10;

-- 3. Which customers place the most orders?
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Number_of_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Number_of_Orders DESC
LIMIT 10;

-- 4. What is the average spending per customer?
SELECT
    AVG(Customer_Total) AS Average_Customer_Spending
FROM
(
    SELECT
        Customer_ID,
        SUM(Total_Amount) AS Customer_Total
    FROM Orders
    GROUP BY Customer_ID
) x;

-- 5. Which countries generate the most sales?
SELECT
    c.Country,
    COUNT(DISTINCT c.Customer_ID) AS Customers,
    COUNT(o.Order_ID) AS Orders,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Country
ORDER BY Revenue DESC;

-- 6. Which customers purchase from multiple genres?
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Number_of_Genres
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) > 1
ORDER BY Number_of_Genres DESC;

-- 7. How does customer purchasing behaviour change over time?
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    COUNT(DISTINCT Customer_ID) AS Active_Customers,
    COUNT(Order_ID) AS Orders,
    SUM(Quantity) AS Quantity_Sold,
    SUM(Total_Amount) AS Revenue
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- 1: Which books have the highest quantity sold?
SELECT 
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Total_Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY 
    b.Book_ID,
    b.Title
ORDER BY Total_Quantity_Sold DESC;

-- 2. Which books generate the highest revenue?
SELECT 
    b.Book_ID,
    b.Title,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Revenue DESC;

-- 3. What is genre-wise sales volume?
SELECT
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Quantity_Sold DESC;

-- 4. What is genre-wise revenue?
SELECT
    b.Genre,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- 5. Which authors perform best?
SELECT
    b.Author,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Revenue DESC
LIMIT 10;

-- 6. Which books have the highest prices?
SELECT
    Book_ID,
    Title,
    Author,
    Genre,
    Price
FROM Books
ORDER BY Price DESC
LIMIT 10;

-- 7. Which books have low sales?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre
ORDER BY Quantity_Sold ASC
LIMIT 10;

-- 8. Which books have never been ordered?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Price,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;

-- 9. Is there a relationship between price and sales?
SELECT
    b.Book_ID,
    b.Price,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Price;

-- 1. What is the current inventory position?
SELECT
    COUNT(*) AS Total_Books,
    SUM(Stock) AS Total_Stock,
    SUM(Price * Stock) AS Total_Inventory_Value
FROM Books;

-- 2. Which books have low stock?
SELECT
    Book_ID,
    Title,
    Genre,
    Price,
    Stock
FROM Books
WHERE Stock <= 10
ORDER BY Stock ASC;


-- 3. What is stock by genre?
SELECT
    Genre,
    COUNT(*) AS Number_of_Books,
    SUM(Stock) AS Total_Stock
FROM Books
GROUP BY Genre
ORDER BY Total_Stock DESC;

-- 4. Which genres have the highest inventory value?
SELECT
    Genre,
    SUM(Price * Stock) AS Inventory_Value
FROM Books
GROUP BY Genre
ORDER BY Inventory_Value DESC;

-- 5. Which authors have the highest inventory value?
SELECT
    Author,
    SUM(Price * Stock) AS Inventory_Value
FROM Books
GROUP BY Author
ORDER BY Inventory_Value DESC
LIMIT 10;

-- 6. Which books have high stock but low sales?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock >= 75
   AND COALESCE(SUM(o.Quantity), 0) <= 5
ORDER BY b.Stock DESC;

-- 7. Which books have low stock but high sales?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock <= 10
   AND SUM(o.Quantity) >= 10
ORDER BY Quantity_Sold DESC;

-- 8. Which books have never been ordered?
SELECT 
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Price,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;

-- 1. Which books are strong sellers and have low stock?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock <= 10
   AND SUM(o.Quantity) >= 10
ORDER BY Quantity_Sold DESC;

-- 2. Which books have high stock but low sales?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity),0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock >= 75
   AND COALESCE(SUM(o.Quantity),0) <= 5
ORDER BY b.Stock DESC;

-- 3. Which genres are popular but have relatively limited inventory?
SELECT
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue,
    SUM(b.Stock) AS Current_Stock
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;

-- 4. Who are the high-value customers?
SELECT
    c.Customer_ID,
    c.Name,
    c.Country,
    COUNT(o.Order_ID) AS Orders,
    SUM(o.Quantity) AS Quantity,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name, c.Country
ORDER BY Total_Spending DESC
LIMIT 10;

-- 5. Which books have strong demand?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    SUM(o.Quantity) AS Quantity_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- 6. Which books have never been ordered?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Price,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;

-- 7. Which customers buy from multiple genres?
SELECT
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Genres_Purchased
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) > 1
ORDER BY Genres_Purchased DESC;

-- 8. Which products may require promotional attention?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    COALESCE(SUM(o.Quantity),0) AS Quantity_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock >= 75
   AND COALESCE(SUM(o.Quantity),0) <= 5
ORDER BY b.Stock DESC;

-- 9. Which products may require replenishment?
SELECT
    b.Book_ID,
    b.Title,
    b.Genre,
    b.Stock,
    SUM(o.Quantity) AS Quantity_Sold,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre, b.Stock
HAVING b.Stock <= 10
   AND SUM(o.Quantity) >= 10
ORDER BY Quantity_Sold DESC;