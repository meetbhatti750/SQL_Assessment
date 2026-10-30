-- task 1

CREATE DATABASE food_delivery_database;
USE food_delivery_database;

CREATE TABLE food_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    restaurant_name VARCHAR(100),
    item_ordered VARCHAR(100),
    quantity INT,
    price_per_item DECIMAL(10,2),
    order_date DATE,
    city VARCHAR(50)
);

INSERT INTO food_orders
(order_id, customer_name, restaurant_name, item_ordered,
 quantity, price_per_item, order_date, city)
VALUES
(1, 'Rahul Sharma', 'Pizza Palace', 'Pizza', 2, 450.00, '2026-10-01', 'Mumbai'),
(2, 'Priya Patel', 'Burger House', 'Burger', 3, 200.00, '2026-10-02', 'Ahmedabad'),
(3, 'Amit Shah', 'Spice Garden', 'Paneer Curry', 2, 350.00, '2026-10-03', 'Mumbai'),
(4, 'Neha Verma', 'Pizza Palace', 'Pasta', 1, 550.00, '2026-10-04', 'Delhi'),
(5, 'Karan Mehta', 'Biryani Point', 'Chicken Biryani', 2, 400.00, '2026-10-05', 'Mumbai'),
(6, 'Sneha Joshi', 'Burger House', 'Cheese Burger', 2, 250.00, '2026-10-06', 'Ahmedabad'),
(7, 'Rohit Singh', 'Spice Garden', 'Thali', 3, 300.00, '2026-10-07', 'Delhi'),
(8, 'Pooja Desai', 'Biryani Point', 'Veg Biryani', 1, 280.00, '2026-10-08', 'Mumbai'),
(9, 'Vikas Kumar', 'Pizza Palace', 'Family Pizza', 2, 700.00, '2026-10-09', 'Delhi'),
(10, 'Anjali Rao', 'South Food Cafe', 'Dosa', 2, 180.00, '2026-10-10', 'Mumbai');


SELECT *
FROM food_orders
WHERE city = 'Mumbai'
ORDER BY price_per_item DESC;

SELECT DISTINCT restaurant_name
FROM food_orders;

SELECT *
FROM food_orders
ORDER BY price_per_item DESC
LIMIT 5;

-- task 2

CREATE DATABASE restaurant_revenue_db;
USE restaurant_revenue_db;

CREATE TABLE delivery_orders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    total_amount DECIMAL(10,2),
    order_status VARCHAR(30),
    order_date DATE
);

INSERT INTO delivery_orders
(order_id, restaurant_name, city, total_amount, order_status, order_date)
VALUES
(1, 'Pizza Palace', 'Mumbai', 2500.00, 'Delivered', '2026-10-01'),
(2, 'Pizza Palace', 'Mumbai', 3000.00, 'Delivered', '2026-10-02'),
(3, 'Pizza Palace', 'Delhi', 6000.00, 'Delivered', '2026-10-03'),
(4, 'Burger House', 'Ahmedabad', 1500.00, 'Delivered', '2026-10-04'),
(5, 'Burger House', 'Ahmedabad', 2000.00, 'Delivered', '2026-10-05'),
(6, 'Burger House', 'Mumbai', 2500.00, 'Delivered', '2026-10-06'),
(7, 'Spice Garden', 'Delhi', 4000.00, 'Delivered', '2026-10-07'),
(8, 'Spice Garden', 'Mumbai', 3500.00, 'Delivered', '2026-10-08'),
(9, 'Spice Garden', 'Delhi', 4000.00, 'Delivered', '2026-10-09'),
(10, 'Biryani Point', 'Mumbai', 6000.00, 'Delivered', '2026-10-10'),
(11, 'Biryani Point', 'Delhi', 5500.00, 'Delivered', '2026-10-11'),
(12, 'Biryani Point', 'Ahmedabad', 4000.00, 'Delivered', '2026-10-12');

