-- EDA

SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM orders;
SELECT * FROM riders;
SELECT * FROM deliveries;

---Handeling null values
SELECT COUNT(*) FROM customers
WHERE customer_name IS NULL
OR reg_date IS NULL

SELECT COUNT(*) FROM restaurants
WHERE restaurant_name IS NULL
OR loc IS NULL
OR opening_hours IS NULL

SELECT * FROM orders
WHERE
	order_item IS NULL
	OR
	order_date IS NULL
	OR
	order_status IS NULL
	OR 
	total_amount IS NULL


SELECT * FROM deliveries
WHERE
	delivery_status IS NULL
	OR
	delivery_time IS NULL



----------------
-- Analysis & Report
----------------


-- 1. Top Selling Menu Items
-- Question: Find the top 10 dishes that generated the highest total revenue in the last 6 months.

SELECT 
    order_item,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY order_item
ORDER BY total_revenue DESC
LIMIT 10;


-- 2. Customer Retention Analysis
-- Question: Identify customers who have placed at least one order in each of the last 3 consecutive months.

-- 2. Customer Retention Analysis (last 3 consecutive months)
WITH monthly_orders AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month
    FROM orders
    WHERE order_date >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY customer_id, DATE_TRUNC('month', order_date)
)
SELECT customer_id
FROM monthly_orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_month) = 3;


-- 3. Restaurant Performance(current yr)
-- Question: Determine the top 5 restaurants with the highest average order value in the current year.

SELECT 
    r.restaurant_id,
    r.restaurant_name,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE DATE_PART('year', o.order_date) = DATE_PART('year', CURRENT_DATE)
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY avg_order_value DESC
LIMIT 5;



-- 4. Dish Popularity by Location
-- Question: Find the most frequently ordered dish in each location in the last quarter.

WITH dish_rank AS (
    SELECT 
        r.loc,
        o.order_item,
        COUNT(*) AS order_count,
        RANK() OVER (PARTITION BY r.loc ORDER BY COUNT(*) DESC) AS rank
    FROM orders o
    JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    WHERE o.order_date >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY r.loc, o.order_item
)
SELECT loc, order_item, order_count
FROM dish_rank
WHERE rank = 1;


-- 5. Delivery Time Efficiency
-- Question: Calculate the average delivery time per restaurant and identify the top 5 fastest.

SELECT 
    r.restaurant_id,
    r.restaurant_name,
    ROUND(AVG(EXTRACT(EPOCH FROM delivery_time))/60, 2) AS avg_delivery_minutes
FROM deliveries d
JOIN orders o ON d.order_id = o.order_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE d.delivery_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY avg_delivery_minutes ASC
LIMIT 5;

-- 6. High Value Customers(Lifetime spend > ₹50,000)
-- Question: List customers whose lifetime spend exceeds ₹50,000 along with their total order count.

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS lifetime_spend,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 50000
ORDER BY lifetime_spend DESC;
---------------------------------------------------------
-- 7. Order Cancellation Insights
-- Question: Identify the top 3 reasons for order cancellations in the past 12 months.

-- 8. Weekend vs Weekday Orders
-- Question: Compare the average number of orders placed on weekends vs weekdays in the last year.

-- 9. Seasonal Dish Trends
-- Question: Find dishes whose sales increased by at least 30% during the festive season compared to the rest of the year.
---------------------------------------------------------
-- 10. Cross-Selling Opportunities
-- Question: Identify dish combinations that are frequently ordered together (top 5 combos in last 90 days).

-- Assuming 'order_item' contains one dish per row; if multiple dishes per order, need a junction table.
WITH combos AS (
    SELECT 
        LEAST(o1.order_item, o2.order_item) AS dish1,
        GREATEST(o1.order_item, o2.order_item) AS dish2,
        COUNT(*) AS combo_count
    FROM orders o1
    JOIN orders o2 
      ON o1.order_id = o2.order_id 
     AND o1.order_item <> o2.order_item
    WHERE o1.order_date >= CURRENT_DATE - INTERVAL '90 days'
    GROUP BY LEAST(o1.order_item, o2.order_item), GREATEST(o1.order_item, o2.order_item)
)
SELECT dish1, dish2, combo_count
FROM combos
ORDER BY combo_count DESC
LIMIT 5;

------------------------------------------------------
-- 11. Monthly Active Customer Growth Rate
-- Goal: Calculate month-over-month % change in number of active customers.

WITH monthly_customers AS (
    SELECT 
        DATE_TRUNC('month', o.order_date) AS month,
        COUNT(DISTINCT o.customer_id) AS active_customers
    FROM orders o
    GROUP BY DATE_TRUNC('month', o.order_date)
),
growth AS (
    SELECT 
        month,
        active_customers,
        LAG(active_customers) OVER (ORDER BY month) AS prev_month_customers
    FROM monthly_customers
)
SELECT 
    month,
    active_customers,
    ROUND(
        ((active_customers - prev_month_customers)::NUMERIC / NULLIF(prev_month_customers, 0)) * 100, 
        2
    ) AS growth_percentage
FROM growth
ORDER BY month;

--------------------------------------------

-- 12. Restaurant Revenue Growth Trend
-- Goal: For each restaurant, compute monthly revenue growth % compared to the previous month.

WITH monthly_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(o.total_amount) AS total_revenue
    FROM orders o
    JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    GROUP BY r.restaurant_id, r.restaurant_name, DATE_TRUNC('month', o.order_date)
),
growth AS (
    SELECT 
        restaurant_id,
        restaurant_name,
        month,
        total_revenue,
        LAG(total_revenue) OVER (PARTITION BY restaurant_id ORDER BY month) AS prev_month_revenue
    FROM monthly_revenue
)
SELECT
    restaurant_id,
    restaurant_name,
    month,
    total_revenue,
    ROUND(
        ((total_revenue - prev_month_revenue)::NUMERIC / NULLIF(prev_month_revenue, 0)) * 100, 
        2
    ) AS revenue_growth_percentage
FROM growth
ORDER BY restaurant_id, month;

-- 13. Monthly Restaurant Growth Rate

WITH monthly_restaurants AS (
    SELECT 
        DATE_TRUNC('month', o.order_date) AS month,
        COUNT(DISTINCT o.restaurant_id) AS active_restaurants
    FROM orders o
    GROUP BY DATE_TRUNC('month', o.order_date)
),
growth_calc AS (
    SELECT 
        month,
        active_restaurants,
        LAG(active_restaurants) OVER (ORDER BY month) AS prev_month_restaurants
    FROM monthly_restaurants
)
SELECT 
    month,
    active_restaurants,
    prev_month_restaurants,
    ROUND(
        ((active_restaurants - prev_month_restaurants)::NUMERIC 
        / NULLIF(prev_month_restaurants, 0)) * 100, 2
    ) AS growth_rate_percent
FROM growth_calc
ORDER BY month;

-----------------------------------
--Q.14 Monthly Sales Trends:
--Identify sales trends by comparing each month's total sales to the previous month.

SELECT
	EXTRACT(YEAR FROM order_date) as year,
	EXTRACT(MONTH FROM order_date) as month,
	SUM(total_amount) as total_sale,
	LAG(SUM(total_amount), 1) OVER(ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT (MONTH FROM order_date)) as prev_month
FROM orders
GROUP BY 1, 2
--------------------------------------------------
	