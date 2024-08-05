SELECT categories.category_name,
case
when order_details.unit_price < 10 then '1. BELOW 10'
when order_details.unit_price BETWEEN 10 AND 20 then '2. $10 - $20'
when order_details.unit_price BETWEEN 20 AND 50 THEN '3. $20 - $50'
when order_details.unit_price>50 THEN '4. OVER $50'
end as price_range,
CAST(SUM((order_details.unit_price- order_details.unit_price*order_details.discount)*order_details.quantity) AS DECIMAL(8,2)) AS total_amount
,COUNT(*) AS total_number_orders
from categories,order_details,products
WHERE categories.category_id=products.category_id
AND order_details.product_id=products.product_id
GROUP BY categories.category_name,price_range
ORDER BY categories.category_name,price_range ASC;