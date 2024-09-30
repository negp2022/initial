ALTER TABLE transaction
ADD COLUMN original_id_tx VARCHAR,
ADD COLUMN original_fiscal_number VARCHAR;

ALTER TABLE transaction
ALTER COLUMN customer_id DROP NOT NULL;

ALTER TABLE transaction
ALTER COLUMN receipt_type_id DROP NOT NULL;
