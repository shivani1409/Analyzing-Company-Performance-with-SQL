select concat(e.first_name ,' ', e.last_name) as employee_full_name , 
title as employee_title , 
CAST( C.c2 AS DECIMAL(10, 2) ) as total_sale_amount_excluding_discount ,
D.c2 as number_unique_orders,
E1.c2 as number_orders ,
CAST( F.c2 AS DECIMAL(10, 2) ) as average_product_amount,
CAST( G.c2 AS DECIMAL(10, 2) ) as average_order_amount ,
CAST( H.c2 AS DECIMAL(10, 2) ) as total_discount_amount ,
CAST( I.c2 AS DECIMAL(10, 2) ) as total_sale_amount_including_discount , 
CAST( J.c2 AS DECIMAL(10, 2) ) as total_discount_percentage
from employees e inner join 
(select e.employee_id , sum(od.quantity * od.unit_price) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as C 
on e.employee_id = C.employee_id inner join
(select e.employee_id , count(*) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as E1
on e.employee_id = E1.employee_id inner join
(select e.employee_id , avg(od.unit_price) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as G
on e.employee_id = G.employee_id inner join
(select e.employee_id , avg(p.unit_price) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id inner join products p on
 p.product_id  = od.product_id group by e.employee_id ) as F
on e.employee_id = F.employee_id inner join
(select e.employee_id , sum(od.unit_price*od.discount) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as H
on e.employee_id = H.employee_id inner join
(select e.employee_id , sum( (od.unit_price - (od.unit_price*od.discount)) * od.quantity ) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as I
on e.employee_id = I.employee_id inner join
(select e.employee_id , (sum(od.unit_price* od.discount) * 100 )/ sum(od.unit_price ) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id) as J
on e.employee_id = J.employee_id inner join
(select p1 as employee_id , count(*) as c2 from (select distinct e.employee_id p1 , p.product_id as p2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id inner join products p on
 p.product_id  = od.product_id) as table1 group by p1 ) as D
on e.employee_id = D.employee_id order by total_sale_amount_including_discount desc