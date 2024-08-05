select table1.category_name as catagory_name , 
concat(first_name , ' ', last_name) as employee_full_name ,
CAST( table1.c2 AS DECIMAL(10, 2) ) as total_sale_amount ,
CAST( (table1.c2 * 100) / table3.c2 as Decimal(11, 5)) as percent_of_category_sales ,
CAST((table1.c2 * 100) / table2.c2 AS DECIMAL(10, 5)) as percentage_of_employee_sales 
from employees e inner join 
(select e.employee_id , c.category_name ,  sum((od.unit_price - (od.unit_price * od.discount)) * od.quantity ) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id inner join products p on
 p.product_id  = od.product_id inner join  categories c on c.category_id = p.category_id
 group by e.employee_id , c.category_name ) as table1 on table1.employee_id = e.employee_id inner join 
(select e.employee_id , sum((od.unit_price - (od.unit_price * od.discount)) * od.quantity ) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id group by e.employee_id ) as table2 on table2.employee_id = e.employee_id inner join 
(select c.category_name , sum((od.unit_price - (od.unit_price * od.discount)) * od.quantity ) as c2
from employees e inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id inner join products p on  p.product_id  = od.product_id inner join  categories c on c.category_id = p.category_id  group by c.category_name ) as table3 on table3.category_name = table1.category_name  order by catagory_name asc , total_sale_amount desc