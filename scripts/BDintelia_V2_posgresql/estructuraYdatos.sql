CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    ISO_code VARCHAR(10) NOT NULL
);

CREATE TABLE region (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    ISO_code VARCHAR(10) NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT fk_region_country FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE state (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    ISO_code VARCHAR(10) NOT NULL,
    region_id INT NOT NULL,
    CONSTRAINT fk_state_region FOREIGN KEY (region_id) REFERENCES region(id)
);

CREATE TABLE city (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    ISO_code VARCHAR(10) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    state_id INT NOT NULL,
    CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES state(id)
);

-- Tabla: identification_type
CREATE TABLE identification_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: customer_type
CREATE TABLE customer_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: customer
CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    code VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    customer_type_id INT NOT NULL,
    FOREIGN KEY (customer_type_id) REFERENCES customer_type(id)
);

-- Tabla: email
CREATE TABLE email (
    id SERIAL PRIMARY KEY,
    email_address VARCHAR NOT NULL
);

-- Tabla: telephone
CREATE TABLE telephone (
    id SERIAL PRIMARY KEY,
    area_code VARCHAR,
    country_code VARCHAR,
    phone VARCHAR NOT NULL,
    ext VARCHAR
);

-- Tabla: address
CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    street VARCHAR NOT NULL,
    number VARCHAR NOT NULL,
    additional1 VARCHAR,
    additional2 VARCHAR,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- Tabla: contact_method
CREATE TABLE contact_method (
    id SERIAL PRIMARY KEY,
    contact_type VARCHAR NOT NULL,
    customer_id INT NOT NULL,
    email_id INT,
    telephone_id INT,
    address_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (email_id) REFERENCES email(id),
    FOREIGN KEY (telephone_id) REFERENCES telephone(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);

-- Tabla: identification_customer
CREATE TABLE identification_customer (
    identification_number VARCHAR PRIMARY KEY,
    issue_date DATE NOT NULL,
    expiration_date DATE NOT NULL,
    type_id INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- Tabla: terminal_category
CREATE TABLE terminal_category (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: store
CREATE TABLE store (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    phone_number VARCHAR NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- Tabla: terminal
CREATE TABLE terminal (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    store_id INT NOT NULL,
    terminal_category_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES store(id),
    FOREIGN KEY (terminal_category_id) REFERENCES terminal_category(id)
);

-- Tabla: payment_method_config
CREATE TABLE payment_method_config (
    id SERIAL PRIMARY KEY,
    sale_enabled BOOLEAN DEFAULT true NOT NULL,
    return_enabled BOOLEAN DEFAULT true NOT NULL,
    min_accepted DECIMAL NOT NULL,
    max_accepted DECIMAL NOT NULL,
    payment_type_code VARCHAR UNIQUE
);

-- Tabla: payment_type
CREATE TABLE payment_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    ISO_code VARCHAR NOT NULL,
    payment_method_config_id INT UNIQUE REFERENCES payment_method_config(id) ON DELETE CASCADE
);

-- Tabla: transaction_type
CREATE TABLE transaction_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: receipt_type
CREATE TABLE receipt_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: transaction_status_config
CREATE TABLE transaction_status_config (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    description VARCHAR NOT NULL
);

-- Tabla: transaction
CREATE TABLE transaction (
    id SERIAL PRIMARY KEY,
    total DECIMAL NOT NULL,
    fiscal_number VARCHAR,
    cancel_flag BOOLEAN NOT NULL,
    begin_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    id_tx VARCHAR NOT NULL,
    original_id_tx VARCHAR,
    original_fiscal_number VARCHAR,
    terminal_id INT NOT NULL,
    customer_id INT,
    transaction_type_id INT NOT NULL,
    receipt_type_id INT,
    transaction_status_config_id INT NOT NULL,
    FOREIGN KEY (terminal_id) REFERENCES terminal(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (transaction_type_id) REFERENCES transaction_type(id),
    FOREIGN KEY (receipt_type_id) REFERENCES receipt_type(id),
    FOREIGN KEY (transaction_status_config_id) REFERENCES transaction_status_config(id)
);


-- Tabla: payment_transaction
CREATE TABLE payment_transaction (
    id SERIAL PRIMARY KEY,
    amount DECIMAL NOT NULL,
    payment_type_id INT NOT NULL,
    transaction_id INT NOT NULL,
    FOREIGN KEY (payment_type_id) REFERENCES payment_type(id),
    FOREIGN KEY (transaction_id) REFERENCES transaction(id) ON DELETE CASCADE
);


-- Tabla: bank
CREATE TABLE bank (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL
);

-- Tabla: card_payment
CREATE TABLE card_payment (
    id SERIAL PRIMARY KEY,
    card_number VARCHAR NOT NULL,
    authorization_code VARCHAR NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    payment_transaction_id INT NOT NULL,
    bank_id INTEGER NOT NULL,
    FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id),
    CONSTRAINT fk_card_payment_bank
        FOREIGN KEY (bank_id) REFERENCES bank(id)
);


-- Tabla: bank_transfer_payment
CREATE TABLE bank_transfer_payment (
    id SERIAL PRIMARY KEY,
    transfer_tx_id VARCHAR NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    payment_transaction_id INT NOT NULL,
    FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id)
);

-- Tabla: wallet_payment
CREATE TABLE wallet_payment (
    id SERIAL PRIMARY KEY,
    transaction_number VARCHAR NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    payment_transaction_id INT NOT NULL,
    FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id)
);

-- Tabla: role
CREATE TABLE "role" (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    enabled BOOLEAN DEFAULT true NOT NULL,
    role_activity VARCHAR NOT NULL
);

-- Tabla: user
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    identification_number VARCHAR NOT NULL,
    "user" VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    enabled BOOLEAN DEFAULT true NOT NULL,
    last_login TIMESTAMP
);

