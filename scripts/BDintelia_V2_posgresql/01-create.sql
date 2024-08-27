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
    --FOREIGN KEY (type_id) REFERENCES identification_type(id),--se debe eliminar
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

-- Tabla: payment_type
CREATE TABLE payment_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    ISO_code VARCHAR NOT NULL,
    payment_method_config_id INT UNIQUE REFERENCES payment_method_config(id) ON DELETE CASCADE
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


-- Tabla: payment_transaction
CREATE TABLE payment_transaction (
    id SERIAL PRIMARY KEY,
    amount DECIMAL NOT NULL,
    payment_type_id INT NOT NULL,
    FOREIGN KEY (payment_type_id) REFERENCES payment_type(id)
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
    FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id)
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
    payment_transaction_id INT NOT NULL,
    terminal_id INT NOT NULL,
    customer_id INT NOT NULL,
    transaction_type_id INT NOT NULL,
    receipt_type_id INT NOT NULL,
    transaction_status_config_id INT NOT NULL,
    FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id),
    FOREIGN KEY (terminal_id) REFERENCES terminal(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (transaction_type_id) REFERENCES transaction_type(id),
    FOREIGN KEY (receipt_type_id) REFERENCES receipt_type(id),
    FOREIGN KEY (transaction_status_config_id) REFERENCES transaction_status_config(id)
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
    description VARCHAR(255) NOT NULL
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

-- Tabla: product_review
CREATE TABLE product_review (
    id SERIAL PRIMARY KEY,
    rating INT NOT NULL,
    comment VARCHAR NOT NULL,
    create_at TIMESTAMP NOT NULL,
    product_id INT NOT NULL,
    review_config_id INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (review_config_id) REFERENCES review_config(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- Tabla: discount_transaction
CREATE TABLE discount_transaction (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    percentage DECIMAL(5, 2) NOT NULL
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
    product_review_id INT,
    FOREIGN KEY (id_transaction) REFERENCES transaction(id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (discount_transaction_id) REFERENCES discount_transaction(id),
    FOREIGN KEY (user_id) REFERENCES "user"(id),
    FOREIGN KEY (product_review_id) REFERENCES product_review(id)
);
