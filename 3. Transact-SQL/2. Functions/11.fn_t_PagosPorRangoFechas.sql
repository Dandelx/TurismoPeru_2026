-- Pagos por rango de fechas
CREATE OR ALTER FUNCTION EACM.fn_PagosPorRangoFechas
(
    @FechaInicio DATE,
    @FechaFin DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.id_pago,
        p.id_reserva,
        mp.nombre AS medio_pago,
        p.monto,
        p.fecha_pago,
        p.numero_operacion,
        p.estado
    FROM EACM.pago p
    INNER JOIN EACM.medio_pago mp ON p.id_medio_pago = mp.id_medio_pago
    WHERE CAST(p.fecha_pago AS DATE) BETWEEN @FechaInicio AND @FechaFin
);
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_PagosPorRangoFechas('2026-01-01', '2026-12-31');
