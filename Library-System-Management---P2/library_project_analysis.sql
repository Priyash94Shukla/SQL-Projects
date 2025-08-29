SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;
--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books (isbn, book_title,category,rental_price,status,author,publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
SELECT * FROM books;

--Task 2: Update an Existing Member's Address
UPDATE members
SET member_address='125 main st'
WHERE member_id = 'C101';
SELECT * FROM members;

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121';

SELECT * FROM issued_status; 

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT 
	issued_emp_id, issued_book_name 
FROM issued_status
WHERE 
	issued_emp_id = 'E101';


--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id, COUNT(issued_emp_id)
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_emp_id) >1;
SELECT * FROM issued_status;

--3. CTAS (Create Table As Select) 
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_issued_counts
AS (SELECT t1.isbn AS isbn,
	t1.book_title AS book_name, 
	COUNT(t2.issued_id) AS issued_counts
FROM books AS t1
JOIN issued_status AS t2
	ON t1.isbn = t2.issued_book_isbn
GROUP BY t1.isbn,t1.book_title);


--4. Data Analysis & Findings
--The following SQL queries were used to address specific questions:
--Task 7. Retrieve All Books in a Specific Category:
SELECT 
	category, 
	COUNT(book_title) 
FROM books
GROUP BY category;

--Task 8: Find Total Rental Income by Category:
SELECT * FROM books;
SELECT * FROM book_issued_counts;
SELECT t2.category,
SUM(t2.Rental_price)
FROM book_issued_counts AS t1
JOIN books AS t2
ON t1.isbn = t2.isbn
GROUP BY t2.category;


--Task 9. List Members Who Registered in the Last 180 Days:
INSERT INTO members(member_id, member_name,member_address,reg_date)
VALUES('C160','L.K.Crown','335 xyz st','2025-08-01');

SELECT * FROM members;
SELECT * 
FROM members
WHERE reg_date > CURRENT_DATE - INTERVAL '180';

--Task 10 List Employees with Their Branch Manager's Name and their branch details:
SELECT * FROM employees;
SELECT * FROM branch;

--Using Sub query

SELECT a.*, b.emp_name AS manager_name
FROM
(SELECT t1.emp_id AS emp, t2.*
FROM employees AS t1
JOIN branch AS t2
ON t1.branch_id = t2.branch_id
) AS a 
JOIN employees AS b
ON a.manager_id = b.emp_id;

--Using JOIN Twice 
SELECT 
	t1.emp_id, 
	t1.branch_id, 
	t1.salary,
	t2.*, 	
	a.emp_name AS manager
FROM employees AS t1
JOIN branch AS t2
ON t1.branch_id = t2.branch_id
JOIN employees AS a
ON a.emp_id = t2.manager_id;


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS
(SELECT book_title, Rental_price 
FROM books
WHERE Rental_price > 7);

SELECT * FROM expensive_books;

--Task 12: Retrieve the List of Books Not Yet Returned
SELECT a.issued_book_name
FROM issued_status AS a
LEFT JOIN return_status AS b
ON a.issued_id = b.issued_id
WHERE b.issued_id IS NULL;

-- Advance SQL Operations 
-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books. Display the member's_id, member's name, book title, issue date, and days overdue.
SELECT t3.member_id, t3.member_name,
	t1.issued_book_name, t1.issued_date,(CURRENT_DATE - t1.issued_date) AS Days_Overdue
FROM issued_status AS t1
LEFT JOIN return_status AS t2
ON t1.issued_id = t2.issued_id
JOIN members AS t3
ON t1.issued_member_id = t3.member_id
WHERE t2.issued_id IS NULL;

-- Task 14: Update Book Status on Return
-- Write a query to show the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

SELECT t1.book_title, t2.issued_date, t3.return_date,
CASE 
	WHEN t3.return_date IS NOT NULL THEN 'Yes'
	ELSE 'No' END AS if_book_is_returned
FROM books AS t1
LEFT JOIN issued_status AS t2
ON t1.isbn = t2.issued_book_isbn
LEFT JOIN return_status AS t3
ON t2.issued_id = t3.issued_id
WHERE t2.issued_date IS NOT NULL;

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
CREATE TABLE branch_report 
AS 
SELECT t4.branch_id, t4.manager_id,
		COUNT(t1.issued_id) AS number_book_issued,
		COUNT(t5.return_id) AS number_book_return,
		SUM(t6.Rental_price) AS total_revenue
FROM issued_status AS t1
JOIN employees AS t2
ON t1.issued_emp_id = t2.emp_id
JOIN branch AS t4
ON t2.branch_id = t4.branch_id
LEFT JOIN return_status AS t5
ON t5.issued_id = t1.issued_id
JOIN books AS t6
ON t1.issued_book_isbn = t6.isbn
GROUP BY 1,2;

SELECT * FROM branch_report;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
--    1. Using JOIN
CREATE TABLE active_members AS (
SELECT DISTINCT t1.*
FROM members AS t1
JOIN issued_status AS t2
ON t1.member_id = t2.issued_member_id
WHERE issued_date > CURRENT_DATE - INTERVAL '2 month');

--  2. Using Subquery
CREATE TABLE active_members AS
(
SELECT * FROM members
WHERE member_id IN (SELECT DISTINCT issued_member_id 
					FROM issued_status
					WHERE issued_date > CURRENT_DATE - INTERVAL '2 month')

);

-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

SELECT t1.emp_name,t3.branch_id AS branch, COUNT(t2.issued_id) AS number_book_issued
FROM employees AS t1
JOIN issued_status AS t2
ON t1.emp_id = t2.issued_emp_id
JOIN branch AS t3
ON t1.branch_id = t3.branch_id
GROUP BY t1.emp_name, t3.branch_id
ORDER BY COUNT(t2.issued_id) DESC 
LIMIT 3;



























