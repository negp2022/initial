--impuestos
INSERT INTO tax_rates (code, name, rate, is_active, start_date, end_date)
VALUES 
('IVA19', 'Impuesto al Valor Agregado', 19.00, TRUE, '2024-01-01 00:00:00', NULL),
('IACV', 'Alcohol: cerveza y vino', 20.5, TRUE, '2024-01-01 00:00:00', NULL),
('IALF', 'Alcohol: licores fuertes', 31.5, TRUE, '2024-01-01 00:00:00', NULL),
('IBAZ', 'Bebidas azucaradas', 18.0, TRUE, '2024-01-01 00:00:00', NULL);

--tipos de promociones
INSERT INTO promo_type (code, description)
VALUES 
    ('amount', 'Tipo de promoción basada en descuento por monto'),
    ('percentage', 'Tipo de promoción basada en descuento por porcentaje'),
    ('newPrice', 'Tipo de promoción basada en un nuevo precio');

--roles
INSERT INTO "role" (code, name, enabled, role_activity)
VALUES 
    ('01_sale', 'Venta', TRUE, 'Permite realizar ventas'),
    ('02_return', 'Devolución', TRUE, 'Permite realizar devoluciones'),
    ('03_voidItem', 'Eliminar item', TRUE, 'Permite anular items en una venta'),
    ('04_cashOps', 'Operaciones de caja', TRUE, 'Operaciones de flujo de dinero'),
    ('05_discount', 'Descuento manual', TRUE, 'Permite realizar descuentos manuales'),
    ('06_superuser', 'Administrador del Sistema', TRUE, 'Gestión completa del sistema, acceso total a todas las funcionalidades');

--tipos de transacciones
INSERT INTO transaction_type (code, name, description)
VALUES 
    ('1', 'Venta', 'Venta de productos o servicios al cliente'),
    ('2', 'Devolución', 'Devolución de productos por parte del cliente'),
    ('3', 'Cambio', 'Cambio de un producto por otro de igual o diferente valor'),
    ('4', 'Arqueo', 'Arqueo de caja'),
    ('5', 'Dotación', 'Dotación de caja'),
    ('6', 'Retiro', 'Retiro de caja'),
    ('7', 'Login', 'Login de usuario');


--tipos de comprobantes
INSERT INTO receipt_type (code, name, description)
VALUES 
    ('F01', 'Factura', 'Comprobante fiscal que detalla la transacción de venta de productos o servicios, incluye IVA'),
    ('B01', 'Boleta de Venta', 'Comprobante que registra la venta de productos o servicios a un consumidor final, sin detalle fiscal como en la factura'),
    ('NC01', 'Nota de Crédito', 'Documento que se emite para anular o corregir una factura, por ejemplo, en caso de devoluciones'),
    ('ND01', 'Nota de Débito', 'Documento utilizado para aumentar el valor de una factura ya emitida, como por intereses o cargos adicionales'),
    ('GD01', 'Guía de Despacho', 'Documento que acompaña el traslado de mercaderías, detalla los productos transportados pero no es un comprobante de venta en sí mismo');

--tipos de medios de pago
INSERT INTO payment_type (code, name, ISO_code)
VALUES 
    ('CASH', 'Pago en Efectivo', 'CLP'),
    ('CCARD', 'Tarjeta de Crédito', 'CLP'),
    ('DCARD', 'Tarjeta de Débito', 'CLP'),
    ('BANK', 'Transferencia Bancaria', 'CLP'),
    ('GCARD', 'Gift Card', 'CLP'),
    ('MPAGO', 'Mercado Pago', 'CLP'),
    ('ONEPY', 'One Pay', 'CLP'),
    ('PAYPL', 'PayPal', 'USD');

--configuráción de medios de pago
INSERT INTO payment_method_config (sale_enabled, return_enabled, min_accepted, max_accepted, payment_type_code)
VALUES 
    (TRUE, TRUE, 1.00, 1000000.00, 'CASH'),  -- Pago en Efectivo
    (TRUE, TRUE, 1.00, 10000000.00, 'CCARD'), -- Tarjeta de Crédito
    (TRUE, TRUE, 1.00, 10000000.00, 'DCARD'), -- Tarjeta de Débito
    (TRUE, FALSE, 100.00, 5000000.00, 'BANK'), -- Transferencia Bancaria
    (TRUE, FALSE, 500.00, 200000.00, 'GCARD'),  -- Gift Card
    (TRUE, FALSE, 1.00, 5000000.00, 'MPAGO'),  -- Mercado Pago
    (TRUE, FALSE, 1.00, 5000000.00, 'ONEPY'),  -- One Pay
    (TRUE, FALSE, 5.00, 100000.00, 'PAYPL');  -- PayPal

