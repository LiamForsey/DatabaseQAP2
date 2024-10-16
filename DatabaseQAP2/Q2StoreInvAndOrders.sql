-- Problem 2: Store inventory and Orders --

-- Liam Forsey, October 15th, 2024 --

-- Creating The Tables: --


-- Products Table --
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL
);

-- Customers Table --
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Orders Table --
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Order_items Table --
CREATE TABLE IF NOT EXISTS order_items (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- INSERT data into the PRODUCTS table
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Smartphone Pro', 699.99, 120),
('Laptop Ultra', 1299.99, 45),
('Wireless Earbuds', 149.99, 200),
('Portable Charger', 29.99, 90),
('4K TV', 499.99, 25);

-- INSERT data into the CUSTOMERS table
INSERT INTO customers (first_name, last_name, email) VALUES
('Evelyn', 'Smith', 'evelyn.smith@store.com'),
('Jack', 'Johnson', 'jack.johnson@store.com'),
('Olivia', 'Williams', 'olivia.williams@store.com'),
('Liam', 'Brown', 'liam.brown@store.com');

-- INSERT data into the ORDERS table
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-10-06'),  -- Evelyn Smith
(2, '2024-10-07'),  -- Jack Johnson
(1, '2024-10-08'),  -- Evelyn Smith
(3, '2024-10-09'),  -- Olivia Williams
(4, '2024-10-10');  -- Liam Forsey

-- INSERT data into the ORDER_ITEMS table
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Evelyn orders 1 Smartphone Pro
(1, 4, 2),  -- Evelyn orders 2 Portable Chargers
(2, 2, 1),  -- Jack orders 1 Laptop 
(2, 3, 3),  -- Jack orders 3 Wireless Earbuds
(3, 5, 1),  -- Evelyn orders 1 4K TV
(4, 1, 2),  -- Olivia orders 2 Smartphone Pros
(5, 2, 1);  -- Liam orders 1 Laptop


-- 1. Retrieve names and stock quantities of all products
SELECT
    product_name,
    stock_quantity
FROM
    products;

-- 2. Retrieve product names and quantities for a specific order (Order ID 1)
SELECT
    p.product_name,
    oi.quantity
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.id
WHERE
    oi.order_id = 1;

-- 3. Retrieve all orders placed by a specific customer (Customer ID 1)
SELECT
    o.id AS order_id,
    o.order_date,
    oi.product_id,
    oi.quantity
FROM
    orders o
JOIN
    order_items oi ON o.id = oi.order_id
WHERE
    o.customer_id = 1;


-- reducing stock quantities after order ID 1
UPDATE products
SET stock_quantity = stock_quantity - 1  -- Smartphone Pro
WHERE id = 1;

UPDATE products
SET stock_quantity = stock_quantity - 2  -- Portable Charger
WHERE id = 4;

-- Verify the stock quantity update
SELECT * FROM products;


-- Remove order ID 2 and associated order items
DELETE FROM order_items
WHERE order_id = 2;

DELETE FROM orders
WHERE id = 2;

-- Verify the deletion
SELECT * FROM orders;
SELECT * FROM order_items;
