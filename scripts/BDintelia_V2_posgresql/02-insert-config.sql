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

--INSERTS DM

--- PAISES ---
INSERT INTO country (code, name, ISO_code) VALUES ('CHL', 'Chile', 'CL');
INSERT INTO country (code, name, ISO_code) VALUES ('ARG', 'Argentina', 'AR');
INSERT INTO country (code, name, ISO_code) VALUES ('BOL', 'Bolivia', 'BO');
INSERT INTO country (code, name, ISO_code) VALUES ('BRA', 'Brasil', 'BR');
INSERT INTO country (code, name, ISO_code) VALUES ('COL', 'Colombia', 'CO');
INSERT INTO country (code, name, ISO_code) VALUES ('ECU', 'Ecuador', 'EC');
INSERT INTO country (code, name, ISO_code) VALUES ('GUY', 'Guyana', 'GY');
INSERT INTO country (code, name, ISO_code) VALUES ('PRY', 'Paraguay', 'PY');
INSERT INTO country (code, name, ISO_code) VALUES ('PER', 'Perú', 'PE');
INSERT INTO country (code, name, ISO_code) VALUES ('SUR', 'Surinam', 'SR');
INSERT INTO country (code, name, ISO_code) VALUES ('URY', 'Uruguay', 'UY');
INSERT INTO country (code, name, ISO_code) VALUES ('VEN', 'Venezuela', 'VE');

--- REGIONES ---
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('AP', 'Arica y Parinacota', 'CL-AP', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('TA', 'Tarapacá', 'CL-TA', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('AN', 'Antofagasta', 'CL-AN', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('AT', 'Atacama', 'CL-AT', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('CO', 'Coquimbo', 'CL-CO', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('VS', 'Valparaíso', 'CL-VS', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('RM', 'Región Metropolitana de Santiago', 'CL-RM', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('LI', 'Libertador General Bernardo OHiggins', 'CL-LI', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('ML', 'Maule', 'CL-ML', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('NB', 'Ñuble', 'CL-NB', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('BI', 'Biobío', 'CL-BI', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('AR', 'La Araucanía', 'CL-AR', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('LR', 'Los Ríos', 'CL-LR', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('LL', 'Los Lagos', 'CL-LL', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('AI', 'Aysén del General Carlos Ibáñez del Campo', 'CL-AI', 1);
INSERT INTO region (code, name, ISO_code, country_id) VALUES ('MA', 'Magallanes y de la Antártica Chilena', 'CL-MA', 1);


---  PROVINCIAS  ---

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('AR', 'Arica', 'CL-1-AR', 1);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('PA', 'Parinacota', 'CL-1-PA', 1);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('IQ', 'Iquique', 'CL-2-IQ', 2);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('TM', 'Tamarugal', 'CL-2-TM', 2);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('AN', 'Antofagasta', 'CL-3-AN', 3);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('EL', 'El Loa', 'CL-3-EL', 3);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('TP', 'Tocopilla', 'CL-3-TP', 3);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CO', 'Copiapó', 'CL-4-CO', 4);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CH', 'Chañaral', 'CL-4-CH', 4);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('HS', 'Huasco', 'CL-4-HS', 4);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('EQ', 'Elqui', 'CL-5-EQ', 5);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CP', 'Choapa', 'CL-5-CP', 5);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('LR', 'Limarí', 'CL-5-LR', 5);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('VA', 'Valparaíso', 'CL-6-VA', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('SA', 'San Antonio', 'CL-6-SA', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('QL', 'Quillota', 'CL-6-QL', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('SF', 'San Felipe de Aconcagua', 'CL-6-SF', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('PT', 'Petorca', 'CL-6-PT', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('LD', 'Los Andes', 'CL-6-LD', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('IP', 'Isla de Pascua', 'CL-6-IP', 6);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('MM', 'Marga Marga', 'CL-6-MM', 6);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('ST', 'Santiago', 'CL-7-ST', 7);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CB', 'Chacabuco', 'CL-7-CB', 7);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CR', 'Cordillera', 'CL-7-CR', 7);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('MP', 'Maipo', 'CL-7-MP', 7);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('ML', 'Melipilla', 'CL-7-ML', 7);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('TG', 'Talagante', 'CL-7-TG', 7);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CA', 'Cachapoal', 'CL-8-CA', 8);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('COG', 'Colchagua', 'CL-8-COG', 8);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CC', 'Cardenal Caro', 'CL-8-CC', 8);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('TL', 'Talca', 'CL-9-TL', 9);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CU', 'Curicó', 'CL-9-CU', 9);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('LN', 'Linares', 'CL-9-LN', 9);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CQ', 'Cauquenes', 'CL-9-CQ', 9);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('DG', 'Diguillín', 'CL-10-DG', 10);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('IT', 'Itata', 'CL-10-IT', 10);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('PU', 'Punilla', 'CL-10-PU', 10);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CPN', 'Concepción', 'CL-11-CPN', 11);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('ARU', 'Arauco', 'CL-11-ARU', 11);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('BB', 'Biobío', 'CL-11-BB', 11);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CTN', 'Cautín', 'CL-12-CTN', 12);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('MLC', 'Malleco', 'CL-12-MLC', 12);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('VD', 'Valdivia', 'CL-13-VD', 13);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('RA', 'Ranco', 'CL-13-RA', 13);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('LL', 'Llanquihue', 'CL-14-LL', 14);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CHL', 'Chiloé', 'CL-14-CHL', 14);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('OSN', 'Osorno', 'CL-14-OSN', 14);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('PLN', 'Palena', 'CL-14-PLN', 14);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CHQ', 'Coihaique', 'CL-15-CHQ', 15);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('AYS', 'Aysén', 'CL-15-AYS', 15);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('CPR', 'Capitán Prat', 'CL-15-CPR', 15);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('GCA', 'General Carrera', 'CL-15-GCA', 15);

INSERT INTO state (code, name, ISO_code, region_id) VALUES ('MG', 'Magallanes', 'CL-16-MG', 16);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('ACH', 'Antártica Chilena', 'CL-16-ACH', 16);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('TFG', 'Tierra del Fuego', 'CL-16-TFG', 16);
INSERT INTO state (code, name, ISO_code, region_id) VALUES ('UEP', 'Última Esperanza', 'CL-16-UEP', 16);

--- COMUNAS ---

-- Arica (Provincia de Arica)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AR1', 'Arica', 'CL-1-AR1', '1000000', 1);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PU1', 'Putre', 'CL-1-PU1', '1070000', 1);

-- Parinacota (Provincia de Parinacota)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PU2', 'Putre', 'CL-1-PU2', '1070000', 2);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CA1', 'Caquena', 'CL-1-CA1', '1080000', 2);

-- Iquique (Provincia de Iquique)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('IQ1', 'Iquique', 'CL-2-IQ1', '1100000', 3);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AL1', 'Alto Hospicio', 'CL-2-AL1', '1120000', 3);

-- Tamarugal (Provincia de Tamarugal)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PO1', 'Pozo Almonte', 'CL-2-PO1', '1170000', 4);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('HU1', 'Huara', 'CL-2-HU1', '1172000', 4);

-- Antofagasta (Provincia de Antofagasta)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AN1', 'Antofagasta', 'CL-3-AN1', '1240000', 5);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('ME1', 'Mejillones', 'CL-3-ME1', '1310000', 5);

-- El Loa (Provincia de El Loa)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL1', 'Calama', 'CL-3-CL1', '1390000', 6);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('OL1', 'Ollagüe', 'CL-3-OL1', '1394000', 6);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MA1', 'María Elena', 'CL-3-MA1', '1393000', 6);

-- Tocopilla (Provincia de Tocopilla)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TO2', 'Tocopilla', 'CL-3-TO2', '1340000', 7);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TO3', 'Taltal', 'CL-3-TO3', '1343000', 7);

-- Copiapó (Provincia de Copiapó)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CO2', 'Copiapó', 'CL-4-CO2', '1530000', 8);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TI1', 'Tierra Amarilla', 'CL-4-TI1', '1570000', 8);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CA2', 'Caldera', 'CL-4-CA2', '1572000', 8);

-- Chañaral (Provincia de Chañaral)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CH2', 'Chañaral', 'CL-4-CH2', '1490000', 9);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('DI1', 'Diego de Almagro', 'CL-4-DI1', '1493000', 9);

-- Huasco (Provincia de Huasco)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VA2', 'Vallenar', 'CL-4-VA2', '1610000', 10);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('FR1', 'Freirina', 'CL-4-FR1', '1612000', 10);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('HU2', 'Huasco', 'CL-4-HU2', '1613000', 10);

-- Elqui (Provincia de Elqui)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LS1', 'La Serena', 'CL-5-LS1', '1700000', 11);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CO3', 'Coquimbo', 'CL-5-CO3', '1780000', 11);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AN3', 'Andacollo', 'CL-5-AN3', '1782000', 11);

-- Choapa (Provincia de Choapa)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('IL1', 'Illapel', 'CL-5-IL1', '1930000', 12);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SL1', 'Salamanca', 'CL-5-SL1', '1950000', 12);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LC1', 'Los Vilos', 'CL-5-LC1', '1940000', 12);

-- Limarí (Provincia de Limarí)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('OV2', 'Ovalle', 'CL-5-OV2', '1840000', 13);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MC2', 'Monte Patria', 'CL-5-MC2', '1843000', 13);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RA2', 'Río Hurtado', 'CL-5-RA2', '1844000', 13);

