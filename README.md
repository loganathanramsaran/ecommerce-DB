# 🛒 E-Commerce Database (MySQL)

This project implements a simple relational database for an e-commerce system using **MySQL**. It includes schema creation, sample data insertion, key SQL queries, and normalization for scalability.

## 📦 Features

- Create and manage customers, products, and orders
- Track which customers placed which orders
- Normalized schema with `order_items` table for detailed order breakdown
- Sample SQL queries to analyze and update data

---

## 🗃️ Database Schema

### 1. **customers**
| Column     | Type         | Description                     |
|------------|--------------|---------------------------------|
| id         | INT, PK      | Unique customer ID              |
| name       | VARCHAR(100) | Customer name                   |
| email      | VARCHAR(100) | Customer email                  |
| address    | VARCHAR(255) | Customer address                |

### 2. **products**
| Column     | Type         | Description                     |
|------------|--------------|---------------------------------|
| id         | INT, PK      | Unique product ID               |
| name       | VARCHAR(100) | Product name                    |
| price      | DECIMAL      | Product price                   |
| description| TEXT         | Product description             |
| discount   | DECIMAL      | Optional discount (default 0)   |

### 3. **orders**
| Column      | Type         | Description                   |
|-------------|--------------|-------------------------------|
| id          | INT, PK      | Unique order ID               |
| customer_id | INT, FK      | Linked customer               |
| order_date  | DATE         | Date the order was placed     |
| total_amount| DECIMAL      | Total order amount            |

### 4. **order_items** *(Normalized)*
| Column     | Type         | Description                     |
|------------|--------------|---------------------------------|
| id         | INT, PK      | Unique order item ID            |
| order_id   | INT, FK      | Linked order                    |
| product_id | INT, FK      | Linked product                  |
| quantity   | INT          | Number of units                 |
| price      | DECIMAL      | Price at time of purchase       |

---

## 🧪 Sample SQL Queries

- Customers who placed orders in the last 30 days
- Total spending by each customer
- Update product prices
- Add new fields (e.g., discount)
- Top 3 most expensive products
- Customers who ordered a specific product
- Join customer names with order details
- Orders with high total amounts
- Average value of all orders

---

## 🏁 Getting Started

1. Make sure MySQL is installed and running.
2. Copy and run the SQL script (`ecommerce.sql`) in your MySQL client.
3. Use `USE ecommerce;` to switch to the correct database.
4. Run individual queries to explore data.

---

## 🛠️ Tools Used

- **MySQL** for database engine
- Any MySQL client (MySQL Workbench, phpMyAdmin, or CLI)

---

## ✅ Future Improvements

- Add `categories` table for product classification
- Implement `order_status` (pending, shipped, etc.)
- Include user authentication in app layer (if integrated into a full app)

---


