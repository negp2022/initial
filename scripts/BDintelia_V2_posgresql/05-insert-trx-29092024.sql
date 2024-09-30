-- Insert para la transacción 8790
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
    799999.88, -- total
    'B0002', -- fiscal_number
    FALSE, -- cancel_flag
    '2024-07-18 00:00:00', -- begin_time
    '2024-07-18 23:59:59', -- end_time
    '8790', -- id_tx
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- terminal_id
    (SELECT id FROM customer WHERE code = 'CUST017'), -- customer_id
    (SELECT id FROM transaction_type WHERE name = 'Venta'), -- transaction_type_id
    (SELECT id FROM receipt_type WHERE code = 'B01'), -- receipt_type_id
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- transaction_status_config_id
);

-- Insert para Adidas Zapatos Mujer (WSHOES01) en la transacción 8790
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
    (SELECT id FROM transaction WHERE id_tx = '8790'), -- id_transaction
    2.00, -- cantidad
    299999.98, -- subtotal
    149999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'WSHOES01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U004'), -- user_id
    NULL -- product_review_id
);

-- Insert para Nike Camisa Hombre (MSHIRT01) en la transacción 8790
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
    (SELECT id FROM transaction WHERE id_tx = '8790'), -- id_transaction
    10.00, -- cantidad
    499999.90, -- subtotal
    49999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'MSHIRT01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U004'), -- user_id
    NULL -- product_review_id
);

-- Insert en payment_transaction para pago con tarjeta de débito (DCARD) en la transacción 8790
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    799999.88 , -- Monto
    (SELECT id FROM payment_type WHERE code = 'DCARD'), -- Tipo de pago con tarjeta de débito
    (SELECT id FROM transaction WHERE id_tx = '8790') -- ID de la transacción
);

-- Insert en card_payment para pago con tarjeta de débito utilizando subselect anidado para payment_transaction_id
INSERT INTO card_payment (
    card_number,
    authorization_code,
    effective_date,
    payment_transaction_id
)
VALUES (
    '9783', -- Número de tarjeta
    'AUTH003', -- Código de autorización (puedes ajustar este valor)
    '2024-07-18 14:00:00', -- Fecha efectiva
    (SELECT pt.id FROM payment_transaction pt 
     WHERE pt.amount = 799999.88 
       AND pt.transaction_id = (SELECT id FROM transaction WHERE id_tx = '8790') 
       AND pt.payment_type_id = (SELECT id FROM payment_type WHERE code = 'DCARD')) -- ID de la transacción de pago
);

-- Insert para la transacción de devolución (8791)
INSERT INTO transaction (
    total,
    fiscal_number,
    cancel_flag,
    begin_time,
    end_time,
    id_tx,
    original_id_tx,
    original_fiscal_number,
    terminal_id,
    customer_id,
    transaction_type_id,
    receipt_type_id,
    transaction_status_config_id
)
VALUES (
    99999.98, -- Total
    'NC001', -- Número fiscal
    FALSE, -- Cancel_flag
    '2024-07-20 00:00:00', -- Fecha de inicio
    '2024-07-20 23:59:59', -- Fecha de fin
    '8791', -- ID Transacción
    '8790', -- Original ID Transacción
    'B002', -- Original Fiscal Number
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- Terminal ID
    (SELECT id FROM customer WHERE code = 'CUST016'), -- Customer ID
    (SELECT id FROM transaction_type WHERE name = 'Devolución'), -- Tipo de transacción (Devolución)
    (SELECT id FROM receipt_type WHERE code = 'NC01'), -- Tipo de comprobante (NC01)
    (SELECT id FROM transaction_status_config WHERE code = 'REFUNDED') -- Estado de la transacción (Refunded)
);

-- Insert para la transacción de venta cancelada (8792)
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
    549999.99, -- Total
    NULL, -- No hay número fiscal
    TRUE, -- Cancel_flag
    '2024-07-25 00:00:00', -- Fecha de inicio
    '2024-07-25 23:59:59', -- Fecha de fin
    '8792', -- ID Transacción
    (SELECT id FROM terminal WHERE code = 'TERM002'), -- Terminal ID
    (SELECT id FROM customer WHERE code = 'CUST001'), -- Customer ID
    (SELECT id FROM transaction_type WHERE name = 'Venta'), -- Tipo de transacción (Venta)
    (SELECT id FROM receipt_type WHERE code = 'F01'), -- Tipo de comprobante (F01)
    (SELECT id FROM transaction_status_config WHERE code = 'CANCELLED') -- Estado de la transacción (Cancelled)
);

-- Insert para la transacción de retiro (8793)
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
    transaction_status_config_id
)
VALUES (
    100000.00, -- Total
    NULL, -- No hay número fiscal
    FALSE, -- Cancel_flag
    '2024-07-19 00:00:00', -- Fecha de inicio
    '2024-07-19 23:59:59', -- Fecha de fin
    '8793', -- ID Transacción
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- Terminal ID
    NULL, -- No hay cliente
    (SELECT id FROM transaction_type WHERE name = 'Retiro'), -- Tipo de transacción (Retiro)
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- Estado de la transacción (Completed)
);

-- Insert para Nike Camisa Hombre (MSHIRT01) en la transacción 8791
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
    (SELECT id FROM transaction WHERE id_tx = '8791'), -- id_transaction
    2.00, -- Cantidad
    99999.98, -- Subtotal
    49999.99, -- Precio unitario
    0, -- Descuento total
    0, -- Promo total
    (SELECT id FROM product WHERE code = 'MSHIRT01'), -- product_id
    NULL, -- No hay transacción de descuento
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- No hay reseña de producto
);

-- Insert para Whirlpool Juego de Dormitorio (BEDSET01) en la transacción 8792
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
    (SELECT id FROM transaction WHERE id_tx = '8792'), -- id_transaction
    1.00, -- Cantidad
    549999.99, -- Subtotal
    549999.99, -- Precio unitario
    0, -- Descuento total
    0, -- Promo total
    (SELECT id FROM product WHERE code = 'BEDSET01'), -- product_id
    NULL, -- No hay transacción de descuento
    (SELECT id FROM "user" WHERE code = 'U004'), -- user_id
    NULL -- No hay reseña de producto
);

-- Insert en payment_transaction para pago en efectivo en la transacción 8791
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    99999.98, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CASH'), -- Tipo de pago efectivo
    (SELECT id FROM transaction WHERE id_tx = '8791') -- ID de la transacción
);

-- Insert en payment_transaction para pago en efectivo en la transacción 8793
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    100000.00, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CASH'), -- Tipo de pago efectivo
    (SELECT id FROM transaction WHERE id_tx = '8793') -- ID de la transacción
);


-- Insert para la transacción de tipo "Login" (8794)
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
    transaction_status_config_id
)
VALUES (
    0.00, -- Total
    NULL, -- No hay número fiscal
    FALSE, -- Cancel_flag
    '2024-07-01 00:00:00', -- Fecha de inicio
    '2024-07-01 23:59:59', -- Fecha de fin
    '8794', -- ID Transacción
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- Terminal ID (puedes ajustar si usas un terminal distinto)
    NULL, -- No hay cliente asociado
    (SELECT id FROM transaction_type WHERE name = 'Login'), -- Tipo de transacción (Login)
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- Estado de la transacción (Completed)
);
