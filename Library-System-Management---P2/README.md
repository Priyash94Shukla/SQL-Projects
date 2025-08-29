# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
CREATE DATABASE library_db;

CREATE TABLE branch (
  branch_id VARCHAR(10) PRIMARY KEY, 
  manager_id VARCHAR(10), 
  branch_address VARCHAR(50), 
  contact_no VARCHAR(10)
);

CREATE TABLE employees (
  emp_id VARCHAR(10) PRIMARY KEY, 
  emp_name VARCHAR(25), 
  position VARCHAR(15), 
  salary INT, 
  branch_id VARCHAR(25) -- FK
  );

CREATE TABLE books (
  isbn VARCHAR(20) PRIMARY KEY, 
  book_title VARCHAR(75), 
  category VARCHAR(10), 
  rental_price FLOAT, 
  status VARCHAR(15), 
  author VARCHAR(35), 
  publisher VARCHAR(55)
);

CREATE TABLE members (
  member_id VARCHAR(10) PRIMARY KEY, 
  member_name VARCHAR(30), 
  member_address VARCHAR(75), 
  reg_date DATE
);

CREATE TABLE issued_status (
  issued_id VARCHAR(10) PRIMARY KEY, 
  issued_member_id VARCHAR(10), 
  -- FK
  issued_book_name VARCHAR(75), 
  issued_date DATE, 
  issued_book_isbn VARCHAR(25), 
  -- FK
  issued_emp_id VARCHAR(10) --FK
  );

CREATE TABLE return_status (
  return_id VARCHAR(10) PRIMARY KEY, 
  issued_id VARCHAR(10), 
  return_book_name VARCHAR(75), 
  return_date DATE, 
  return_book_isbn VARCHAR(20) -- FK
  );


```

### 2. Inserting Data in their respective tables

```sql

INSERT INTO members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM members;


-- Insert values into each branch table
INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM branch;


-- Insert values into each employees table
INSERT INTO employees(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM employees;


-- Inserting into books table 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt');


-- inserting into issued table
INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');


-- inserting into return table
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM issued_status;

```

### 3. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO books (
  isbn, book_title, category, rental_price, 
  status, author, publisher
) 
VALUES 
  (
    '978-1-60129-456-2', 'To Kill a Mockingbird', 
    'Classic', 6.00, 'yes', 'Harper Lee', 
    'J.B. Lippincott & Co.'
  ) 
SELECT 
  * 
FROM 
  books;
```
**Task 2: Update an Existing Member's Address**

```sql
UPDATE 
  members 
SET 
  member_address = '125 main st' 
WHERE 
  member_id = 'C101';
SELECT 
  * 
FROM 
  members;

```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM 
  issued_status 
WHERE 
  issued_id = 'IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT 
  issued_emp_id, 
  issued_book_name 
FROM 
  issued_status 
WHERE 
  issued_emp_id = 'E101';
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT 
  issued_emp_id, 
  COUNT(issued_emp_id) 
FROM 
  issued_status 
GROUP BY 
  issued_emp_id 
HAVING 
  COUNT(issued_emp_id) > 1;
SELECT 
  * 
FROM 
  issued_status;
```

### 4. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_counts**

```sql
CREATE TABLE book_issued_counts AS (
  SELECT 
    t1.isbn AS isbn, 
    t1.book_title AS book_name, 
    COUNT(t2.issued_id) AS issued_counts 
  FROM 
    books AS t1 
    JOIN issued_status AS t2 ON t1.isbn = t2.issued_book_isbn 
  GROUP BY 
    t1.isbn, 
    t1.book_title
);
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Category**:

```sql
SELECT 
  category, 
  COUNT(book_title) 
FROM 
  books 
GROUP BY 
  category;
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
SELECT 
  t2.category, 
  SUM(t2.Rental_price) 
FROM 
  book_issued_counts AS t1 
  JOIN books AS t2 ON t1.isbn = t2.isbn 
GROUP BY 
  t2.category;

```

9. **List Members Who Registered in the Last 180 Days**:
```sql
SELECT 
  * 
FROM 
  members 
WHERE 
  reg_date > CURRENT_DATE - INTERVAL '180';
```

10. **List Employees with Their Branch Manager's Name and their branch details**:


-- Using Sub query
```sql
SELECT 
  a.*, 
  b.emp_name AS manager_name 
FROM 
  (
    SELECT 
      t1.emp_id AS emp, 
      t2.* 
    FROM 
      employees AS t1 
      JOIN branch AS t2 ON t1.branch_id = t2.branch_id
  ) AS a 
  JOIN employees AS b ON a.manager_id = b.emp_id;

```

-- Using JOIN Twice  

```sql
SELECT 
  t1.emp_id, 
  t1.branch_id, 
  t1.salary, 
  t2.*, 
  a.emp_name AS manager 
FROM 
  employees AS t1 
  JOIN branch AS t2 ON t1.branch_id = t2.branch_id 
  JOIN employees AS a ON a.emp_id = t2.manager_id;

```

Task 11. **Create a Table of Books with Rental Price Above a 7**:
```sql
CREATE TABLE expensive_books AS (
  SELECT 
    book_title, 
    Rental_price 
  FROM 
    books 
  WHERE 
    Rental_price > 7
);
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT 
  a.issued_book_name 
FROM 
  issued_status AS a 
  LEFT JOIN return_status AS b ON a.issued_id = b.issued_id 
WHERE 
  b.issued_id IS NULL;
```

## Advanced SQL Operations

**Task 13: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

```sql
SELECT 
  t3.member_id, 
  t3.member_name, 
  t1.issued_book_name, 
  t1.issued_date, 
  (CURRENT_DATE - t1.issued_date) AS Days_Overdue 
FROM 
  issued_status AS t1 
  LEFT JOIN return_status AS t2 ON t1.issued_id = t2.issued_id 
  JOIN members AS t3 ON t1.issued_member_id = t3.member_id 
WHERE 
  t2.issued_id IS NULL;
```


**Task 14: Update Book Status on Return**  
 Write a query to show the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).