-- Tabla: user_role
CREATE TABLE user_role (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user"(id),
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- Tabla: promo_type
CREATE TABLE promo_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

-- Tabla: promotion
CREATE TABLE promotion (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    creation_at TIMESTAMP NOT NULL,
    valid_from TIMESTAMP NOT NULL,
    valid_until TIMESTAMP,
    promo_type_id INT NOT NULL,
    FOREIGN KEY (promo_type_id) REFERENCES promo_type(id)
);

-- Tabla: tax_rates
CREATE TABLE tax_rates (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    rate DECIMAL(5, 2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP
);

-- Tabla: adjustment_type
CREATE TABLE adjustment_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL
);

-- Tabla: warehouse
CREATE TABLE warehouse (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- Tabla: brand
CREATE TABLE brand (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL
);

-- Tabla: product_category
CREATE TABLE product_category (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    parent_category_id INT,  -- Esta columna establece la relación recursiva

    -- Definición de la clave foránea para la relación recursiva
    CONSTRAINT fk_parent_category
    FOREIGN KEY (parent_category_id)
    REFERENCES product_category(id)
    ON DELETE SET NULL  -- Si se elimina la categoría padre, se establece a NULL
);


-- Tabla: attribute
CREATE TABLE "attribute" (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL
);

-- Tabla: product
CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    barcode VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    enabled BOOLEAN DEFAULT TRUE NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    net_price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    tax_rate_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_category(id),
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (tax_rate_id) REFERENCES tax_rates(id)
);

-- Tabla: product_attribute
CREATE TABLE product_attribute (
    id SERIAL PRIMARY KEY,
    value VARCHAR(255) NOT NULL,
    product_id INT NOT NULL,
    attribute_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_id) REFERENCES "attribute"(id)
);

-- Tabla: promotion_detail
CREATE TABLE promotion_detail (
    id SERIAL PRIMARY KEY,
    discount_percent DECIMAL(5, 2),
    discount_amount DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    product_id INT NOT NULL,
    promotion_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (promotion_id) REFERENCES promotion(id)
);

-- Tabla: inventory
CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    quantity_onsale INT NOT NULL DEFAULT 0,
    quantity_reserved INT NOT NULL DEFAULT 0,
    quantity_available INT NOT NULL DEFAULT 0,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(id)
);

