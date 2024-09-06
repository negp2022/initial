DO $$ 
BEGIN 
    -- Verificar si la columna 'transaction_id' no existe
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'payment_transaction' 
        AND column_name = 'transaction_id'
    ) THEN
        -- Añadir la columna 'transaction_id'
        ALTER TABLE payment_transaction 
        ADD COLUMN transaction_id INT NOT NULL;
        
        -- Añadir la clave foránea para 'transaction_id'
        ALTER TABLE payment_transaction 
        ADD CONSTRAINT fk_transaction 
        FOREIGN KEY (transaction_id) REFERENCES transaction(id) ON DELETE CASCADE;
    END IF;
END $$;

DO $$ 
BEGIN
    -- Verificar si la clave foránea para 'transaction_id' ya existe
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.table_constraints 
        WHERE table_name = 'payment_transaction' 
        AND constraint_type = 'FOREIGN KEY' 
        AND constraint_name = 'fk_transaction'
    ) THEN
        -- Crear la clave foránea
        ALTER TABLE payment_transaction 
        ADD CONSTRAINT fk_transaction 
        FOREIGN KEY (transaction_id) REFERENCES transaction(id) ON DELETE CASCADE;
    END IF;
END $$;

DO $$
BEGIN
    -- Verifica si la restricción de clave foránea existe antes de intentar eliminarla
    IF EXISTS (
        SELECT 1
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
        WHERE tc.constraint_type = 'FOREIGN KEY'
        AND tc.table_name = 'transaction'
        AND kcu.column_name = 'payment_transaction_id'
    ) THEN
        -- Elimina la restricción de clave foránea
        ALTER TABLE transaction DROP CONSTRAINT IF EXISTS transaction_payment_transaction_id_fkey;
        
        -- Elimina la columna relacionada
        ALTER TABLE transaction DROP COLUMN IF EXISTS payment_transaction_id;
    END IF;
END $$;
