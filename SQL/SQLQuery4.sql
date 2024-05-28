create table COMPRAS_TOTALES (
	ID_REF nvarchar(255) null,
	PRODUCTO nvarchar(255) null,
	ID_PROVE float null,
	PROVE nvarchar(255) null,
	FAM nvarchar(255) null,
	CANTIDAD float null,
	PRECIO_C float null,
	DTO float null,
	TOTAL float null,
	SERIE float null,
	FECHA nvarchar(255) null,
	)

create table ULTIMO_PC (
	ID_REF nvarchar(255) null,
	PC_UNITARIO float null,
)

select*from COMPRAS_TOTALES
SELECT*FROM dbo.COMPRAS
select*from ULTIMO_PC

delete from COMPRAS_TOTALES

-- PASO 1 Para que no casque, hay que meter las mismas columnas a la tabla semanal que subo. FECHA_F y PC_UNITARIO
ALTER TABLE dbo.COMPRAS
ADD FECHA_F DATE;
ALTER TABLE dbo.COMPRAS
ADD PC_UNITARIO FLOAT NULL;
-- PASO 2 metemos la nueva info en COMPRAS TOTALES.
INSERT INTO dbo.COMPRAS_TOTALES
SELECT *
FROM dbo.COMPRAS
-- PASO 3 Actualizamos los datos de las nuevas columnas:
UPDATE dbo.COMPRAS_TOTALES
SET FECHA_F = CAST(FECHA AS DATE);
UPDATE dbo.COMPRAS_TOTALES
SET PC_UNITARIO = CASE 
                    WHEN ID_REF IS NULL OR TOTAL=0 OR PRECIO_C=0 THEN 0
                    ELSE round(TOTAL / CANTIDAD,3)
                  END;
-- PASO 4 Sacamos el último precio de compra por REF
select*from dbo.ULTIMO_PC
-- Eliminar todos los datos de la tabla existente
DELETE FROM dbo.ULTIMO_PC;
-- Insertar los nuevos datos desde la consulta
WITH UltimoPCUnitario AS (
    SELECT
        ID_REF,
        PC_UNITARIO,
        ROW_NUMBER() OVER (PARTITION BY ID_REF ORDER BY FECHA_F DESC) AS rn
    FROM
        dbo.COMPRAS_TOTALES
    WHERE
        ID_REF IS NOT NULL
)
INSERT INTO dbo.ULTIMO_PC (ID_REF, PC_UNITARIO)
SELECT ID_REF, PC_UNITARIO
FROM UltimoPCUnitario
WHERE rn = 1;
















