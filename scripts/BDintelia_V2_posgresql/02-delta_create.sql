DO $$
BEGIN
    -- Verificar si la columna 'phone_code' existe, lo cual indicaría que la tabla está en la estructura inicial
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'telephone'
        AND column_name = 'phone_code'
    ) THEN
        -- Renombrar 'phone_code' a 'phone'
        ALTER TABLE telephone RENAME COLUMN phone_code TO phone;

        -- Verificar si 'area_code' es NOT NULL y cambiarla a NULLABLE si es necesario
        IF EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_name = 'telephone'
            AND column_name = 'area_code'
            AND is_nullable = 'NO'
        ) THEN
            ALTER TABLE telephone ALTER COLUMN area_code DROP NOT NULL;
        END IF;

        -- Verificar si 'country_code' es NOT NULL y cambiarla a NULLABLE si es necesario
        IF EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_name = 'telephone'
            AND column_name = 'country_code'
            AND is_nullable = 'NO'
        ) THEN
            ALTER TABLE telephone ALTER COLUMN country_code DROP NOT NULL;
        END IF;
    END IF;
END $$;