**Answer:**

I would use `GROUP BY` to group orders by each restaurant and calculate total revenue and total orders. Then, I would use `HAVING` to display only restaurants that earned more than Rs 1,00,000 and received at least 50 orders last month.

==sql
SELECT 
    restaurant_id,
    SUM(order_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_date >= '2026-09-01'
  AND order_date < '2026-10-01'
GROUP BY restaurant_id
HAVING SUM(order_amount) > 100000
   AND COUNT(order_id) >= 50;

**Why use HAVING instead of WHERE?**

* `WHERE` filters individual rows before grouping.
* `GROUP BY` groups rows by restaurant.
* `HAVING` filters groups based on aggregate values like `SUM()` and `COUNT()`.

If I replace `HAVING` with `WHERE`, the query will produce an error because aggregate functions such as `SUM()` and `COUNT()` cannot normally be used in the `WHERE` clause.

Therefore, **HAVING is appropriate for filtering restaurants based on their total revenue and order count.**