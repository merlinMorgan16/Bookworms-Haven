CREATE DATABASE Bookstore;
USE Bookstore;

-- Create the table for book inventory management
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(50),
    publication_year INT,
    price DECIMAL(10, 2) NOT NULL
);

-- Create the table for customer management
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    is_chapter_chaser BOOLEAN
);

-- Create the table for order management
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount_paid DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create the table for books in orders (order details)
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into Books table
INSERT INTO Books (book_id, title, author, genre, publication_year, price)
VALUES 
	(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 12.99),
    (2, 'Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 'Fantasy', 1997, 10.99),
    (3, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 9.99),
    (4, 'The Hunger Games', 'Suzanne Collins', 'Young Adult', 2008, 13.55),
    (5, '1984', 'George Orwell', 'Dystopian', 1949, 11.99),
    (6, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 7.99),
    (7, "Harry Potter and the Prisoner of Azkaban", 'J.K. Rowling', 'Fantasy', 1999, 10.99),
    (8, "Harry Potter and the Goblet of Fire", 'J.K. Rowling', 'Fantasy', 2000, 10.99);
    
-- Insert data into Customers table
INSERT INTO Customers (customer_id, full_name, email, phone_number, is_chapter_chaser)
VALUES 
	(1, 'Alice Johnson', 'alice@gmail.com', '123-456-7890', 1),
    (2, 'Michael Smith', 'michael@gmail.com', '555-987-6543', 0),
    (3, 'Emily Brown', 'emily@gmail.com', '655-456-3453', 1),
    (4, 'David Anderson', 'david@gmail.com', '555-234-2343', 1),
    (5, 'Sophia Martinez', 'sophia@gmail.com', '453-564-7623', 0);

-- Insert data into Orders table
INSERT INTO Orders (order_id, customer_id , total_amount_paid)
VALUES 
	(1, 1, 32.97),
    (2, 2, 13.55),
    (3, 3, 35.97),
    (4, 1, 12.99),
    (5, 4, 23.54),
    (6, 5, 7.99);
    
    
-- Insert data into OrderDetails table
INSERT INTO OrderDetails (order_detail_id, order_id, book_id, quantity, subtotal)
VALUES 
	(1, 1, 2, 1, 10.99),
    (2, 1, 7, 1, 10.99),
    (3, 1, 8, 1, 10.99),
    (4, 2, 4, 1, 13.55),
    (5, 3, 5, 3, 35.97),
    (6, 1, 1, 1, 12.99),
    (7, 4, 3, 1, 9.99),
    (8, 4, 4, 1, 13.55),
    (9, 6, 6, 1, 7.99);
    
    
    
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

    
-- Update the the phone number of Alice
SELECT * FROM Customers;
SET SQL_SAFE_UPDATES = 0;
UPDATE Customers SET Customers.phone_number = '789-123-4444' WHERE Customers.full_name = 'Alice Johnson';

-- Sum how many books are sold
SELECT 
	SUM(quantity) AS NumberOfBooksSold
FROM
	OrderDetails;

-- Sum total cost of all books sold
SELECT 
	SUM(total_amount_paid) AS SumOfAllPurchases
FROM
	Orders;
    
-- Count the number of chapter chasers
SELECT COUNT(*) AS TotalNumOfChapterChasers
FROM Customers
WHERE is_chapter_chaser = 1;

-- Count number of books that start with T
SELECT COUNT(title) AS NumOfBooksStart_T
FROM Books
WHERE title LIKE "T%";

-- Average price of the books
SELECT
	AVG(price) AS AvgPrice
FROM
	Books;
    
-- Book that was published first and last
SELECT MIN(publication_year), MAX(publication_year) FROM Books;

-- Total price of the book most sold
SELECT
b.book_id, b.title, o.subtotal
FROM Books AS b
LEFT JOIN OrderDetails AS o
ON b.book_id = o.book_id;

-- total price by book_id, ordered
SELECT book_id, SUM(subtotal)
FROM OrderDetails
GROUP BY book_id
ORDER BY SUM(subtotal) DESC;