-- Valparaíso (Provincia de Valparaíso)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VA3', 'Valparaíso', 'CL-6-VA3', '2340000', 14);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VM2', 'Viña del Mar', 'CL-6-VM2', '2520000', 14);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CP3', 'Concón', 'CL-6-CP3', '2510000', 14);

-- San Antonio (Provincia de San Antonio)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SA1', 'San Antonio', 'CL-6-SA1', '2660000', 15);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CT2', 'Cartagena', 'CL-6-CT2', '2680000', 15);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AL2', 'Algarrobo', 'CL-6-AL2', '2710000', 15);

-- Quillota (Provincia de Quillota)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('QL1', 'Quillota', 'CL-6-QL1', '2260000', 16);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LM1', 'La Cruz', 'CL-6-LM1', '2270000', 16);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL2', 'Calera', 'CL-6-CL2', '2290000', 16);

-- San Felipe de Aconcagua (Provincia de San Felipe de Aconcagua)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SF2', 'San Felipe', 'CL-6-SF2', '2170000', 17);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LL1', 'Llay Llay', 'CL-6-LL1', '2220000', 17);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PC1', 'Putaendo', 'CL-6-PC1', '2200000', 17);

-- Petorca (Provincia de Petorca)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LA1', 'La Ligua', 'CL-6-LA1', '2030000', 18);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CP4', 'Cabildo', 'CL-6-CP4', '2140000', 18);

-- Los Andes (Provincia de Los Andes)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LD1', 'Los Andes', 'CL-6-LD1', '2100000', 19);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SL2', 'San Esteban', 'CL-6-SL2', '2120000', 19);

-- Isla de Pascua (Provincia de Isla de Pascua)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('HP1', 'Hanga Roa', 'CL-6-HP1', '2770000', 20);

-- Santiago (Provincia de Santiago)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('ST1', 'Santiago', 'CL-7-ST1', '8320000', 21);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PA2', 'Puente Alto', 'CL-7-PA2', '8150000', 21);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MA2', 'Maipú', 'CL-7-MA2', '9250000', 21);

-- Chacabuco (Provincia de Chacabuco)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL3', 'Colina', 'CL-7-CL3', '9340000', 22);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LP1', 'Lampa', 'CL-7-LP1', '9380000', 22);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TL1', 'Tiltil', 'CL-7-TL1', '9420000', 22);

-- Cordillera (Provincia de Cordillera)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PL1', 'Puente Alto', 'CL-7-PL1', '8150000', 23);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SL3', 'San José de Maipo', 'CL-7-SL3', '9460000', 23);

-- Maipo (Provincia de Maipo)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SB1', 'San Bernardo', 'CL-7-SB1', '8050000', 24);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CC1', 'Calera de Tango', 'CL-7-CC1', '9560000', 24);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('BV1', 'Buin', 'CL-7-BV1', '9500000', 24);

