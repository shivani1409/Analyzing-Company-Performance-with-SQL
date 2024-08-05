SELECT product_name, unit_price
FROM
products
WHERE
unit_price BETWEEN 10 AND 50
AND discontinued <> '1'
ORDER BY product_name ASC;
