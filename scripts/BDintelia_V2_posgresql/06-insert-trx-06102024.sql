-- Update en card_payment para la transacción 8779 y el banco BCI
UPDATE card_payment
SET bank_id = (SELECT id FROM bank WHERE code = 'BCI')
WHERE payment_transaction_id = (SELECT id FROM payment_transaction 
                                WHERE transaction_id = (SELECT id FROM transaction WHERE id_tx = '8779')
                                  AND amount = 599999.94);

-- Update en card_payment para la transacción 8780 y el banco ESTADO
UPDATE card_payment
SET bank_id = (SELECT id FROM bank WHERE code = 'ESTADO')
WHERE payment_transaction_id = (SELECT id FROM payment_transaction 
                                WHERE transaction_id = (SELECT id FROM transaction WHERE id_tx = '8780')
                                  AND amount = 479999.98);

-- Update en card_payment para la transacción 8790 y el banco SANT
UPDATE card_payment
SET bank_id = (SELECT id FROM bank WHERE code = 'SANT')
WHERE payment_transaction_id = (SELECT id FROM payment_transaction 
                                WHERE transaction_id = (SELECT id FROM transaction WHERE id_tx = '8790')
                                  AND amount = 799999.88);


-- Insert para la transacción de venta (8795)
INSERT INTO transaction (
    total,
    fiscal_number,
    cancel_flag,
    begin_time,
    end_time,
    id_tx,
    terminal_id,
    customer_id,
    transaction_type_id,
    receipt_type_id,
    transaction_status_config_id
)
VALUES (
    1199999.99, -- Total
    'B0003', -- Número fiscal
    FALSE, -- Cancel_flag
    '2024-07-10 00:00:00', -- Fecha de inicio
    '2024-07-10 23:59:59', -- Fecha de fin
    '8795', -- ID Transacción
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- Terminal ID
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT id FROM transaction_type WHERE name = 'Venta'), -- Tipo de transacción (Venta)
    (SELECT id FROM receipt_type WHERE code = 'B01'), -- Tipo de comprobante (B01)
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- Estado de la transacción (Completed)
);

-- Insert para el producto "LAPTOP01" en la transacción 8795
INSERT INTO transaction_detail (
    id_transaction,
    quantity,
    subtotal,
    unit_price,
    total_discount,
    total_promo,
    product_id,
    discount_transaction_id,
    user_id,
    product_review_id
)
VALUES (
    (SELECT id FROM transaction WHERE id_tx = '8795'), -- id_transaction
    1.00, -- Cantidad
    1199999.99, -- Subtotal
    1299999.99, -- Precio unitario
    100000.00, -- Descuento total
    0.00, -- Promo total
    (SELECT id FROM product WHERE code = 'LAPTOP01'), -- product_id
    NULL, -- No hay transacción de descuento
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- No hay reseña de producto
);

-- Insert en payment_transaction para pago con tarjeta regalo (GCARD) en la transacción 8795
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    500000.00, -- Monto
    (SELECT id FROM payment_type WHERE code = 'GCARD'), -- Tipo de pago tarjeta regalo
    (SELECT id FROM transaction WHERE id_tx = '8795') -- ID de la transacción
);

-- Insert en card_payment para el pago con tarjeta regalo
INSERT INTO card_payment (
    card_number,
    authorization_code,
    effective_date,
    payment_transaction_id,
    bank_id
)
VALUES (
    '6547', -- Número de tarjeta
    'AUTH001', -- Código de autorización (puedes ajustar)
    '2024-07-10 14:00:00', -- Fecha efectiva
    (SELECT id FROM payment_transaction WHERE amount = 500000.00 
       AND transaction_id = (SELECT id FROM transaction WHERE id_tx = '8795')),
    NULL -- No hay banco asociado para tarjeta regalo
);

