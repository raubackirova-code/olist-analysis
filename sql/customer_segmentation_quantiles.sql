Описание:
Этот SQL-запрос выполняет сегментацию клиентов на основе их суммарных расходов 
и рассчитывает вклад каждого сегмента в общую выручку и долю клиентов.

Этапы запроса:
1. customer_revenue — вычисление общей выручки (price + freight_value) для каждого клиента по доставленным заказам.
2. ranked — ранжирование клиентов по выручке и подсчет общего числа клиентов с помощью оконных функций.
3. segmented — сегментация клиентов на три группы: 
   - Regular (80% с наименьшей выручкой)
   - Silver (следующие 15%)
   - Gold (топ 5% по выручке)
4. total_rev_cust — подсчет общей выручки и общего числа уникальных клиентов для расчета долей.
5. Финальный SELECT — агрегирование данных по сегментам:
   - segment_revenue: суммарная выручка сегмента
   - revenue_share: доля сегмента в общей выручке (%)
   - customer_share: доля клиентов сегмента в общей базе (%)

Особенности:
- Используются оконные функции ROW_NUMBER() и COUNT() OVER() для сегментации.
- Деление целых чисел безопасно благодаря CAST(... AS FLOAT) для получения точного процента.
- CROSS JOIN с total_rev_cust позволяет использовать общие показатели для всех сегментов.

-- Business task: Segment customers based on total revenue and analyze revenue & customer share by segment
-- Dataset: Olist e-commerce dataset
-- Description: 
--   1. Calculate total revenue per customer from delivered orders
--   2. Rank customers by revenue and determine total number of customers
--   3. Segment customers into Regular (bottom 80%), Silver (next 15%), and Gold (top 5%)
--   4. Compute total revenue and total number of customers for all segments
--   5. Aggregate results by segment to get:
--        - segment_revenue: sum of revenue per segment
--        - revenue_share: % of total revenue
--        - customer_share: % of total customers
-- Notes:
--   - Uses ROW_NUMBER() and COUNT() OVER() for ranking and segmentation
--   - CAST to FLOAT ensures correct percentage calculations
--   - CROSS JOIN with total revenue/customer counts allows segment-level share computation

WITH customer_revenue AS (
SELECT
    c.customer_unique_id,
    SUM(oi.price + oi.freight_value) AS revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
),
ranked AS (
SELECT
    customer_unique_id,
    revenue,
    ROW_NUMBER() OVER (ORDER BY revenue) AS rn,
    COUNT(*) OVER () AS total_customers
FROM customer_revenue
),
segmented AS (
SELECT
    customer_unique_id,
    revenue,
    CASE
        WHEN rn <= total_customers * 0.8 THEN 'Regular'
        WHEN rn <= total_customers * 0.95 THEN 'Silver'
        ELSE 'Gold'
    END AS segment
FROM ranked
)
, total_rev_cust as (
select sum(oi.price + oi.freight_value) as tot_rev,count(distinct c.customer_unique_id) tot_cust
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
)
SELECT
    segment,
    SUM(revenue) AS segment_revenue, round(SUM(revenue)/tot_rev*100,2) as revenue_share, 
    round(CAST(COUNT(*) AS FLOAT)/tot_cust*100,2) as customer_share
FROM segmented
cross join total_rev_cust
GROUP BY segment
order by segment_revenue desc;