-- Melipilla (Provincia de Melipilla)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('ML2', 'Melipilla', 'CL-7-ML2', '9580000', 25);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL4', 'Curacaví', 'CL-7-CL4', '9630000', 25);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MP2', 'María Pinto', 'CL-7-MP2', '9640000', 25);

-- Talagante (Provincia de Talagante)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TG1', 'Talagante', 'CL-7-TG1', '9670000', 26);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('EL1', 'El Monte', 'CL-7-EL1', '9810000', 26);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PA3', 'Peñaflor', 'CL-7-PA3', '9750000', 26);

-- Cachapoal (Provincia de Cachapoal)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RA1', 'Rancagua', 'CL-8-RA1', '2820000', 27);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RO1', 'Rengo', 'CL-8-RO1', '2940000', 27);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MP3', 'Machalí', 'CL-8-MP3', '2910000', 27);

-- Colchagua (Provincia de Colchagua)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SF2', 'San Fernando', 'CL-8-SF2', '3070000', 28);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SM1', 'Santa Cruz', 'CL-8-SM1', '3130000', 28);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('NP1', 'Nancagua', 'CL-8-NP1', '3139000', 28);

-- Cardenal Caro (Provincia de Cardenal Caro)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PC1', 'Pichilemu', 'CL-8-PC1', '3220000', 29);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LC2', 'La Estrella', 'CL-8-LC2', '3230000', 29);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MT1', 'Marchigüe', 'CL-8-MT1', '3250000', 29);

-- Talca (Provincia de Talca)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TL1', 'Talca', 'CL-9-TL1', '3460000', 30);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CU1', 'Curicó', 'CL-9-CU1', '3340000', 30);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CA3', 'Cauquenes', 'CL-9-CA3', '3580000', 30);

-- Curicó (Provincia de Curicó)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CU2', 'Curicó', 'CL-9-CU2', '3340000', 31);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MO1', 'Molina', 'CL-9-MO1', '3380000', 31);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RO2', 'Romeral', 'CL-9-RO2', '3390000', 31);

-- Linares (Provincia de Linares)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LN2', 'Linares', 'CL-9-LN2', '3580000', 32);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LO1', 'Longaví', 'CL-9-LO1', '3590000', 32);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('YE1', 'Yerbas Buenas', 'CL-9-YE1', '3600000', 32);

-- Cauquenes (Provincia de Cauquenes)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CA4', 'Cauquenes', 'CL-9-CA4', '3580000', 33);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CH2', 'Chanco', 'CL-9-CH2', '3589000', 33);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PL2', 'Pelluhue', 'CL-9-PL2', '3590000', 33);

-- Diguillín (Provincia de Diguillín)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CH3', 'Chillán', 'CL-10-CH3', '3780000', 34);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('BU2', 'Bulnes', 'CL-10-BU2', '3820000', 34);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('EL2', 'El Carmen', 'CL-10-EL2', '3850000', 34);

-- Itata (Provincia de Itata)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('QU2', 'Quirihue', 'CL-10-QU2', '3950000', 35);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RA2', 'Ránquil', 'CL-10-RA2', '3952000', 35);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('NA1', 'Ninhue', 'CL-10-NA1', '3953000', 35);

-- Punilla (Provincia de Punilla)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SC1', 'San Carlos', 'CL-10-SC1', '3840000', 36);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CO4', 'Coihueco', 'CL-10-CO4', '3880000', 36);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('SA1', 'San Fabián', 'CL-10-SA1', '3860000', 36);

-- Concepción (Provincia de Concepción)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CPN1', 'Concepción', 'CL-11-CPN1', '4030000', 37);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TA3', 'Talcahuano', 'CL-11-TA3', '4260000', 37);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CR1', 'Coronel', 'CL-11-CR1', '4190000', 37);

-- Arauco (Provincia de Arauco)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LE1', 'Lebu', 'CL-11-LE1', '4350000', 38);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('ARU1', 'Arauco', 'CL-11-ARU1', '4360000', 38);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL5', 'Cañete', 'CL-11-CL5', '4390000', 38);

-- Biobío (Provincia de Biobío)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LA3', 'Los Ángeles', 'CL-11-LA3', '4440000', 39);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MU1', 'Mulchén', 'CL-11-MU1', '4580000', 39);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('NA2', 'Nacimiento', 'CL-11-NA2', '4560000', 39);

-- Cautín (Provincia de Cautín)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TE2', 'Temuco', 'CL-12-TE2', '4780000', 40);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PA4', 'Padre Las Casas', 'CL-12-PA4', '4850000', 40);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VI2', 'Vilcún', 'CL-12-VI2', '4890000', 40);

-- Malleco (Provincia de Malleco)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AN2', 'Angol', 'CL-12-AN2', '4650000', 41);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VI3', 'Victoria', 'CL-12-VI3', '4720000', 41);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL6', 'Collipulli', 'CL-12-CL6', '4670000', 41);

-- Valdivia (Provincia de Valdivia)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VA2', 'Valdivia', 'CL-13-VA2', '5090000', 42);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MA3', 'Máfil', 'CL-13-MA3', '5140000', 42);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LC3', 'Lanco', 'CL-13-LC3', '5160000', 42);

-- Ranco (Provincia de Ranco)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LU1', 'La Unión', 'CL-13-LU1', '5220000', 43);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RA2', 'Río Bueno', 'CL-13-RA2', '5240000', 43);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('FU1', 'Futrono', 'CL-13-FU1', '5260000', 43);

-- Llanquihue (Provincia de Llanquihue)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PM1', 'Puerto Montt', 'CL-14-PM1', '5480000', 44);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PP1', 'Puerto Varas', 'CL-14-PP1', '5550000', 44);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('MA4', 'Maullín', 'CL-14-MA4', '5580000', 44);

-- Chiloé (Provincia de Chiloé)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CA1', 'Castro', 'CL-14-CA1', '5700000', 45);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('AN3', 'Ancud', 'CL-14-AN3', '5710000', 45);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('QC1', 'Quellón', 'CL-14-QC1', '5790000', 45);

-- Osorno (Provincia de Osorno)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('OS1', 'Osorno', 'CL-14-OS1', '5290000', 46);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PB1', 'Purranque', 'CL-14-PB1', '5380000', 46);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RA3', 'Río Negro', 'CL-14-RA3', '5360000', 46);

