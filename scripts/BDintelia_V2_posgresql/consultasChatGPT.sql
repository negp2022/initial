SELECT t.id AS transaction_id, t.begin_time, t.total, t.customer_id
FROM transaction t
JOIN transaction_type tt ON t.transaction_type_id = tt.id
WHERE tt.name = 'Venta' 
AND t.begin_time >= '2024-07-01' AND t.begin_time <= '2024-07-31';

/*Solicitud del usuario: "Necesito un informe de ventas de productos. Quiero sumar las ventas, mostrando el nombre del producto, cantidad vendida e ingresos totales. 
 * Solo para productos del mes de julio. Agrupa por producto, ordena de mayor a menor ingreso y muestra los 2 principales" */
--sin devoluciones cargadas

SELECT 
    p.name AS product_name,
    SUM(td.quantity) AS total_quantity_sold,
    SUM(td.subtotal) AS total_income
FROM 
    transaction t
JOIN 
    transaction_detail td ON t.id = td.id_transaction
JOIN 
    product p ON td.product_id = p.id
WHERE 
    t.begin_time >= '2024-07-01' AND t.begin_time < '2024-08-01'
GROUP BY 
    p.name
ORDER BY 
    total_income DESC
LIMIT 2;



/*Solicitud del usuario: "Necesito un informe de ventas de productos. Quiero sumar las ventas, mostrando el nombre del producto, cantidad vendida e ingresos totales. 
 * Solo para productos del mes de julio. Agrupa por producto, ordena de mayor a menor ingreso y muestra los 2 principales"*/

SELECT p.name AS product_name, 
       SUM(td.quantity) AS total_quantity_sold, 
       SUM(td.subtotal) AS total_income
FROM transaction t
JOIN transaction_detail td ON t.id = td.id_transaction
JOIN product p ON td.product_id = p.id
WHERE t.begin_time >= '2024-07-01 00:00:00'
  AND t.end_time <= '2024-07-31 23:59:59'
GROUP BY p.name
ORDER BY total_income desc
LIMIT 2;

/* Solicitud del usuario: "Necesito un informe de devoluciones de productos. Quiero sumar las devoluciones, mostrando el nombre del producto, cantidad devuelta y totales. 
 * Solo para productos del mes de julio. Agrupa por producto, ordena de mayor a menor subtotal y muestra los 2 principales" */

SELECT 
    p.name AS product_name,
    SUM(td.quantity) AS total_returned_quantity,
    SUM(td.subtotal) AS total_returned_amount
FROM 
    transaction t
JOIN 
    transaction_detail td ON t.id = td.id_transaction
JOIN 
    product p ON td.product_id = p.id
JOIN 
    transaction_type tt ON t.transaction_type_id = tt.id
WHERE 
    tt.code = '2' -- Código para devoluciones
    AND t.begin_time >= '2024-07-01 00:00:00'
    AND t.end_time <= '2024-07-31 23:59:59'
GROUP BY 
    p.name
ORDER BY 
    total_returned_amount DESC
LIMIT 2;


/* Solicitud del usuario: "Necesito un informe de ventas de productos. Quiero sumar las ventas, mostrando el nombre del producto, cantidad vendida e ingresos totales. 
 Solo para productos del mes de julio. Agrupa por producto, ordena de mayor a menor ingreso y muestra los 2 principales"*/
-- con devolución cargada y consideraciones


SELECT 
    p.code AS product_code,
    p.name AS product_name,
    SUM(td.quantity) AS total_quantity_sold,
    SUM(td.subtotal - COALESCE(td.total_discount, 0) - COALESCE(td.total_promo, 0)) AS total_revenue
FROM 
    transaction t
JOIN 
    transaction_detail td ON t.id = td.id_transaction
JOIN 
    product p ON td.product_id = p.id
JOIN 
    transaction_type tt ON t.transaction_type_id = tt.id
WHERE 
    tt.code = '1' -- Venta
    AND t.begin_time >= date_trunc('month', CURRENT_DATE) - interval '2 months' -- Primer día de julio del año en curso
    AND t.begin_time < date_trunc('month', CURRENT_DATE) - interval '1 months' -- Primer día de agosto del año en curso
