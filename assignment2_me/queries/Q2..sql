SELECT ship_country, CAST(avg(shipped_date::date - order_date::date)  AS DECIMAL(4, 2)) AS average_days_between_order_shipping
, count(*) as total_volume_orders
from orders
WHERE to_char(order_date,'YYYY')='1997'
GROUP BY ship_country
Having count(*)>5
ORDER BY average_days_between_order_shipping desc;