SELECT
    restaurant_name,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders,
    AVG(total_amount) AS average_order_value,
    CASE
        WHEN SUM(total_amount) > 10000
        THEN 'High Revenue'
        ELSE 'Moderate Revenue'
    END AS revenue_category
FROM delivery_orders
GROUP BY restaurant_name
HAVING SUM(total_amount) > 5000;

-- task 3

CREATE DATABASE customer_order_db;
USE customer_order_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine_type VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Mumbai', '9876543210'),
(2, 'Priya Patel', 'Ahmedabad', '9876543211'),
(3, 'Amit Shah', 'Delhi', '9876543212'),
(4, 'Neha Verma', 'Mumbai', '9876543213'),
(5, 'Karan Mehta', 'Pune', '9876543214'),
(6, 'Sneha Joshi', 'Ahmedabad', '9876543215');

INSERT INTO restaurants VALUES
(101, 'Pizza Palace', 'Italian', 'Mumbai'),
(102, 'Burger House', 'Fast Food', 'Ahmedabad'),
(103, 'Spice Garden', 'Indian', 'Delhi'),
(104, 'Biryani Point', 'Indian', 'Mumbai'),
(105, 'South Food Cafe', 'South Indian', 'Pune'),
(106, 'Chinese Corner', 'Chinese', 'Ahmedabad');

INSERT INTO orders VALUES
(1001, 1, 101, 800.00, '2026-10-01'),
(1002, 2, 102, 500.00, '2026-10-02'),
(1003, 3, 103, 1200.00, '2026-10-03'),
(1004, 4, 104, 900.00, '2026-10-04'),
(1005, 1, 102, 650.00, '2026-10-05'),
(1006, 5, 105, 700.00, '2026-10-06');

SELECT
    o.order_id,
    c.name AS customer_name,
    r.name AS restaurant_name,
    o.amount,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id;

SELECT
    c.customer_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.amount,
    o.order_date,
    r.name AS restaurant_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id;

SELECT
    o.order_id,
    c.name AS customer_name,
    c.city AS customer_city,
    r.name AS restaurant_name,
    r.city AS restaurant_city,
    o.amount,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
WHERE c.city = r.city;

-- task 4

CREATE DATABASE delivery_performance_db;
USE delivery_performance_db;

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    restaurant_name VARCHAR(100),
    delivery_time_mins INT,
    order_date DATE
);

INSERT INTO deliveries VALUES
(1, 'Rahul', 'Pizza Palace', 25, '2026-10-01'),
(2, 'Rahul', 'Burger House', 30, '2026-10-02'),
(3, 'Rahul', 'Spice Garden', 28, '2026-10-03'),
(4, 'Priya', 'Pizza Palace', 20, '2026-10-01'),
(5, 'Priya', 'Burger House', 22, '2026-10-02'),
(6, 'Priya', 'Biryani Point', 24, '2026-10-03'),
(7, 'Amit', 'Spice Garden', 40, '2026-10-01'),
(8, 'Amit', 'Pizza Palace', 38, '2026-10-02'),
(9, 'Neha', 'Burger House', 32, '2026-10-01'),
(10, 'Neha', 'Biryani Point', 35, '2026-10-02'),
(11, 'Neha', 'Spice Garden', 30, '2026-10-03'),
(12, 'Amit', 'Burger House', 42, '2026-10-04');

WITH agent_stats AS (
    SELECT
        agent_name,
        AVG(delivery_time_mins) AS avg_delivery_time
    FROM deliveries
    GROUP BY agent_name
)
SELECT
    agent_name,
    ROUND(avg_delivery_time, 2) AS avg_delivery_time,
    RANK() OVER (ORDER BY avg_delivery_time ASC) AS agent_rank,
    (
        SELECT AVG(delivery_time_mins)
        FROM deliveries
    ) AS platform_avg_time,
    CASE
        WHEN avg_delivery_time <= (
            SELECT AVG(delivery_time_mins)
            FROM deliveries
        )
        THEN 'On Track'
        ELSE 'Needs Improvement'
    END AS performance_status
FROM agent_stats
ORDER BY agent_rank;