GROUP BY 
    p.code, p.name
ORDER BY 
    total_revenue DESC
LIMIT 2;


-- mejorado con explicación de devoluciones

SELECT 
    p.code AS product_code,
    p.name AS product_name,
    SUM(CASE 
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '1') THEN td.quantity
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '2') THEN -td.quantity
            ELSE 0
        END) AS total_quantity_sold,
    SUM(CASE 
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '1') THEN td.subtotal
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '2') THEN -td.subtotal
            ELSE 0
        END) AS total_revenue
FROM 
    transaction t
JOIN transaction_detail td ON t.id = td.id_transaction
JOIN product p ON td.product_id = p.id
WHERE 
    t.begin_time >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 month' -- Filtrar julio del año en curso
    AND t.begin_time < DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
GROUP BY 
    p.code, p.name
HAVING 
    SUM(CASE 
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '1') THEN td.quantity
            WHEN t.transaction_type_id = (SELECT id FROM transaction_type WHERE code = '2') THEN -td.quantity
            ELSE 0
        END) > 0 -- Mostrar solo productos con ventas netas positivas
ORDER BY 
    total_revenue DESC
LIMIT 3;

/*Solicitud del usuario: "Necesito un informe de las ventas de todos los clientes que no tienen RUT. Quiero verlas ordenadas por fecha"*/
SELECT 
    t.id_tx AS transaction_code,
    t.begin_time AS transaction_date,
    c.first_name,
    c.last_name,
    c.code AS customer_code,
    SUM(CASE 
            WHEN tt.code = '1' THEN td.quantity -- Venta
            WHEN tt.code = '2' THEN -td.quantity -- Devolución
            ELSE 0
        END) AS total_quantity_sold,
    SUM(CASE 
            WHEN tt.code = '1' THEN td.subtotal -- Venta
            WHEN tt.code = '2' THEN -td.subtotal -- Devolución
            ELSE 0
        END) AS total_amount_sold
FROM 
    transaction t
JOIN customer c ON t.customer_id = c.id
JOIN transaction_detail td ON t.id = td.id_transaction
JOIN transaction_type tt ON t.transaction_type_id = tt.id
JOIN identification_customer ic ON ic.customer_id = c.id
JOIN identification_type it ON ic.type_id = it.id
WHERE 
    it.code != 'RUT'
GROUP BY 
    t.id_tx, t.begin_time, c.first_name, c.last_name, c.code
ORDER BY 
    t.begin_time ASC;

   
  --- se elimina la relacion comentada entre tipo de identificación y customer identification
   
   SELECT 
    t.begin_time AS fecha,
    c.code AS codigo_cliente,
    c.first_name AS nombre_cliente,
    c.last_name AS apellido_cliente,
    SUM(CASE 
            WHEN tt.code = '1' THEN td.quantity 
            WHEN tt.code = '2' THEN -td.quantity 
            ELSE 0 
        END) AS total_cantidad_vendida,
    SUM(CASE 
            WHEN tt.code = '1' THEN td.subtotal 
            WHEN tt.code = '2' THEN -td.subtotal 
            ELSE 0 
        END) AS total_vendido
FROM 
    transaction t
JOIN customer c ON t.customer_id = c.id
JOIN identification_customer ic ON c.id = ic.customer_id
JOIN transaction_detail td ON t.id = td.id_transaction
JOIN transaction_type tt ON t.transaction_type_id = tt.id
WHERE 
    ic.type_id != (SELECT id FROM identification_type WHERE code = 'RUT')
GROUP BY 
    t.begin_time, c.code, c.first_name, c.last_name
ORDER BY 
    t.begin_time ASC;

----------------------------------------------------------
-------------06/10/2024 y 13/10/2024----------------------
----------------------------------------------------------

--Solicitud del usuario: "Necesito los usuarios de los descuentos que han sido otorgados, los totales agrupados por usuario y ordenados de mayor a menor"

