SELECT categories.category_name,suppliers.region AS supplier_region,
SUM(products.unit_in_stock)AS units_in_stock,
SUM(products.unit_on_order)AS units_on_order,
SUM(products.reorder_level) AS reorder_level
FROM categories,suppliers,products
WHERE categories.category_id=products.category_id
GROUP BY supplier_region,categories.category_name,reorder_level
ORDER BY supplier_region,categories.category_name,reorder_level ASC;