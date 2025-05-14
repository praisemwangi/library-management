-- Library Management System Database
-- This database tracks books, authors, members, and book loans

-- Create database
CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    biography TEXT,
    CONSTRAINT full_name_unique UNIQUE (first_name, last_name)
) COMMENT 'Stores information about book authors';

-- Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year INT,
    genre VARCHAR(50),
    quantity_available INT DEFAULT 1,
    location VARCHAR(50),
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
) COMMENT 'Contains all books in the library collection';

-- Members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('active', 'inactive') DEFAULT 'active'
) COMMENT 'Library members who can borrow books';

-- Loans table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE DEFAULT (CURRENT_DATE) NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('on loan', 'returned', 'overdue') DEFAULT 'on loan',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_due_date CHECK (due_date > loan_date)
) COMMENT 'Tracks all book loans and returns';

-- Create a view for currently borrowed books
CREATE VIEW current_loans AS
SELECT 
    m.first_name AS member_first,
    m.last_name AS member_last,
    b.title AS book_title,
    a.first_name AS author_first,
    a.last_name AS author_last,
    l.loan_date,
    l.due_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'on loan';

-- Create an index for faster book searches
CREATE INDEX idx_book_title ON books(title);
CREATE INDEX idx_author_name ON authors(last_name, first_name);