SELECT 
    u.code AS user_code,
    u.name AS user_name,
    u.last_name AS user_last_name,
    SUM(dt.amount) AS total_discount_amount,
    SUM(dt.percentage) AS total_discount_percentage
FROM 
    discount_transaction dt
JOIN 
    "user" u ON dt.user_id = u.id
JOIN 
    transaction_detail td ON td.discount_transaction_id = dt.id
JOIN 
    transaction t ON t.id = td.id_transaction
WHERE 
    t.cancel_flag = FALSE
GROUP BY 
    u.code, u.name, u.last_name
ORDER BY 
    total_discount_amount DESC;


--Solicitud del usuario: "Necesito la cantidad total de ventas del producto BEDSET01 en el mes de julio y agosto" 
   
SELECT
    p.code,
    p.name,
    SUM(
        CASE 
            WHEN tt.code = '1' THEN td.quantity
            WHEN tt.code = '2' THEN -td.quantity
            ELSE 0
        END
    ) AS total_quantity
FROM
    product p
    JOIN transaction_detail td ON p.id = td.product_id
    JOIN transaction t ON td.id_transaction = t.id
    JOIN transaction_type tt ON t.transaction_type_id = tt.id
WHERE
    p.code = 'BEDSET01'
    AND t.cancel_flag = FALSE
    AND t.begin_time >= DATE '2024-07-01'
    AND t.begin_time < DATE '2024-09-01'
GROUP BY
    p.code,
    p.name;

--Solicitud del usuario: "Necesito un informe con el valor promedio de las reviews de todos los productos que se vendieron en el mes de julio y agosto, ordenados por fecha de review"
SELECT p.code AS product_code, p.name AS product_name, 
       AVG(pr.rating) AS average_rating, 
       pr.create_at AS review_date
FROM product_review pr
JOIN transaction_detail td ON pr.transaction_detail_id = td.id
JOIN transaction t ON td.id_transaction = t.id
JOIN product p ON td.product_id = p.id
JOIN transaction_type tt ON t.transaction_type_id = tt.id
WHERE t.begin_time >= '2024-07-01' 
  AND t.end_time <= '2024-08-31'
  AND t.cancel_flag = false
  AND tt.code = '1' -- Venta
GROUP BY p.code, p.name, pr.create_at
ORDER BY pr.create_at;

--Solicitud del usuario: "Necesito un informe con el valor promedio de las reviews de todos los productos que se vendieron en el mes de julio y agosto, ordenados por fecha de review y agrupado por producto"

SELECT 
    p.code AS product_code,
    p.name AS product_name,
    AVG(pr.rating) AS avg_rating,
    pr.create_at AS review_date
FROM 
    product_review pr
JOIN 
    transaction_detail td ON pr.transaction_detail_id = td.id
JOIN 
    product p ON td.product_id = p.id
JOIN 
    transaction t ON td.id_transaction = t.id
JOIN 
    transaction_type tt ON t.transaction_type_id = tt.id
WHERE 
    t.cancel_flag = FALSE
    AND tt.code = '1' -- Considerar solo ventas
    AND t.begin_time BETWEEN '2024-07-01' AND '2024-08-31'
GROUP BY 
    p.code, p.name, pr.create_at
ORDER BY 
    pr.create_at;
   
   
 --Solicitud del usuario: "Necesito un informe con el valor promedio de las reviews de todos los productos que se vendieron en el mes de julio y agosto, ordenados por mayor calificación y agrupado por producto"
   
   SELECT 
    p.code AS product_code,
    p.name AS product_name,
    AVG(pr.rating) AS average_rating
FROM 
    product_review pr
JOIN 
    transaction_detail td ON pr.transaction_detail_id = td.id
JOIN 
    transaction t ON td.id_transaction = t.id
JOIN 
    product p ON td.product_id = p.id
WHERE 
    t.begin_time >= '2024-07-01 00:00:00' 
    AND t.end_time <= '2024-08-31 23:59:59'
    AND t.cancel_flag = FALSE
GROUP BY 
    p.code, p.name
ORDER BY 
    average_rating DESC;

