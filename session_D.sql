USE fooddeliveryanalytics;

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    city VARCHAR(50),
    agent_id INT,
    agent_name VARCHAR(100),
    status VARCHAR(20),
    delivery_time_mins INT
);

INSERT INTO deliveries
(order_id, city, agent_id, agent_name, status, delivery_time_mins)
VALUES
(101, 'Ahmedabad', 1, 'Rahul', 'Completed', 25),
(102, 'Ahmedabad', 1, 'Rahul', 'Completed', 30),
(103, 'Ahmedabad', 1, 'Rahul', 'Completed', 28),
(104, 'Ahmedabad', 1, 'Rahul', 'Completed', 32),
(105, 'Ahmedabad', 1, 'Rahul', 'Completed', 27),
(106, 'Ahmedabad', 1, 'Rahul', 'Completed', 29),
(107, 'Ahmedabad', 2, 'Amit', 'Completed', 20),
(108, 'Ahmedabad', 2, 'Amit', 'Completed', 22),
(109, 'Ahmedabad', 2, 'Amit', 'Completed', 24),
(110, 'Ahmedabad', 2, 'Amit', 'Completed', 26),
(111, 'Ahmedabad', 2, 'Amit', 'Completed', 23),
(112, 'Ahmedabad', 2, 'Amit', 'Completed', 21),
(113, 'Ahmedabad', 3, 'Priya', 'Completed', 35),
(114, 'Ahmedabad', 3, 'Priya', 'Completed', 32),
(115, 'Ahmedabad', 3, 'Priya', 'Completed', 30),
(116, 'Ahmedabad', 3, 'Priya', 'Completed', 34),
(117, 'Ahmedabad', 3, 'Priya', 'Completed', 33),
(118, 'Ahmedabad', 3, 'Priya', 'Completed', 31),
(119, 'Surat', 4, 'Neha', 'Completed', 25),
(120, 'Surat', 4, 'Neha', 'Completed', 28),
(121, 'Surat', 4, 'Neha', 'Completed', 30),
(122, 'Surat', 4, 'Neha', 'Completed', 27),
(123, 'Surat', 4, 'Neha', 'Completed', 26),
(124, 'Surat', 4, 'Neha', 'Completed', 29),
(125, 'Surat', 5, 'Karan', 'Completed', 18),
(126, 'Surat', 5, 'Karan', 'Completed', 20),
(127, 'Surat', 5, 'Karan', 'Completed', 22),
(128, 'Surat', 5, 'Karan', 'Completed', 19),
(129, 'Surat', 5, 'Karan', 'Completed', 21),
(130, 'Surat', 5, 'Karan', 'Completed', 23);

WITH agent_stats AS (
    SELECT
        city,
        agent_id,
        agent_name,
        COUNT(order_id) AS completed_orders,
        AVG(delivery_time_mins) AS avg_delivery_time
    FROM deliveries
    WHERE status = 'Completed'
    GROUP BY city, agent_id, agent_name
    HAVING COUNT(order_id) > 5
),
ranked_agents AS (
    SELECT
        city,
        agent_id,
        agent_name,
        completed_orders,
        ROUND(avg_delivery_time, 2) AS avg_delivery_time,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY completed_orders DESC, agent_id ASC
        ) AS agent_rank
    FROM agent_stats
)
SELECT
    city,
    agent_id,
    agent_name,
    completed_orders,
    avg_delivery_time,
    agent_rank
FROM ranked_agents
WHERE agent_rank <= 3
ORDER BY city ASC, agent_rank ASC;