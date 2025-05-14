# **Library Management System - MySQL Database**  

## **Description**  
This project is a complete **Library Management System** built using MySQL. It allows tracking of books, authors, library members, and book loans with proper database relationships and constraints.  

### **Features**  
- **Books & Authors Management** – Store book details and author information.  
- **Member Tracking** – Keep records of library members.  
- **Loan Management** – Track borrowed books, due dates, and returns.  
- **Constraints & Validation** – Ensures data integrity with PRIMARY KEY, FOREIGN KEY, UNIQUE, and CHECK constraints.  
- **Optimized Queries** – Includes indexes and a current_loans view for better performance.  

---

## **Setup & Installation**  

### **Prerequisites**  
- MySQL Server (8.0+)  
- MySQL Client (CLI, Workbench, PHPMyAdmin, etc.)  

### **How to Run**  
1. **Clone the repository** (if using GitHub):  
   ```sh
   git clone https://github.com/yourusername/library-management-system.git
   cd library-management-system
   ```

2. **Import the SQL file into MySQL**:  
   - **Command Line Method**:  
     ```sh
     mysql -u your_username -p library_management < library_management.sql
     ```  
   - **MySQL Workbench / PHPMyAdmin**:  
     - Open the tool, create a new database named `library_management`.  
     - Use the "Import" feature to load `library_management.sql`.  

3. **Verify the database**:  
   ```sql
   USE library_management;
   SHOW TABLES;
   ```

---

## **Database Schema (ERD)**  

### **Tables & Relationships**  
| Table      | Description |
|------------|-------------|
| `authors`  | Stores author details (name, bio, nationality). |
| `books`    | Contains book info (title, ISBN, genre) linked to authors. |
| `members`  | Tracks library members (name, email, membership status). |
| `loans`    | Records book loans, due dates, and returns. |

### **ER Diagram**  
*(You can generate an ERD using tools like MySQL Workbench or dbdiagram.io and include a screenshot here.)*  

---

## **Sample Queries**  

### **Get all books by an author**  
```sql
SELECT b.title, b.publication_year 
FROM books b 
JOIN authors a ON b.author_id = a.author_id 
WHERE a.last_name = 'Rowling';
```

### **Check currently borrowed books**  
```sql
SELECT * FROM current_loans;
```

### **Find overdue books**  
```sql
SELECT m.first_name, m.last_name, b.title, l.due_date 
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.status = 'on loan' AND l.due_date < CURDATE();
```

---

## **License**  
This project is open-source and available under the MIT License.  

---

This README provides clear instructions for setup, database structure, and basic usage. You can expand it with additional details like contribution guidelines or more complex queries if needed.