-- Palena (Provincia de Palena)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CL7', 'Chaitén', 'CL-14-CL7', '5850000', 47);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('FU2', 'Futaleufú', 'CL-14-FU2', '5870000', 47);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PL3', 'Palena', 'CL-14-PL3', '5860000', 47);

-- Coihaique (Provincia de Coihaique)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CO2', 'Coihaique', 'CL-15-CO2', '5950000', 48);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LA2', 'Lago Verde', 'CL-15-LA2', '5980000', 48);

-- Aysén (Provincia de Aysén)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PA2', 'Puerto Aysén', 'CL-15-PA2', '6000000', 49);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PI1', 'Puerto Chacabuco', 'CL-15-PI1', '6010000', 49);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VI4', 'Villa Mañihuales', 'CL-15-VI4', '6020000', 49);

-- Capitán Prat (Provincia de Capitán Prat)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CH2', 'Cochrane', 'CL-15-CH2', '6100000', 50);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RV1', 'Río Tranquilo', 'CL-15-RV1', '6110000', 50);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TI1', 'Tortel', 'CL-15-TI1', '6120000', 50);

-- General Carrera (Provincia de General Carrera)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CH3', 'Chile Chico', 'CL-15-CH3', '6200000', 51);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PU1', 'Puerto Ingeniero Ibáñez', 'CL-15-PU1', '6210000', 51);

-- Magallanes (Provincia de Magallanes)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PA3', 'Punta Arenas', 'CL-16-PA3', '6200000', 52);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PU2', 'Puerto Williams', 'CL-16-PU2', '6350000', 52);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('RO2', 'Río Verde', 'CL-16-RO2', '6240000', 52);

-- Antártica Chilena (Provincia de Antártica Chilena)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PB2', 'Puerto Toro', 'CL-16-PB2', '6360000', 53);

-- Tierra del Fuego (Provincia de Tierra del Fuego)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PV1', 'Porvenir', 'CL-16-PV1', '6310000', 54);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('CM1', 'Cameron', 'CL-16-CM1', '6330000', 54);

-- Última Esperanza (Provincia de Última Esperanza)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('PN1', 'Puerto Natales', 'CL-16-PN1', '6160000', 55);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('TR1', 'Torres del Paine', 'CL-16-TR1', '6170000', 55);

-- Marga Marga (Provincia de Marga Marga)
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('QJ1', 'Quilpué', 'CL-6-QJ1', '2430000', 56);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('VL1', 'Villa Alemana', 'CL-6-VL1', '2450000', 56);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('LM2', 'Limache', 'CL-6-LM2', '2240000', 56);
INSERT INTO city (code, name, ISO_code, zip_code, state_id) VALUES ('OL1', 'Olmué', 'CL-6-OL1', '2330000', 56);

--BANK
INSERT INTO bank (code, name) VALUES
('BCI', 'Banco de Crédito e Inversiones (BCI)'),
('SCOT', 'Scotiabank Chile'),
('SANT', 'Banco Santander Chile'),
('CHILE', 'Banco de Chile'),
('ESTADO', 'Banco del Estado de Chile (BancoEstado)');

-- REVIEW CONFIG
INSERT INTO review_config (code, comment_length, min_rating, max_rating)
VALUES
('Review', 255, 1, 5);

--CUSTOMER TYPE
INSERT INTO customer_type (code, description) VALUES
('NORM', 'Cliente Normal'),
('PREM', 'Cliente Premium'),
('VIP', 'Cliente VIP'),
('EMP', 'Empleado'),
('MAY', 'Mayorista'),
('FREQ', 'Cliente Frecuente'),
('ONLINE', 'Cliente Online'),
('PART', 'Cliente Participante de Promociones'),
('LOYA', 'Cliente de Programa de Lealtad'),
('DIS', 'Cliente con Descuento Especial');

--CUSTOMER
INSERT INTO customer (first_name, last_name, code, gender, birth_date, customer_type_id) VALUES
('Juan', 'Pérez', 'CUST001', 'M', '1985-03-15', 1),
('María', 'González', 'CUST002', 'F', '1990-07-22', 1),
('Carlos', 'López', 'CUST003', 'M', '1978-11-08', 1),
('Ana', 'Rojas', 'CUST004', 'F', '1983-01-14', 1),
('Pedro', 'Hernández', 'CUST005', 'M', '1992-05-30', 1),
('Lucía', 'Muñoz', 'CUST006', 'F', '1987-09-17', 1),
('Jorge', 'Sánchez', 'CUST007', 'M', '1975-12-05', 1),
('Sofía', 'Castillo', 'CUST008', 'F', '1995-04-10', 1),
('Rodrigo', 'Morales', 'CUST009', 'M', '1982-08-19', 2),
('Camila', 'Contreras', 'CUST010', 'F', '1993-06-27', 3),
('Francisco', 'Ramírez', 'CUST011', 'M', '1988-02-11', 4),
('Valentina', 'Reyes', 'CUST012', 'F', '1997-03-05', 5),
('Diego', 'Silva', 'CUST013', 'M', '1991-10-20', 6),
('Daniela', 'Ortega', 'CUST014', 'F', '1980-12-18', 7),
('Matías', 'Torres', 'CUST015', 'M', '1984-07-29', 8),
('Catalina', 'Vargas', 'CUST016', 'F', '1996-05-14', 9),
('Felipe', 'Espinoza', 'CUST017', 'M', '1976-11-03', 10),
('Francisca', 'Fuentes', 'CUST018', 'F', '1989-09-21', 5),
('Gonzalo', 'Gutiérrez', 'CUST019', 'M', '1983-03-25', 3),
('Fernanda', 'Mendoza', 'CUST020', 'F', '1992-01-30', 4);

-- IDENTIFICATION TYPE
INSERT INTO identification_type (code, description) VALUES
('RUT', 'Rol Único Tributario (RUT)'),
('DNI', 'Documento Nacional de Identidad'),
('PAS', 'Pasaporte'),
('CE', 'Cédula de Extranjería'),
('LIC', 'Licencia de Conducir'),
('IDN', 'Identificación Nacional'),
('IDEX', 'Identificación de Extranjero'),
('OTR', 'Otro tipo de Identificación');