```sql
SELECT 
  t1.book_title, 
  t2.issued_date, 
  t3.return_date, 
  CASE WHEN t3.return_date IS NOT NULL THEN 'Yes' ELSE 'No' END AS if_book_is_returned 
FROM 
  books AS t1 
  LEFT JOIN issued_status AS t2 ON t1.isbn = t2.issued_book_isbn 
  LEFT JOIN return_status AS t3 ON t2.issued_id = t3.issued_id 
WHERE 
  t2.issued_date IS NOT NULL;
```
            
**Task 15: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

```sql
CREATE TABLE branch_report AS 
SELECT 
  t4.branch_id, 
  t4.manager_id, 
  COUNT(t1.issued_id) AS number_book_issued, 
  COUNT(t5.return_id) AS number_book_return, 
  SUM(t6.Rental_price) AS total_revenue 
FROM 
  issued_status AS t1 
  JOIN employees AS t2 ON t1.issued_emp_id = t2.emp_id 
  JOIN branch AS t4 ON t2.branch_id = t4.branch_id 
  LEFT JOIN return_status AS t5 ON t5.issued_id = t1.issued_id 
  JOIN books AS t6 ON t1.issued_book_isbn = t6.isbn 
GROUP BY 
  1, 
  2;
SELECT 
  * 
FROM 
  branch_report;

```

**Task 16: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

--    1. Using JOIN
```sql
CREATE TABLE active_members AS (
  SELECT 
    DISTINCT t1.* 
  FROM 
    members AS t1 
    JOIN issued_status AS t2 ON t1.member_id = t2.issued_member_id 
  WHERE 
    issued_date > CURRENT_DATE - INTERVAL '2 month'
);

SELECT
      *
FROM
      active_members
```
--  2. Using Subquery

```sql
CREATE TABLE active_members AS (
  SELECT 
    * 
  FROM 
    members 
  WHERE 
    member_id IN (
      SELECT 
        DISTINCT issued_member_id 
      FROM 
        issued_status 
      WHERE 
        issued_date > CURRENT_DATE - INTERVAL '2 month'
    );


SELECT
      *
FROM
      active_members;

```


**Task 17: Find Employees with the Most Book Issues Processed**  
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

```sql
SELECT 
  t1.emp_name, 
  t3.branch_id AS branch, 
  COUNT(t2.issued_id) AS number_book_issued 
FROM 
  employees AS t1 
  JOIN issued_status AS t2 ON t1.emp_id = t2.issued_emp_id 
  JOIN branch AS t3 ON t1.branch_id = t3.branch_id 
GROUP BY 
  t1.emp_name, 
  t3.branch_id 
ORDER BY 
  COUNT(t2.issued_id) DESC 
LIMIT 
  3;
```

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines

## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.   
2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.


Thank you for your interest in this project!

