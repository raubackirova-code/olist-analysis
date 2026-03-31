-- Calculate monthly sales metrics for the Olist dataset.
-- Metrics include:
-- 1. Total revenue (price + freight_value)
-- 2. Number of delivered orders
-- 3. Average item price
-- Data is aggregated by order purchase month.

SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS revenue, 
    COUNT(DISTINCT oi.order_id) AS ordrs_count,
    round(AVG(oi.price),2) as avg_order
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 
     strftime('%Y-%m', o.order_purchase_timestamp)
ORDER BY  month;