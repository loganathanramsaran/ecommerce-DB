-- Create the ecommerce database
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Create customers table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Create products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10 , 2 ),
    description TEXT
);

-- Create orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10 , 2 ),
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
);
-- Insert sample customers
INSERT INTO customers (name, email, address) VALUES
('Alice Smith', 'alice@example.com', '123 Elm St'),
('Bob Johnson', 'bob@example.com', '456 Oak St'),
('Carol White', 'carol@example.com', '789 Maple St');

-- Insert sample products
INSERT INTO products (name, price, description) VALUES
('Product A', 30.00, 'Description for Product A'),
('Product B', 25.00, 'Description for Product B'),
('Product C', 50.00, 'Description for Product C'),
('Product D', 75.00, 'Description for Product D');

-- Insert sample orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE() - INTERVAL 5 DAY, 80.00),
(2, CURDATE() - INTERVAL 40 DAY, 100.00),
(1, CURDATE() - INTERVAL 10 DAY, 160.00),
(3, CURDATE() - INTERVAL 3 DAY, 200.00);
-- 1. Retrieve all customers who have placed an order in the last 30 days
SELECT DISTINCT
    c.*
FROM
    customers c
        JOIN
    orders o ON c.id = o.customer_id
WHERE
    o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- 2. Get the total amount of all orders placed by each customer
SELECT 
    c.name, SUM(o.total_amount) AS total_spent
FROM
    customers c
        JOIN
    orders o ON c.id = o.customer_id
GROUP BY c.id;

-- 3. Update the price of Product C to 45.00
UPDATE products 
SET 
    price = 45.00
WHERE
    name = 'Product C';

-- 4. Add a new column discount to the products table
ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00;

-- 5. Retrieve the top 3 products with the highest price
SELECT 
    *
FROM
    products
ORDER BY price DESC
LIMIT 3;

-- 6. Get the names of customers who have ordered Product A
-- (Assuming we create a normalized order_items table in next steps)
-- We'll write this query after creating the `order_items` table.

SELECT 
    c.name AS customer_name, o.order_date
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.id;

-- 8. Retrieve the orders with a total amount greater than 150.00
SELECT 
    *
FROM
    orders
WHERE
    total_amount > 150.00;

-- Create order_items table to normalize the orders
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10 , 2 ),
    FOREIGN KEY (order_id)
        REFERENCES orders (id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
);

-- Sample order items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 30.00),  -- 2 x Product A
(1, 2, 1, 20.00),  -- 1 x Product B
(3, 3, 2, 50.00),  -- 2 x Product C
(4, 4, 2, 75.00);-- 2 x Product D
-- 6 (updated). Get the names of customers who have ordered Product A
SELECT DISTINCT
    c.name
FROM
    customers c
        JOIN
    orders o ON c.id = o.customer_id
        JOIN
    order_items oi ON o.id = oi.order_id
        JOIN
    products p ON oi.product_id = p.id
WHERE
    p.name = 'Product A';

-- 10. Retrieve the average total of all orders
SELECT 
    AVG(total_amount) AS average_order_total
FROM
    orders;