-- IDENTIFICATION CUSTOMER
INSERT INTO identification_customer (identification_number, issue_date, expiration_date, type_id, customer_id) VALUES
('12345678-9', '2010-01-15', '2030-01-15', 1, 1),
('23456789-0', '2012-03-20', '2032-03-20', 1, 2),
('34567890-1', '2011-05-25', '2031-05-25', 1, 3),
('45678901-2', '2013-07-30', '2033-07-30', 1, 4),
('56789012-3', '2014-09-10', '2034-09-10', 1, 5),
('67890123-4', '2015-11-05', '2035-11-05', 1, 6),
('78901234-5', '2016-02-14', '2036-02-14', 1, 7),
('89012345-6', '2017-04-18', '2037-04-18', 1, 8),
('90123456-7', '2018-06-22', '2038-06-22', 1, 9),
('01234567-8', '2019-08-27', '2039-08-27', 1, 10),
('11223344-5', '2020-10-03', '2040-10-03', 1, 11),
('22334455-6', '2021-12-19', '2041-12-19', 1, 12),
('33445566-7', '2022-03-01', '2042-03-01', 1, 13),
('44556677-8', '2023-05-10', '2043-05-10', 1, 14),
('55667788-9', '2017-07-15', '2037-07-15', 1, 15),

('66778899-0', '2018-09-25', '2038-09-25', 2, 16),
('77889900-1', '2019-11-30', '2039-11-30', 3, 17),
('88990011-2', '2020-02-14', '2040-02-14', 4, 18),
('99001122-3', '2021-04-18', '2041-04-18', 5, 19),
('10011223-4', '2022-06-22', '2042-06-22', 6, 20);

-- USER
INSERT INTO "user" (code, name, last_name, identification_number, "user", password, email, enabled, last_login) VALUES
('U001', 'Juan', 'Pérez', '12345678-9', 'jperez', 'password123', 'jperez@intelia.ai', true, '2024-08-25 14:23:11'),
('U002', 'María', 'González', '23456789-0', 'mgonzalez', 'password456', 'mgonzalez@intelia.ai', true, '2024-08-26 09:45:20'),
('U003', 'Carlos', 'López', '34567890-1', 'clopez', 'password789', 'clopez@intelia.ai', true, '2024-08-27 11:32:47'),
('U004', 'Ana', 'Rojas', '45678901-2', 'arojas', 'password101', 'arojas@intelia.ai', true, '2024-08-24 08:15:33'),
('U005', 'Pedro', 'Hernández', '56789012-3', 'phernandez', 'password202', 'phernandez@intelia.ai', true, '2024-08-27 16:59:12'),
('U006', 'Lucía', 'Muñoz', '67890123-4', 'lmunoz', 'password303', 'lmunoz@intelia.ai', true, '2024-08-26 13:42:54'),
('U007', 'Jorge', 'Sánchez', '78901234-5', 'jsanchez', 'password404', 'jsanchez@intelia.ai', true, '2024-08-25 10:20:00'),
('U008', 'Sofía', 'Castillo', '89012345-6', 'scastillo', 'password505', 'scastillo@intelia.ai', true, '2024-08-27 09:05:37'),
('U009', 'Rodrigo', 'Morales', '90123456-7', 'rmorales', 'password606', 'rmorales@intelia.ai', true, '2024-08-27 07:33:19'),
('U010', 'Camila', 'Contreras', '01234567-8', 'ccontreras', 'password707', 'ccontreras@intelia.ai', true, '2024-08-26 12:47:23');

--EMAIL
INSERT INTO email (email_address) VALUES
('jperez@intelia.ai'),
('mgonzalez@intelia.ai'),
('clopez@intelia.ai'),
('arojas@intelia.ai'),
('phernandez@intelia.ai'),
('lmunoz@intelia.ai'),
('jsanchez@intelia.ai'),
('scastillo@intelia.ai'),
('rmorales@intelia.ai'),
('ccontreras@intelia.ai'),
('framirez@intelia.ai'),
('vreyes@intelia.ai'),
('dsilva@intelia.ai'),
('dortega@intelia.ai'),
('mtorres@intelia.ai'),
('cvargas@intelia.ai'),
('fespinoza@intelia.ai'),
('ffuentes@intelia.ai'),
('ggutierrez@intelia.ai'),
('fmendoza@intelia.ai');

--TELEPHONE
INSERT INTO telephone (area_code, country_code, phone, ext) VALUES
('2', '+56', '912345678', NULL),
('2', '+56', '923456789', NULL),
('2', '+56', '934567890', NULL),
('2', '+56', '945678901', NULL),
('2', '+56', '956789012', NULL),
('2', '+56', '967890123', NULL),
('2', '+56', '978901234', NULL),
('2', '+56', '989012345', NULL),
('2', '+56', '990123456', NULL),
('2', '+56', '901234567', NULL),
('2', '+56', '912345678', NULL),
('2', '+56', '923456789', NULL),
('2', '+56', '934567890', NULL),
('2', '+56', '945678901', NULL),
('2', '+56', '956789012', NULL),
('2', '+56', '967890123', NULL),
('2', '+56', '978901234', NULL),
('2', '+56', '989012345', NULL),
('2', '+56', '990123456', NULL),
('2', '+56', '901234567', NULL);

-- ADDRESS
INSERT INTO address (street, number, additional1, additional2, city_id) VALUES
('Av. Apoquindo', '1234', NULL, NULL, 1),
('Calle Los Leones', '5678', 'Depto 101', NULL, 2),
('Alameda', '9101', NULL, NULL, 3),
('Calle Huérfanos', '1122', NULL, NULL, 4),
('Avenida Italia', '3344', 'Piso 2', NULL, 5),
('Calle Nueva York', '5566', NULL, NULL, 6),
('Calle San Antonio', '7788', 'Oficina 202', NULL, 7),
('Avenida Vitacura', '9900', NULL, NULL, 8),
('Calle Las Dalias', '1212', NULL, NULL, 9),
('Calle Holanda', '3434', 'Depto 202', NULL, 10),
('Avenida Libertador', '5656', NULL, NULL, 11),
('Calle Manuel Montt', '7878', NULL, NULL, 12),
('Avenida Matta', '9090', NULL, NULL, 13),
('Calle Bellavista', '1313', NULL, NULL, 14),
('Avenida Las Condes', '1515', 'Piso 3', NULL, 15),
('Calle Santa Isabel', '1717', NULL, NULL, 16),
('Avenida Macul', '1919', NULL, NULL, 17),
('Calle San Diego', '2121', NULL, NULL, 18),
('Avenida Recoleta', '2323', NULL, NULL, 19),
('Calle Suecia', '2525', 'Depto 404', NULL, 20);

