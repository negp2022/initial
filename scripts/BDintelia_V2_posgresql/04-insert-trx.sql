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
    949999.94, -- total
    'B0001', -- fiscal_number
    FALSE, -- cancel_flag
    '2024-07-03 00:00:00', -- begin_time
    '2024-07-03 23:59:59', -- end_time
    '8779', -- id_tx
    (SELECT id FROM terminal WHERE code = 'TERM001'), -- terminal_id buscado por código
    (SELECT id FROM customer WHERE code = 'CUST001'), -- customer_id buscado por código
    (SELECT id FROM transaction_type WHERE name = 'Venta'), -- transaction_type_id buscado por nombre
    (SELECT id FROM receipt_type WHERE code = 'B01'), -- receipt_type_id buscado por código
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- transaction_status_config_id buscado por código
);


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
    699999.98, -- total
    'F0200', -- fiscal_number
    FALSE, -- cancel_flag
    '2024-08-10 00:00:00', -- begin_time
    '2024-08-10 23:59:59', -- end_time
    '8780', -- id_tx
    (SELECT id FROM terminal WHERE code = 'TERM002'), -- terminal_id buscado por código
    (SELECT id FROM customer WHERE code = 'CUST002'), -- customer_id buscado por código
    (SELECT id FROM transaction_type WHERE name = 'Venta'), -- transaction_type_id buscado por nombre
    (SELECT id FROM receipt_type WHERE code = 'F01'), -- receipt_type_id buscado por código
    (SELECT id FROM transaction_status_config WHERE code = 'COMPLETED') -- transaction_status_config_id buscado por código
);

-- Insert para Nike Camisa Hombre
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
    (SELECT id FROM transaction WHERE id_tx = '8779'), -- id_transaction
    3.00, -- cantidad
    149999.97, -- subtotal
    49999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'MSHIRT01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- product_review_id
);

-- Insert para Samsung Smart TV 55"
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
    (SELECT id FROM transaction WHERE id_tx = '8779'), -- id_transaction
    1.00, -- cantidad
    499999.99, -- subtotal
    499999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'TVSMART01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- product_review_id
);

-- Insert para Adidas Zapatos Mujer
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
    (SELECT id FROM transaction WHERE id_tx = '8779'), -- id_transaction
    2.00, -- cantidad
    299999.98, -- subtotal
    149999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'WSHOES01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- product_review_id
);


-- Insert para Whirlpool Juego de Dormitorio
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
    (SELECT id FROM transaction WHERE id_tx = '8780'), -- id_transaction
    1.00, -- cantidad
    549999.99, -- subtotal
    549999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'BEDSET01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U002'), -- user_id
    NULL -- product_review_id
);

-- Insert para Adidas Zapatos Mujer
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
    (SELECT id FROM transaction WHERE id_tx = '8780'), -- id_transaction
    1.00, -- cantidad
    149999.99, -- subtotal
    149999.99, -- precio unitario
    0, -- total_discount
    0, -- total_promo
    (SELECT id FROM product WHERE code = 'WSHOES01'), -- product_id
    NULL, -- discount_transaction_id
    (SELECT id FROM "user" WHERE code = 'U001'), -- user_id
    NULL -- product_review_id
);


-- Insert en payment_transaction para pago en efectivo (CASH)
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    150000.00, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CASH'), -- Tipo de pago efectivo
    (SELECT id FROM transaction WHERE id_tx = '8779') -- ID de la transacción
);

-- Insert en payment_transaction para pago con billetera digital (MPAGO)
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    200000.00, -- Monto
    (SELECT id FROM payment_type WHERE code = 'MPAGO'), -- Tipo de pago con billetera digital
    (SELECT id FROM transaction WHERE id_tx = '8779') -- ID de la transacción
);

-- Insert en wallet_payment para pago con billetera digital utilizando subselect anidado para payment_transaction_id
INSERT INTO wallet_payment (
    transaction_number,
    effective_date,
    payment_transaction_id
)
VALUES (
    '99887766', -- Número de transacción de la billetera digital
    '2024-09-06 14:00:00', -- Fecha efectiva
    (SELECT pt.id FROM payment_transaction pt 
     WHERE pt.amount = 200000.00 
       AND pt.transaction_id = (SELECT id FROM transaction WHERE id_tx = '8779') 
       AND pt.payment_type_id = (SELECT id FROM payment_type WHERE code = 'MPAGO')) -- ID de la transacción de pago
);


-- Insert en payment_transaction para pago con tarjeta de crédito (CCARD)
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    599999.94, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CCARD'), -- Tipo de pago con tarjeta de crédito
    (SELECT id FROM transaction WHERE id_tx = '8779') -- ID de la transacción
);

-- Insert en card_payment para pago con tarjeta de crédito utilizando subselect anidado para payment_transaction_id
INSERT INTO card_payment (
    card_number,
    authorization_code,
    effective_date,
    payment_transaction_id
)
VALUES (
    '4151', -- Número de tarjeta
    'AUTH001', -- Código de autorización (puedes ajustar este valor)
    '2024-09-06 14:00:00', -- Fecha efectiva
    (SELECT pt.id FROM payment_transaction pt 
     WHERE pt.amount = 599999.94 
       AND pt.transaction_id = (SELECT id FROM transaction WHERE id_tx = '8779') 
       AND pt.payment_type_id = (SELECT id FROM payment_type WHERE code = 'CCARD')) -- ID de la transacción de pago
);

-- Insert en payment_transaction para pago en efectivo (CASH)
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    220000.00, -- Monto
    (SELECT id FROM payment_type WHERE code = 'CASH'), -- Tipo de pago efectivo
    (SELECT id FROM transaction WHERE id_tx = '8780') -- ID de la transacción
);

-- Insert en payment_transaction para pago con tarjeta de débito (DCARD)
INSERT INTO payment_transaction (
    amount,
    payment_type_id,
    transaction_id
)
VALUES (
    479999.98, -- Monto
    (SELECT id FROM payment_type WHERE code = 'DCARD'), -- Tipo de pago con tarjeta de débito
    (SELECT id FROM transaction WHERE id_tx = '8780') -- ID de la transacción
);

-- Insert en card_payment para pago con tarjeta de débito utilizando subselect anidado para payment_transaction_id
INSERT INTO card_payment (
    card_number,
    authorization_code,
    effective_date,
    payment_transaction_id
)
VALUES (
    '1187', -- Número de tarjeta
    'AUTH002', -- Código de autorización (puedes ajustar este valor)
    '2024-09-06 14:00:00', -- Fecha efectiva
    (SELECT pt.id FROM payment_transaction pt 
     WHERE pt.amount = 479999.98 
       AND pt.transaction_id = (SELECT id FROM transaction WHERE id_tx = '8780') 
       AND pt.payment_type_id = (SELECT id FROM payment_type WHERE code = 'DCARD')) -- ID de la transacción de pago
);

