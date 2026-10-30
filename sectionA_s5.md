**Answer:**

I would use `DENSE_RANK()` to rank the top 3 highest-revenue restaurants within each city because it does not skip ranking numbers when two restaurants have the same revenue.

**SQL Query:**

```sql
SELECT
    city,
    restaurant_name,
    total_revenue,
    DENSE_RANK() OVER (
        PARTITION BY city
        ORDER BY total_revenue DESC
    ) AS restaurant_rank
FROM restaurant_revenue;
```

**Difference between RANK() and DENSE_RANK():**

Suppose three restaurants in Surat have the following revenue:

| Restaurant   |   Revenue | RANK() | DENSE_RANK() |
| ------------ | --------: | -----: | -----------: |
| Restaurant A | ₹1,50,000 |      1 |            1 |
| Restaurant B | ₹1,20,000 |      2 |            2 |
| Restaurant C | ₹1,20,000 |      2 |            2 |
| Restaurant D | ₹1,00,000 |      4 |            3 |

* **RANK():** Skips the next rank after a tie. Restaurant D receives rank 4.
* **DENSE_RANK():** Does not skip ranks. Restaurant D receives rank 3.

**Why choose DENSE_RANK()?**

`DENSE_RANK()` provides continuous ranking numbers and includes restaurants with equal revenue at the same rank. This makes the report easier to understand.

**Practical impact:** If the product team wants the top 3 distinct revenue positions, `DENSE_RANK()` is appropriate. However, the report may include more than three restaurants because ties share the same rank.

**Conclusion:** I would choose `DENSE_RANK()` because it handles ties fairly without leaving gaps in the ranking.