--CONTACT METHOD
INSERT INTO contact_method (contact_type, customer_id, email_id, telephone_id, address_id) VALUES
('CASA', 1, 1, 1, 1),

('TRABAJO', 2, 2, 2, 2),

('CASA', 3, 3, 3, 3),

('PRINCIPAL', 4, 4, 4, 4),

('CASA', 5, 5, 5, 5),

('CASA', 6, 6, 6, 6),

('CASA', 7, 7, 7, 7),

('TRABAJO', 8, 8, 8, 8),

('TRABAJO', 9, 9, 9, 9),

('TRABAJO', 10, 10, 10, 10),

('TRABAJO', 11, 11, 11, 11),

('TRABAJO', 12, 12, 12, 12),

('TRABAJO', 13, 13, 13, 13),

('PRINCIPAL', 14, 14, 14, 14),

('PRINCIPAL', 15, 15, 15, 15),

('PRINCIPAL', 16, 16, 16, 16),

('PRINCIPAL', 17, 17, 17, 17),

('CASA', 18, 18, 18, 18),

('TRABAJO', 19, 19, 19, 19),

('CASA', 20, 20, 20, 20);


INSERT INTO transaction_status_config (code, description)
VALUES 
    ('PENDING', 'La transacción ha sido iniciada pero aún no ha sido completada'),
    ('COMPLETED', 'La transacción ha sido completada exitosamente'),
    ('FAILED', 'La transacción ha fallado y no se ha podido procesar'),
    ('CANCELLED', 'La transacción ha sido cancelada por el usuario o el sistema'),
    ('REFUNDED', 'El monto de la transacción ha sido reembolsado al cliente'),
    ('ON_HOLD', 'La transacción está en espera por algún motivo, como revisión manual');
	

-- Nivel 1: Categorías principales
INSERT INTO product_category (code, description, parent_category_id) VALUES ('TEC', 'Tecnología', NULL);
INSERT INTO product_category (code, description, parent_category_id) VALUES ('HOME', 'Hogar', NULL);
INSERT INTO product_category (code, description, parent_category_id) VALUES ('FASHION', 'Moda', NULL);