-- Tabla: inventory_adjustment
CREATE TABLE inventory_adjustment (
    id SERIAL PRIMARY KEY,
    quantity INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    product_id INT NOT NULL,
    adjustment_type_id INT NOT NULL,
    user_id INT NOT NULL,
    inventory_id INT NOT null,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (adjustment_type_id) REFERENCES adjustment_type(id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(id),
    FOREIGN KEY (user_id) REFERENCES "user"(id)
);

-- Tabla: review_config
CREATE TABLE review_config (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    comment_length INT NOT NULL,
    min_rating INT NOT NULL,
    max_rating INT NOT NULL
);

CREATE TABLE product_review (
    id SERIAL PRIMARY KEY,
    rating INT NOT NULL,
    comment VARCHAR NULL,
    create_at TIMESTAMP NOT NULL,
    customer_id INT NOT NULL,
    transaction_detail_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (transaction_detail_id) REFERENCES transaction_detail(id)
);

-- Tabla: discount_transaction
CREATE TABLE discount_transaction (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    percentage DECIMAL(5, 2) NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_discount_transaction_user
        FOREIGN KEY (user_id) REFERENCES "user"(id)
);

-- Tabla: transaction_detail
CREATE TABLE transaction_detail (
    id SERIAL PRIMARY KEY,
    id_transaction INT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_discount DECIMAL(10, 2) NOT NULL,
    total_promo DECIMAL(10, 2),
    product_id INT NOT NULL,
    discount_transaction_id INT,
    user_id INT NOT NULL,
    FOREIGN KEY (id_transaction) REFERENCES transaction(id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (discount_transaction_id) REFERENCES discount_transaction(id),
    FOREIGN KEY (user_id) REFERENCES "user"(id)
);

	
INSERT INTO bank (code, name) VALUES
('BCI', 'Banco de Crédito e Inversiones (BCI)'),
('SCOT', 'Scotiabank Chile'),
('SANT', 'Banco Santander Chile'),
('CHILE', 'Banco de Chile'),
('ESTADO', 'Banco del Estado de Chile (BancoEstado)');

INSERT INTO review_config (code, comment_length, min_rating, max_rating)
VALUES
('Review', 255, 1, 5);

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

INSERT INTO identification_type (code, description) VALUES
('RUT', 'Rol Único Tributario (RUT)'),
('DNI', 'Documento Nacional de Identidad'),
('PAS', 'Pasaporte'),
('CE', 'Cédula de Extranjería'),
('LIC', 'Licencia de Conducir'),
('IDN', 'Identificación Nacional'),
('IDEX', 'Identificación de Extranjero'),
('OTR', 'Otro tipo de Identificación');

INSERT INTO transaction_status_config (code, description)
VALUES 
    ('PENDING', 'La transacción ha sido iniciada pero aún no ha sido completada'),
    ('COMPLETED', 'La transacción ha sido completada exitosamente'),
    ('FAILED', 'La transacción ha fallado y no se ha podido procesar'),
    ('CANCELLED', 'La transacción ha sido cancelada por el usuario o el sistema'),
    ('REFUNDED', 'El monto de la transacción ha sido reembolsado al cliente'),
    ('ON_HOLD', 'La transacción está en espera por algún motivo, como revisión manual');
	
INSERT INTO product_category (code, description, parent_category_id) VALUES ('TEC', 'Tecnología', NULL);
INSERT INTO product_category (code, description, parent_category_id) VALUES ('HOME', 'Hogar', NULL);
INSERT INTO product_category (code, description, parent_category_id) VALUES ('FASHION', 'Moda', NULL);

INSERT INTO product_category (code, description, parent_category_id) VALUES ('TV', 'Televisores', (SELECT id FROM product_category WHERE code = 'TEC'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('COMP', 'Computadoras', (SELECT id FROM product_category WHERE code = 'TEC'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('KITCH', 'Cocina', (SELECT id FROM product_category WHERE code = 'HOME'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('BED', 'Dormitorio', (SELECT id FROM product_category WHERE code = 'HOME'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('MEN', 'Hombres', (SELECT id FROM product_category WHERE code = 'FASHION'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('WOMEN', 'Mujeres', (SELECT id FROM product_category WHERE code = 'FASHION'));

INSERT INTO product_category (code, description, parent_category_id) VALUES ('SMART_TV', 'Televisores Smart', (SELECT id FROM product_category WHERE code = 'TV'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('LAPTOP', 'Laptops', (SELECT id FROM product_category WHERE code = 'COMP'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('FRIDGE', 'Refrigeradores', (SELECT id FROM product_category WHERE code = 'KITCH'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('BED_FURN', 'Muebles de Dormitorio', (SELECT id FROM product_category WHERE code = 'BED'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('M_SHIRTS', 'Camisas para Hombre', (SELECT id FROM product_category WHERE code = 'MEN'));
INSERT INTO product_category (code, description, parent_category_id) VALUES ('W_SHOES', 'Zapatos para Mujer', (SELECT id FROM product_category WHERE code = 'WOMEN'));

INSERT INTO brand (code, name, description) VALUES 
    ('SAMSUNG', 'Samsung', 'Líder en tecnología de consumo, incluyendo televisores, smartphones y electrodomésticos'),
    ('APPLE', 'Apple', 'Reconocida marca de tecnología, famosa por sus iPhones, Macs y otros dispositivos innovadores'),
    ('SONY', 'Sony', 'Marca global en productos electrónicos, especialmente en audio, video y cámaras');

-- Marcas relacionadas con la categoría Hogar (HOME)
INSERT INTO brand (code, name, description) VALUES 
    ('WHIRLPOOL', 'Whirlpool', 'Fabricante líder de electrodomésticos para el hogar, incluyendo refrigeradores y lavadoras'),
    ('LG', 'LG Electronics', 'Proveedor global de soluciones para el hogar, incluyendo electrodomésticos y productos de tecnología'),
    ('PHILIPS', 'Philips', 'Marca líder en electrodomésticos y productos de salud para el hogar');

INSERT INTO brand (code, name, description) VALUES 
    ('NIKE', 'Nike', 'Líder mundial en ropa y calzado deportivo'),
    ('ADIDAS', 'Adidas', 'Marca global en ropa, calzado y accesorios deportivos'),
    ('ZARA', 'Zara', 'Marca de moda reconocida por su estilo contemporáneo y tendencias rápidas');

INSERT INTO brand (code, name, description) VALUES 
    ('HUAWEI', 'Huawei', 'Tecnología de vanguardia en smartphones, wearables y dispositivos de red'),
    ('PANASONIC', 'Panasonic', 'Empresa electrónica multinacional que ofrece desde cámaras hasta electrodomésticos'),
    ('BOSCH', 'Bosch', 'Proveedor líder en tecnología y servicios, con productos que van desde herramientas eléctricas hasta electrodomésticos');
	
INSERT INTO "attribute" (code, name, description) VALUES 
    ('SIZE', 'Talle', 'El tamaño del producto, como ropa o calzado, por ejemplo, S, M, L, XL'),
    ('COLOR', 'Color', 'El color del producto, aplicable a ropa, calzado y accesorios'),
    ('MATERIAL', 'Material', 'El material del producto, como algodón, cuero, sintético, etc.'),
    ('GENDER', 'Género', 'El género para el que está diseñado el producto, como Hombre, Mujer, Unisex');

INSERT INTO "attribute" (code, name, description) VALUES 
    ('SCREEN_SIZE', 'Tamaño de Pantalla', 'El tamaño de la pantalla de dispositivos como televisores y computadoras, medido en pulgadas'),
    ('RESOLUTION', 'Resolución', 'La resolución de la pantalla de televisores, monitores o laptops, como Full HD, 4K'),
    ('PROCESSOR', 'Procesador', 'El tipo de procesador en computadoras o smartphones, como Intel Core i7, Apple M1'),
    ('MEMORY', 'Memoria RAM', 'La cantidad de memoria RAM en un dispositivo, medida en GB'),
    ('STORAGE', 'Almacenamiento', 'La capacidad de almacenamiento de un dispositivo, como 256GB, 1TB');

INSERT INTO "attribute" (code, name, description) VALUES 
    ('ENERGY_RATING', 'Clasificación Energética', 'El nivel de eficiencia energética de un electrodoméstico, como A++, B'),
    ('CAPACITY', 'Capacidad', 'La capacidad de un electrodoméstico, como la cantidad de litros en un refrigerador'),
    ('DIMENSIONS', 'Dimensiones', 'Las dimensiones físicas de un producto, como alto, ancho y profundidad, medidos en cm'),
    ('WEIGHT', 'Peso', 'El peso del producto, medido en kilogramos');

INSERT INTO transaction_type (code, name, description)
VALUES 
    ('1', 'Venta', 'Venta de productos o servicios al cliente'),
    ('2', 'Devolución', 'Devolución de productos por parte del cliente'),
    ('3', 'Cambio', 'Cambio de un producto por otro de igual o diferente valor'),
    ('4', 'Arqueo', 'Arqueo de caja'),
    ('5', 'Dotación', 'Dotación de caja'),
    ('6', 'Retiro', 'Retiro de caja'),
    ('7', 'Login', 'Login de usuario');
	
INSERT INTO receipt_type (code, name, description)
VALUES 
    ('F01', 'Factura', 'Comprobante fiscal que detalla la transacción de venta de productos o servicios, incluye IVA'),
    ('B01', 'Boleta de Venta', 'Comprobante que registra la venta de productos o servicios a un consumidor final, sin detalle fiscal como en la factura'),
    ('NC01', 'Nota de Crédito', 'Documento que se emite para anular o corregir una factura, por ejemplo, en caso de devoluciones'),
    ('ND01', 'Nota de Débito', 'Documento utilizado para aumentar el valor de una factura ya emitida, como por intereses o cargos adicionales'),
    ('GD01', 'Guía de Despacho', 'Documento que acompaña el traslado de mercaderías, detalla los productos transportados pero no es un comprobante de venta en sí mismo');
	
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
	
INSERT INTO terminal_category (code, description) VALUES 
    ('POS', 'Punto de Venta'),
    ('KIOSK', 'Kiosco de Autoservicio'),
    ('ONLINE', 'Terminal de Ventas Online'),
    ('CUST_SERV', 'Terminal de Servicio al Cliente'),
    ('CHECKOUT', 'Caja Registradora');

INSERT INTO promo_type (code, description)
VALUES 
    ('amount', 'Tipo de promoción basada en descuento por monto'),
    ('percentage', 'Tipo de promoción basada en descuento por porcentaje'),
    ('newPrice', 'Tipo de promoción basada en un nuevo precio');