# BookVerse Retail Business Intelligence & Sales Analytics

## Project Overview
BookVerse Retail Business Intelligence & Sales Analytics is a SQL-based data analysis project focused on understanding the business performance of an online and offline bookstore.

The project uses Books, Customers, and Orders datasets to analyze sales performance, customer purchasing behaviour, product performance, genre-wise revenue, and inventory levels using MySQL.

## Project Objectives
- Analyze overall sales performance and revenue.
- Identify top-selling books and authors.
- Analyze genre-wise sales and revenue.
- Identify high-value and repeat customers.
- Understand customer purchasing behaviour across countries.
- Analyze product performance and inventory levels.
- Identify low-stock and high-stock products.
- Find business opportunities for promotions and inventory replenishment.

## Tools & Technologies
- MySQL
- SQL
- MySQL Workbench
- CSV Dataset

## Database Structure
The project contains three relational tables:

1. **Books** – Stores book details such as title, author, genre, published year, price, and stock.
2. **Customers** – Stores customer information such as customer ID, name, email, phone, city, and country.
3. **Orders** – Stores order details such as order ID, customer ID, book ID, order date, quantity, and total amount.

Primary keys and foreign keys are used to establish relationships between the tables.

## SQL Concepts Used
- CREATE DATABASE and CREATE TABLE
- Primary Key and Foreign Key
- SELECT, WHERE and DISTINCT
- ORDER BY and LIMIT
- GROUP BY and HAVING
- Aggregate Functions (COUNT, SUM, AVG)
- INNER JOIN and LEFT JOIN
- Subqueries
- CASE WHEN
- Date Functions
- COALESCE

## Business Analysis
### 1. Sales Performance
- Total orders and revenue.
- Top revenue-generating books.
- Author-wise and genre-wise revenue.
- Monthly and yearly sales trends.

### 2. Customer Analysis
- Repeat customers.
- Highest-spending customers.
- Average customer spending.
- Country-wise sales performance.
- Customers purchasing across multiple genres.

### 3. Product & Genre Analysis
- Highest-selling books.
- Genre-wise sales volume.
- Author performance.
- Books with low sales.
- Books that have never been ordered.

### 4. Inventory Analysis
- Total stock and inventory value.
- Low-stock books.
- Inventory value by genre and author.
- High-stock books with low sales.
- High-demand books with low stock.

### 5. Business Opportunities
- Identify products requiring promotional attention.
- Identify products requiring replenishment.
- Find high-value customers.
- Identify books with strong sales demand.

## Repository Structure
```text
BookVerse-Retail-Sales-Analytics/
│
├── Dataset/
│   ├── Books.csv
│   ├── customers.csv
│   └── orders.csv
│
├── SQL-Queries/
│   └── BookVerse-SQL-Analysis.sql
│
├── Documentation/
│   ├── Project_Document.docx
│   └── Project_Presentation.pptx
│
└── README.md
```

## How to Run the Project
1. Install MySQL Workbench.
2. Download the datasets from the Dataset folder.
3. Open the SQL file in MySQL Workbench.
4. Execute the database creation and table creation queries.
5. Import the CSV datasets into their respective tables.
6. Execute the SQL analysis queries.
7. Review the query outputs to understand business performance.

## Project Outcome
This project demonstrates the use of MySQL and SQL for relational database creation, data exploration, business analysis, and generating insights related to sales, customers, products, and inventory management.

## Author
Greeshma Kolli

Aspiring Data Analyst