-- Nivel 2: Subcategorías (dependen de las categorías principales)
INSERT INTO product_category (code, description, parent_category_id) VALUES ('TV', 'Televisores', (SELECT id FROM product_category WHERE code = 'TEC'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('COMP', 'Computadoras', (SELECT id FROM product_category WHERE code = 'TEC'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('KITCH', 'Cocina', (SELECT id FROM product_category WHERE code = 'HOME'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('BED', 'Dormitorio', (SELECT id FROM product_category WHERE code = 'HOME'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('MEN', 'Hombres', (SELECT id FROM product_category WHERE code = 'FASHION'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('WOMEN', 'Mujeres', (SELECT id FROM product_category WHERE code = 'FASHION'));

-- Nivel 3: Sub-subcategorías (dependen de las subcategorías)
INSERT INTO product_category (code, description, parent_category_id) VALUES ('SMART_TV', 'Televisores Smart', (SELECT id FROM product_category WHERE code = 'TV'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('LAPTOP', 'Laptops', (SELECT id FROM product_category WHERE code = 'COMP'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('FRIDGE', 'Refrigeradores', (SELECT id FROM product_category WHERE code = 'KITCH'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('BED_FURN', 'Muebles de Dormitorio', (SELECT id FROM product_category WHERE code = 'BED'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('M_SHIRTS', 'Camisas para Hombre', (SELECT id FROM product_category WHERE code = 'MEN'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('W_SHOES', 'Zapatos para Mujer', (SELECT id FROM product_category WHERE code = 'WOMEN'));

-- Marcas relacionadas con la categoría Tecnología (TEC)
INSERT INTO brand (code, name, description) VALUES 
    ('SAMSUNG', 'Samsung', 'Líder en tecnología de consumo, incluyendo televisores, smartphones y electrodomésticos'),
    ('APPLE', 'Apple', 'Reconocida marca de tecnología, famosa por sus iPhones, Macs y otros dispositivos innovadores'),
    ('SONY', 'Sony', 'Marca global en productos electrónicos, especialmente en audio, video y cámaras');

-- Marcas relacionadas con la categoría Hogar (HOME)
INSERT INTO brand (code, name, description) VALUES 
    ('WHIRLPOOL', 'Whirlpool', 'Fabricante líder de electrodomésticos para el hogar, incluyendo refrigeradores y lavadoras'),
    ('LG', 'LG Electronics', 'Proveedor global de soluciones para el hogar, incluyendo electrodomésticos y productos de tecnología'),
    ('PHILIPS', 'Philips', 'Marca líder en electrodomésticos y productos de salud para el hogar');

-- Marcas relacionadas con la categoría Moda (FASHION)
INSERT INTO brand (code, name, description) VALUES 
    ('NIKE', 'Nike', 'Líder mundial en ropa y calzado deportivo'),
    ('ADIDAS', 'Adidas', 'Marca global en ropa, calzado y accesorios deportivos'),
    ('ZARA', 'Zara', 'Marca de moda reconocida por su estilo contemporáneo y tendencias rápidas');

-- Marcas que pueden abarcar múltiples categorías (cross-category)
INSERT INTO brand (code, name, description) VALUES 
    ('HUAWEI', 'Huawei', 'Tecnología de vanguardia en smartphones, wearables y dispositivos de red'),
    ('PANASONIC', 'Panasonic', 'Empresa electrónica multinacional que ofrece desde cámaras hasta electrodomésticos'),
    ('BOSCH', 'Bosch', 'Proveedor líder en tecnología y servicios, con productos que van desde herramientas eléctricas hasta electrodomésticos');
	
-- Atributos generales para productos de tecnología, hogar y moda
-- Atributos comunes en Moda (FASHION)
INSERT INTO "attribute" (code, name, description) VALUES 
    ('SIZE', 'Talle', 'El tamaño del producto, como ropa o calzado, por ejemplo, S, M, L, XL'),
    ('COLOR', 'Color', 'El color del producto, aplicable a ropa, calzado y accesorios'),
    ('MATERIAL', 'Material', 'El material del producto, como algodón, cuero, sintético, etc.'),
    ('GENDER', 'Género', 'El género para el que está diseñado el producto, como Hombre, Mujer, Unisex');

-- Atributos comunes en Tecnología (TEC)
INSERT INTO "attribute" (code, name, description) VALUES 
    ('SCREEN_SIZE', 'Tamaño de Pantalla', 'El tamaño de la pantalla de dispositivos como televisores y computadoras, medido en pulgadas'),
    ('RESOLUTION', 'Resolución', 'La resolución de la pantalla de televisores, monitores o laptops, como Full HD, 4K'),
    ('PROCESSOR', 'Procesador', 'El tipo de procesador en computadoras o smartphones, como Intel Core i7, Apple M1'),
    ('MEMORY', 'Memoria RAM', 'La cantidad de memoria RAM en un dispositivo, medida en GB'),
    ('STORAGE', 'Almacenamiento', 'La capacidad de almacenamiento de un dispositivo, como 256GB, 1TB');

-- Atributos comunes en Hogar (HOME)
INSERT INTO "attribute" (code, name, description) VALUES 
    ('ENERGY_RATING', 'Clasificación Energética', 'El nivel de eficiencia energética de un electrodoméstico, como A++, B'),
    ('CAPACITY', 'Capacidad', 'La capacidad de un electrodoméstico, como la cantidad de litros en un refrigerador'),
    ('DIMENSIONS', 'Dimensiones', 'Las dimensiones físicas de un producto, como alto, ancho y profundidad, medidos en cm'),
    ('WEIGHT', 'Peso', 'El peso del producto, medido en kilogramos');


-- Productos de la categoría Tecnología (TEC)
INSERT INTO product (code, barcode, name, description, unit_price, net_price, category_id, brand_id, tax_rate_id)
VALUES 
    ('TVSMART01', '1234567890123', 'Samsung Smart TV 55"', 'Televisor inteligente 4K UHD con HDR', 499999.99, 420168.06, 
     (SELECT id FROM product_category WHERE code = 'SMART_TV'), 
     (SELECT id FROM brand WHERE code = 'SAMSUNG'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19')),

    ('LAPTOP01', '1234567890124', 'Apple MacBook Pro 13"', 'Laptop con chip Apple M1 y 256GB SSD', 1299999.99, 1092436.13, 
     (SELECT id FROM product_category WHERE code = 'LAPTOP'), 
     (SELECT id FROM brand WHERE code = 'APPLE'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19'));

-- Productos de la categoría Hogar (HOME)
INSERT INTO product (code, barcode, name, description, unit_price, net_price, category_id, brand_id, tax_rate_id)
VALUES 
    ('FRIDGE01', '1234567890125', 'LG Refrigerador No Frost 500L', 'Refrigerador con eficiencia energética A++', 749999.99, 630252.10, 
     (SELECT id FROM product_category WHERE code = 'FRIDGE'), 
     (SELECT id FROM brand WHERE code = 'LG'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19')),

    ('BEDSET01', '1234567890126', 'Whirlpool Juego de Dormitorio', 'Cama king size con colchón de alta densidad', 549999.99, 462184.87, 
     (SELECT id FROM product_category WHERE code = 'BED_FURN'), 
     (SELECT id FROM brand WHERE code = 'WHIRLPOOL'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19'));

-- Productos de la categoría Moda (FASHION)
INSERT INTO product (code, barcode, name, description, unit_price, net_price, category_id, brand_id, tax_rate_id)
VALUES 
    ('MSHIRT01', '1234567890127', 'Nike Camisa Hombre', 'Camisa deportiva Nike Dri-FIT', 49999.99, 42016.81, 
     (SELECT id FROM product_category WHERE code = 'M_SHIRTS'), 
     (SELECT id FROM brand WHERE code = 'NIKE'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19')),

    ('WSHOES01', '1234567890128', 'Adidas Zapatos Mujer', 'Zapatos deportivos Adidas Ultraboost', 149999.99, 126050.42, 
     (SELECT id FROM product_category WHERE code = 'W_SHOES'), 
     (SELECT id FROM brand WHERE code = 'ADIDAS'), 
     (SELECT id FROM tax_rates WHERE code = 'IVA19'));



-- Atributos para Samsung Smart TV
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('55"', 
     (SELECT id FROM product WHERE code = 'TVSMART01'), 
     (SELECT id FROM "attribute" WHERE code = 'SCREEN_SIZE')),
     
    ('4K UHD', 
     (SELECT id FROM product WHERE code = 'TVSMART01'), 
     (SELECT id FROM "attribute" WHERE code = 'RESOLUTION'));

-- Atributos para Apple MacBook Pro
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('13"', 
     (SELECT id FROM product WHERE code = 'LAPTOP01'), 
     (SELECT id FROM "attribute" WHERE code = 'SCREEN_SIZE')),
     
    ('Apple M1', 
     (SELECT id FROM product WHERE code = 'LAPTOP01'), 
     (SELECT id FROM "attribute" WHERE code = 'PROCESSOR')),
     
    ('8GB', 
     (SELECT id FROM product WHERE code = 'LAPTOP01'), 
     (SELECT id FROM "attribute" WHERE code = 'MEMORY')),
     
    ('256GB', 
     (SELECT id FROM product WHERE code = 'LAPTOP01'), 
     (SELECT id FROM "attribute" WHERE code = 'STORAGE'));

-- Atributos para LG Refrigerador
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('500L', 
     (SELECT id FROM product WHERE code = 'FRIDGE01'), 
     (SELECT id FROM "attribute" WHERE code = 'CAPACITY')),
     
    ('A++', 
     (SELECT id FROM product WHERE code = 'FRIDGE01'), 
     (SELECT id FROM "attribute" WHERE code = 'ENERGY_RATING'));

-- Atributos para Whirlpool Juego de Dormitorio
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('King Size', 
     (SELECT id FROM product WHERE code = 'BEDSET01'), 
     (SELECT id FROM "attribute" WHERE code = 'SIZE')),
     
    ('Blanco', 
     (SELECT id FROM product WHERE code = 'BEDSET01'), 
     (SELECT id FROM "attribute" WHERE code = 'COLOR'));

-- Atributos para Nike Camisa Hombre
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('M', 
     (SELECT id FROM product WHERE code = 'MSHIRT01'), 
     (SELECT id FROM "attribute" WHERE code = 'SIZE')),
     
    ('Rojo', 
     (SELECT id FROM product WHERE code = 'MSHIRT01'), 
     (SELECT id FROM "attribute" WHERE code = 'COLOR'));

-- Atributos para Adidas Zapatos Mujer
INSERT INTO product_attribute (value, product_id, attribute_id)
VALUES 
    ('38', 
     (SELECT id FROM product WHERE code = 'WSHOES01'), 
     (SELECT id FROM "attribute" WHERE code = 'SIZE')),
     
    ('Negro', 
     (SELECT id FROM product WHERE code = 'WSHOES01'), 
     (SELECT id FROM "attribute" WHERE code = 'COLOR'));


INSERT INTO terminal_category (code, description) VALUES 
    ('POS', 'Punto de Venta'),
    ('KIOSK', 'Kiosco de Autoservicio'),
    ('ONLINE', 'Terminal de Ventas Online'),
    ('CUST_SERV', 'Terminal de Servicio al Cliente'),
    ('CHECKOUT', 'Caja Registradora');


INSERT INTO store (code, name, email, address, phone_number, city_id) VALUES 
    ('ST001', 'Intelia Iquique', 'iquique@intelia.com', 'Av. Héroes de la Concepción 2555, Iquique', '+56 57 123 4567', 
    (SELECT id FROM city WHERE code = 'IQ1')),
    
    ('ST002', 'Intelia Antofagasta', 'antofagasta@intelia.com', 'Av. Balmaceda 2355, Antofagasta', '+56 55 234 5678', 
    (SELECT id FROM city WHERE code = 'AN1')),
    
    ('ST003', 'Intelia Santiago', 'santiago@intelia.com', 'Av. Libertador Bernardo O\'Higgins 1234, Santiago', '+56 2 876 5432', 
    (SELECT id FROM city WHERE code = 'ST1')),
    
    ('ST004', 'Intelia Valparaíso', 'valparaiso@intelia.com', 'Av. Pedro Montt 4567, Valparaíso', '+56 32 765 4321', 
    (SELECT id FROM city WHERE code = 'VA3')),
    
    ('ST005', 'Intelia Puerto Montt', 'puertomontt@intelia.com', 'Av. Presidente Ibáñez 6789, Puerto Montt', '+56 65 987 6543', 
    (SELECT id FROM city WHERE code = 'PM1'));

-- Terminales para Falabella Iquique
INSERT INTO terminal (code, name, store_id, terminal_category_id) VALUES 
    ('TERM001', 'Caja 1', 
    (SELECT id FROM store WHERE code = 'ST001'), 
    (SELECT id FROM terminal_category WHERE code = 'CHECKOUT')),
    
    ('TERM002', 'Kiosco 1', 
    (SELECT id FROM store WHERE code = 'ST001'), 
    (SELECT id FROM terminal_category WHERE code = 'KIOSK')),
    
    ('TERM003', 'Servicio al Cliente', 
    (SELECT id FROM store WHERE code = 'ST001'), 
    (SELECT id FROM terminal_category WHERE code = 'POS'));

-- Terminales para Falabella Antofagasta
INSERT INTO terminal (code, name, store_id, terminal_category_id) VALUES 
    ('TERM004', 'Caja 1', 
    (SELECT id FROM store WHERE code = 'ST002'), 
    (SELECT id FROM terminal_category WHERE code = 'CHECKOUT')),
    
    ('TERM005', 'Kiosco 1', 
    (SELECT id FROM store WHERE code = 'ST002'), 
    (SELECT id FROM terminal_category WHERE code = 'POS')),
    
    ('TERM006', 'Terminal Online', 
    (SELECT id FROM store WHERE code = 'ST002'), 
    (SELECT id FROM terminal_category WHERE code = 'ONLINE'));

-- Terminales para Falabella Santiago
INSERT INTO terminal (code, name, store_id, terminal_category_id) VALUES 
    ('TERM007', 'Caja 1', 
    (SELECT id FROM store WHERE code = 'ST003'), 
    (SELECT id FROM terminal_category WHERE code = 'POS')),
    
    ('TERM008', 'Caja 2', 
    (SELECT id FROM store WHERE code = 'ST003'), 
    (SELECT id FROM terminal_category WHERE code = 'CHECKOUT')),
    
    ('TERM009', 'Kiosco 1', 
    (SELECT id FROM store WHERE code = 'ST003'), 
    (SELECT id FROM terminal_category WHERE code = 'KIOSK'));

-- Terminales para Falabella Valparaíso
INSERT INTO terminal (code, name, store_id, terminal_category_id) VALUES 
    ('TERM010', 'Caja 1', 
    (SELECT id FROM store WHERE code = 'ST004'), 
    (SELECT id FROM terminal_category WHERE code = 'CHECKOUT')),
    
    ('TERM011', 'Kiosco 1', 
    (SELECT id FROM store WHERE code = 'ST004'), 
    (SELECT id FROM terminal_category WHERE code = 'KIOSK')),
    
    ('TERM012', 'Terminal Online', 
    (SELECT id FROM store WHERE code = 'ST004'), 
    (SELECT id FROM terminal_category WHERE code = 'POS'));

-- Terminales para Falabella Puerto Montt
INSERT INTO terminal (code, name, store_id, terminal_category_id) VALUES 
    ('TERM013', 'Caja 1', 
    (SELECT id FROM store WHERE code = 'ST005'), 
    (SELECT id FROM terminal_category WHERE code = 'CHECKOUT')),
    
    ('TERM014', 'Kiosco 1', 
    (SELECT id FROM store WHERE code = 'ST005'), 
    (SELECT id FROM terminal_category WHERE code = 'POS')),
    
    ('TERM015', 'Servicio al Cliente', 
    (SELECT id FROM store WHERE code = 'ST005'), 
    (SELECT id FROM terminal_category WHERE code = 'CUST_SERV'));
