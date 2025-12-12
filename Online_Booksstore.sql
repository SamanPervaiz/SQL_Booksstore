-- Create Database
CREATE DATABSE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_year INT,
	Price NUMERIC(10, 2),
	Stock INT
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--1 Retrieve all Books in the "Fiction" genre:

SELECT * FROM Books
WHERE Genre='Fiction';

-- 2) Find Books published after the year 1950:

SELECT * FROM Books
WHERE published_year>1950;

-- 3) list all customers from the canada:

SELECT * FROM Customers
WHERE Country='Canada';

-- 4) Show Orders placed in November

SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the Total stock of books available: 

SELECT SUM(stock) AS Total_stock
FROM Books;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books 
ORDER By Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more then 1 quantity of a book:
 SELECT * FROM Orders
 WHERE quantity>1;

 -- 8) Retrieve all Orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE total_amount>20;

-- 9) List all genre available in the books table:

SELECT DISTINCT genre FROM Books;

-- 10) Find the Book with the lowest stock:

SELECT * FROM Books
ORDER BY stock 
LIMIT 1;

-- 11) Calculate the Total revenue generated from all orders:

SELECT SUM(total_amount) AS Revenue
FROM Orders;

-- Advance Questions:

-- 1) Retrieve the total number of book sold for each genre:

SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Book_Sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the"Fantasy" genre:
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List Customers who have placed at least 2 orders:

SELECT o.Customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id) >=2;

-- 4)Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
Group BY o.Book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the Total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the Cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the Customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent DESC LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders;

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,
	b.stock-COALESCE(SUM(o.quantity),0) AS remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;










































































)














	
)