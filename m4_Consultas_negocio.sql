--CONSULTA 1

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

--CONSULTA 2

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

--CONSULTA 3

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

WITH facturacion_producto AS
(
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)

SELECT
    id_producto,
    total_facturado,

  --  CONSULTA 4

    CASE
        WHEN total_facturado >
        (
            SELECT AVG(total_facturado)
            FROM facturacion_producto
        )
        THEN 'Por encima'

        ELSE 'Por debajo'
    END AS clasificacion

FROM facturacion_producto;


-- =====================================
-- HALLAZGOS
-- =====================================

-- La facturación total de marzo de 2024 fue de $6.444,
-- distribuida en 10 pedidos, con un ticket promedio de $644,40.

-- El producto 1 fue el más relevante del período,
-- generando $3.600 de facturación, equivalente a aproximadamente el 56% del total vendido.

-- Solo los productos 1 y 3 quedaron por encima del promedio de facturación por producto,