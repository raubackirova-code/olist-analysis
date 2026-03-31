-- Business task: Identify top 10 customers by total revenue
-- Dataset: Olist e-commerce dataset
SELECT
    c.customer_unique_id,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC
LIMIT 10;