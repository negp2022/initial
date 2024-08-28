DO $$
BEGIN
    -- Verificar si la columna 'name' ya existe en la tabla 'transaction_type'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='transaction_type' AND column_name='name'
    ) THEN
        -- Agregar la columna 'name' a la tabla 'transaction_type'
        ALTER TABLE transaction_type ADD COLUMN name VARCHAR NOT NULL;
    END IF;
END $$;

DO $$
BEGIN
    -- Verificar si la columna 'name' ya existe en la tabla 'receipt_type'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='receipt_type' AND column_name='name'
    ) THEN
        -- Agregar la columna 'name' a la tabla 'receipt_type'
        ALTER TABLE receipt_type ADD COLUMN name VARCHAR NOT NULL;
    END IF;
END $$;

DO $$
BEGIN
    -- Verificar si la columna 'payment_type_code' ya existe en la tabla 'payment_method_config'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='payment_method_config' AND column_name='payment_type_code'
    ) THEN
        -- Agregar la columna 'payment_type_code' a la tabla 'payment_method_config'
        ALTER TABLE payment_method_config
        ADD COLUMN payment_type_code VARCHAR UNIQUE;
    END IF;
END $$;


DO $$
BEGIN
    -- Verificar si la columna 'payment_method_config_id' ya existe en la tabla 'payment_type'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='payment_type' AND column_name='payment_method_config_id'
    ) THEN
        -- Agregar la columna 'payment_method_config_id' a la tabla 'payment_type'
        ALTER TABLE payment_type
        ADD COLUMN payment_method_config_id INT UNIQUE;
    END IF;

    -- Verificar si la clave foránea ya existe en la tabla 'payment_type'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
        WHERE tc.table_name = 'payment_type' 
        AND tc.constraint_type = 'FOREIGN KEY'
        AND kcu.column_name = 'payment_method_config_id'
    ) THEN
        -- Crear la clave foránea para 'payment_method_config_id'
        ALTER TABLE payment_type
        ADD CONSTRAINT fk_payment_method_config
        FOREIGN KEY (payment_method_config_id)
        REFERENCES payment_method_config(id)
        ON DELETE CASCADE;
    END IF;
END $$;

DO $$
BEGIN
    -- Verificar si la columna 'parent_category_id' ya existe en la tabla 'product_category'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name='product_category' AND column_name='parent_category_id'
    ) THEN
        -- Agregar la columna 'parent_category_id'
        ALTER TABLE product_category
        ADD COLUMN parent_category_id INT;
    END IF;

    -- Verificar si la clave foránea ya existe en la tabla 'product_category'
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
        WHERE tc.table_name = 'product_category' 
        AND tc.constraint_type = 'FOREIGN KEY'
        AND kcu.column_name = 'parent_category_id'
    ) THEN
        -- Crear la clave foránea para 'parent_category_id'
        ALTER TABLE product_category
        ADD CONSTRAINT fk_parent_category
        FOREIGN KEY (parent_category_id)
        REFERENCES product_category(id)
        ON DELETE SET NULL;
    END IF;
END $$;