-- Insert en payment_transaction para pago con tarjeta de crédito (CCARD) en la transacción 8795
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    699999.99, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CCARD'), -- Tipo de pago tarjeta de crédito
    (SELECT id FROM transaction WHERE id_tx = '8795') -- ID de la transacción
);

-- Insert en card_payment para el pago con tarjeta de crédito (Banco SANT)
INSERT INTO card_payment (
    card_number,
    authorization_code,
    effective_date,
    payment_transaction_id,
    bank_id
)
VALUES (
    '8585', -- Número de tarjeta
    'AUTH002', -- Código de autorización (puedes ajustar)
    '2024-07-10 14:00:00', -- Fecha efectiva
    (SELECT id FROM payment_transaction WHERE amount = 699999.99 
       AND transaction_id = (SELECT id FROM transaction WHERE id_tx = '8795')),
    (SELECT id FROM bank WHERE code = 'SANT') -- Banco asociado (SANT)
);

-- Insert para el descuento de la transacción 8795
INSERT INTO discount_transaction (
    type,
    amount,
    percentage,
    user_id
)
VALUES (
    'Amount', -- Tipo de descuento
    100000.00, -- Monto
    7.69, -- Porcentaje
    (SELECT id FROM "user" WHERE code = 'U010') -- User ID
);

-- Update para asociar el descuento a transaction_detail en la transacción 8795
UPDATE transaction_detail
SET discount_transaction_id = (
    SELECT id FROM discount_transaction
    WHERE type = 'Amount'
      AND amount = 100000.00
      AND percentage = 7.69
)
WHERE id_transaction = (SELECT id FROM transaction WHERE id_tx = '8795');


INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    5, -- Rating
    'Excelente producto', -- Comentario
    '2024-07-10 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8779')
       AND p.code = 'MSHIRT01') -- Transaction detail ID
);


-- Insert para la reseña del producto TVSMART01 en la transacción 8779
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    4, -- Rating
    'Está bien para el precio', -- Comentario
    '2024-07-10 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8779')
       AND p.code = 'TVSMART01') -- Transaction detail ID
);

-- Insert para la reseña del producto WSHOES01 en la transacción 8779
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    5, -- Rating
    'Lo volvería a comprar sin dudarlo', -- Comentario
    '2024-07-10 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8779')
       AND p.code = 'WSHOES01') -- Transaction detail ID
);

-- Insert para la reseña del producto BEDSET01 en la transacción 8780
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    4, -- Rating
    'Buen producto', -- Comentario
    '2024-08-20 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST002'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8780')
       AND p.code = 'BEDSET01') -- Transaction detail ID
);

-- Insert para la reseña del producto WSHOES01 en la transacción 8780
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    4, -- Rating
    'Buena relación precio calidad', -- Comentario
    '2024-08-20 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST002'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8780')
       AND p.code = 'WSHOES01') -- Transaction detail ID
);

-- Insert para la reseña del producto WSHOES01 en la transacción 8790
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    1, -- Rating
    'Pésima calidad', -- Comentario
    '2024-07-20 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST017'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8790')
       AND p.code = 'WSHOES01') -- Transaction detail ID
);

-- Insert para la reseña del producto MSHIRT01 en la transacción 8790
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    2, -- Rating
    'No era lo que esperaba', -- Comentario
    '2024-07-20 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST017'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8790')
       AND p.code = 'MSHIRT01') -- Transaction detail ID
);

-- Insert para la reseña del producto LAPTOP01 en la transacción 8795
INSERT INTO product_review (
    rating,
    comment,
    create_at,
    customer_id,
    transaction_detail_id
)
VALUES (
    5, -- Rating
    'Superó mis expectativas', -- Comentario
    '2024-07-15 00:00:00', -- Fecha
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT td.id FROM transaction_detail td
     JOIN product p ON td.product_id = p.id
     WHERE td.id_transaction = (SELECT id FROM transaction WHERE id_tx = '8795')
       AND p.code = 'LAPTOP01') -- Transaction detail ID
);
