SELECT
DATE_TRUNC('month',order_date) AS year_month,
COUNT(order_id) AS total_number_orders,
TRUNC(SUM(freight)) AS total_freight
FROM orders
WHERE to_char(order_date,'YYYY') BETWEEN '1996' AND '1997'
GROUP BY DATE_TRUNC('month',order_date)
HAVING COUNT(order_id)>20 AND SUM(freight)>2500
ORDER BY total_freight DESC;