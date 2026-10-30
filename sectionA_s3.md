**Answer:**

I would use a **scalar subquery** to calculate the overall average delivery time and compare it with each delivery agent's average delivery time.

**SQL Query:**

```sql
SELECT 
    agent_id,
    AVG(delivery_time) AS avg_delivery_time
FROM deliveries
GROUP BY agent_id
HAVING AVG(delivery_time) < (
    SELECT AVG(delivery_time)
    FROM deliveries
);
```

**Why use a scalar subquery?**

* A scalar subquery returns a single value: the overall average delivery time.
* The outer query calculates each agent's average delivery time.
* `HAVING` displays only agents whose average is faster than the overall average.

**What if we place the subquery in the SELECT clause?**

The query would calculate and display the overall average as an additional column, but it would not automatically filter out slower agents. We would still need `HAVING` or `WHERE` to filter the results.

**Conclusion:** A scalar subquery is appropriate because it returns one overall average value that can be compared with each agent's ave