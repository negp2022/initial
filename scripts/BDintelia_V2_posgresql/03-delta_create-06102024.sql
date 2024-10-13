-- Agregar la columna user_id a la tabla discount_transaction
ALTER TABLE discount_transaction
ADD COLUMN user_id INTEGER NOT NULL;

-- Agregar la restricción de clave foránea para user_id
ALTER TABLE discount_transaction
ADD CONSTRAINT fk_discount_transaction_user
    FOREIGN KEY (user_id) REFERENCES "user"(id);


ALTER TABLE card_payment
ADD COLUMN bank_id INTEGER NULL;

ALTER TABLE card_payment
ADD CONSTRAINT fk_card_payment_bank
    FOREIGN KEY (bank_id) REFERENCES bank(id);

-- Paso 1: Eliminar la restricción de clave foránea
ALTER TABLE product_review
DROP CONSTRAINT product_review_review_config_id_fkey;

-- Paso 2 (Opcional): Eliminar la columna review_config_id
ALTER TABLE product_review
DROP COLUMN review_config_id;

-- Paso 1: Eliminar la restricción de clave foránea
ALTER TABLE product_review
DROP CONSTRAINT product_review_product_id_fkey;

-- Paso 2 (Opcional): Eliminar la columna product_id
ALTER TABLE product_review
DROP COLUMN product_id;

ALTER TABLE product_review
ALTER COLUMN comment DROP NOT NULL;

-- 1. Eliminar la restricción de clave foránea existente en transaction_detail
ALTER TABLE transaction_detail
DROP CONSTRAINT transaction_detail_product_review_id_fkey;

-- 2. Eliminar la columna product_review_id de transaction_detail
ALTER TABLE transaction_detail
DROP COLUMN product_review_id;

-- 3. Agregar la columna transaction_detail_id en product_review
ALTER TABLE product_review
ADD COLUMN transaction_detail_id INT;

-- 4. Crear la nueva restricción de clave foránea en product_review
ALTER TABLE product_review
ADD CONSTRAINT product_review_transaction_detail_id_fkey
FOREIGN KEY (transaction_detail_id)
REFERENCES transaction_detail(id);