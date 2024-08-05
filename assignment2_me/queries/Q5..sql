SELECT products.product_name,products.unit_price AS current_price,order_details.unit_price AS previous_unit_price,
(CAST(products.unit_price /order_details.unit_price  AS DECIMAL(3, 2) ) -1)* 100 as percentage_increase
from products,order_details
 WHERE order_details.product_id=products.product_id
 AND order_details.unit_price<products.unit_price
 AND (CAST(products.unit_price /order_details.unit_price  AS DECIMAL(3, 2) ) -1)* 100 not between 10 and 30
  order by percentage_increase asc ;