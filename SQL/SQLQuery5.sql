WITH VentasPromedio AS (
    SELECT 
        DATEFROMPARTS(YEAR(FECHA), MONTH(FECHA), 1) AS FECHA_MES,
        SUM(TTL) AS Ventas,
        AVG(SUM(TTL)) OVER (ORDER BY DATEFROMPARTS(YEAR(FECHA), MONTH(FECHA), 1) ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS VentasPromedio
    FROM dbo.VENTAS_TOTALES
    GROUP BY DATEFROMPARTS(YEAR(FECHA), MONTH(FECHA), 1)
)

SELECT VentasPromedio AS Pronostico_Junio_2024
FROM VentasPromedio
WHERE FECHA_MES = '2024-05-01';