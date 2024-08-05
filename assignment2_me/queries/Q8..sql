select c.category_name, p.product_name , p.unit_price , average_unit_price , median_unit_price ,
case when p.unit_price > average_unit_price then 'Over Average' 
	 when p.unit_price < average_unit_price then 'Below Average' 
	 else 'Average' end  as average_unit_price_position ,
case when p.unit_price > median_unit_price then 'Over Median' 
	 when p.unit_price < median_unit_price then 'Below Median' 
	 else 'Median' end  as median_unit_price_position
from categories c inner join products p on c.category_id = p.category_id 
inner join 
(
	select category_name  ,   CAST( avg(unit_price) AS DECIMAL(5, 2) ) as average_unit_price 
from categories c inner join products p on c.category_id = p.category_id   
 group by category_name 
) as table1 on table1.category_name = c.category_name
inner join
(SELECT category_name,  CAST( PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY unit_price) AS DECIMAL(5, 2) )  as median_unit_price
from categories c inner join products p on c.category_id = p.category_id GROUP by category_name)
as table2 on table2.category_name = c.category_name order by c.category_name, p.product_name asc