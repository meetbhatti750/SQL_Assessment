CREATE DATABASE IF NOT EXISTS FoodDeliveryAnalytics;
USE FoodDeliveryAnalytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO customers VALUES
(1, 'meet bhatti', 'Ahmedabad', '9876500001'),
(2, 'Rahul Patel', 'Ahmedabad', '9876500002'),
(3, 'Priya Shah', 'Surat', '9876500003'),
(4, 'Amit Desai', 'Surat', '9876500004'),
(5, 'Neha Joshi', 'Vadodara', '9876500005'),
(6, 'Karan Mehta', 'Vadodara', '9876500006'),
(7, 'Riya Parmar', 'Ahmedabad', '9876500007'),
(8, 'Jay Trivedi', 'Surat', '9876500008'),
(9, 'Pooja Dave', 'Vadodara', '9876500009'),
(10, 'Vikas Modi', 'Ahmedabad', '9876500010');



CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine VARCHAR(50)
);

INSERT INTO restaurants VALUES
(1, 'Spice Garden', 'Ahmedabad', 'Indian'),
(2, 'Pizza Hub', 'Ahmedabad', 'Italian'),
(3, 'Burger Point', 'Ahmedabad', 'Fast Food'),
(4, 'Royal Dine', 'Ahmedabad', 'Indian'),
(5, 'Surat Food House', 'Surat', 'Gujarati'),
(6, 'Ocean Treat', 'Surat', 'Seafood'),
(7, 'Street Bites', 'Surat', 'Fast Food'),
(8, 'Vadodara Kitchen', 'Vadodara', 'Indian'),
(9, 'Green Leaf Cafe', 'Vadodara', 'Healthy Food'),
(10, 'Royal Pizza', 'Vadodara', 'Italian');



CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO delivery_agents VALUES
(1, 'Arjun Singh', 'Ahmedabad', '9000000001'),
(2, 'Ravi Kumar', 'Ahmedabad', '9000000002'),
(3, 'Deepak Patel', 'Surat', '9000000003'),
(4, 'Mohit Shah', 'Surat', '9000000004'),
(5, 'Suresh Mehta', 'Vadodara', '9000000005'),
(6, 'Nitin Joshi', 'Vadodara', '9000000006'),
(7, 'Vijay Parmar', 'Ahmedabad', '9000000007'),
(8, 'Aakash Dave', 'Surat', '9000000008'),
(9, 'Rohan Desai', 'Vadodara', '9000000009'),
(10, 'Kunal Modi', 'Ahmedabad', '9000000010');



CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    agent_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    delivery_time_mins INT NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (agent_id)
        REFERENCES delivery_agents(agent_id)
);

INSERT INTO orders VALUES
(1, 1, 1, 1, CURDATE() - INTERVAL 1 DAY, 1800, 30),
(2, 1, 2, 2, CURDATE() - INTERVAL 2 DAY, 2200, 35),
(3, 1, 3, 7, CURDATE() - INTERVAL 3 DAY, 1600, 25),
(4, 2, 1, 1, CURDATE() - INTERVAL 4 DAY, 1200, 28),
(5, 2, 2, 2, CURDATE() - INTERVAL 5 DAY, 1500, 32),
(6, 3, 5, 3, CURDATE() - INTERVAL 1 DAY, 2500, 40),
(7, 3, 6, 4, CURDATE() - INTERVAL 2 DAY, 1800, 35),
(8, 4, 5, 3, CURDATE() - INTERVAL 3 DAY, 1300, 30),
(9, 4, 7, 8, CURDATE() - INTERVAL 4 DAY, 900, 25),
(10, 5, 8, 5, CURDATE() - INTERVAL 1 DAY, 3000, 35),
(11, 5, 9, 6, CURDATE() - INTERVAL 2 DAY, 2500, 30),
(12, 6, 8, 5, CURDATE() - INTERVAL 3 DAY, 1800, 28),
(13, 6, 10, 9, CURDATE() - INTERVAL 4 DAY, 1200, 32),
(14, 7, 1, 7, CURDATE() - INTERVAL 5 DAY, 1400, 25),
(15, 7, 2, 10, CURDATE() - INTERVAL 6 DAY, 1100, 30),
(16, 8, 5, 4, CURDATE() - INTERVAL 7 DAY, 1600, 35),
(17, 8, 6, 8, CURDATE() - INTERVAL 8 DAY, 2000, 38),
(18, 9, 8, 6, CURDATE() - INTERVAL 9 DAY, 1700, 27),
(19, 10, 1, 1, CURDATE() - INTERVAL 1 DAY, 2100, 29),
(20, 10, 2, 2, CURDATE() - INTERVAL 2 DAY, 1900, 31),
(21, 1, 1, 7, CURDATE() - INTERVAL 3 DAY, 1000, 26),
(22, 2, 1, 10, CURDATE() - INTERVAL 4 DAY, 900, 24),
(23, 3, 5, 3, CURDATE() - INTERVAL 5 DAY, 1100, 33),
(24, 5, 8, 5, CURDATE() - INTERVAL 6 DAY, 1300, 29),
(25, 7, 1, 1, CURDATE() - INTERVAL 7 DAY, 800, 22);



SELECT
    r.restaurant_name,
    r.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_amount) AS total_revenue,
    AVG(o.order_amount) AS average_order_amount
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    r.city
HAVING COUNT(o.order_id) > 3
ORDER BY total_revenue DESC;



SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(o.order_amount), 0) AS total_spend,
    CASE
        WHEN COALESCE(SUM(o.order_amount), 0) > 5000
            THEN 'Platinum'
        WHEN COALESCE(SUM(o.order_amount), 0) >= 2000
            THEN 'Gold'
        ELSE 'Standard'
    END AS customer_segment
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC;



WITH restaurant_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        r.city,
        SUM(o.order_amount) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    GROUP BY
        r.restaurant_id,
        r.restaurant_name,
        r.city
),
ranked_restaurants AS (
    SELECT
        restaurant_name,
        city,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY city
            ORDER BY total_revenue DESC
        ) AS restaurant_rank
    FROM restaurant_revenue
)
SELECT
    restaurant_name,
    city,
    total_revenue,
    restaurant_rank
FROM ranked_restaurants
WHERE restaurant_rank <= 3
ORDER BY city, restaurant_rank;



WITH customer_orders AS (
    SELECT
        c.customer_name,
        o.order_id,
        o.order_date,
        o.order_amount,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_id
            ORDER BY o.order_date DESC, o.order_id DESC
        ) AS row_num
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)
SELECT
    customer_name,
    order_id,
    order_date,
    order_amount
FROM customer_orders
WHERE row_num = 1
ORDER BY customer_name;



CREATE OR REPLACE VIEW vw_daily_order_summary AS
SELECT
    o.order_date,
    c.customer_name,
    r.restaurant_name,
    da.agent_name,
    o.order_amount,
    o.delivery_time_mins
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN delivery_agents da
    ON o.agent_id = da.agent_id;



SELECT
    order_date,
    customer_name,
    restaurant_name,
    agent_name,
    order_amount,
    delivery_time_mins
FROM vw_daily_order_summary
WHERE order_date >= CURDATE() - INTERVAL 6 DAY
  AND order_date < CURDATE() + INTERVAL 1 DAY
ORDER BY order_date DESC;