-- Reporte de clientes frecuentes
CREATE OR ALTER FUNCTION EACM.fn_MSTVFReporteClientesFrecuentes()
RETURNS @Reporte TABLE
(
    IdCliente INT,
    NombreCliente VARCHAR(200),
    CantidadReservas INT,
    MontoTotalPagado MONEY,
    ClasificacionCliente VARCHAR(50)
)
AS
BEGIN
    INSERT INTO @Reporte
    (
        IdCliente,
        NombreCliente,
        CantidadReservas,
        MontoTotalPagado,
        ClasificacionCliente
    )
    SELECT 
        c.id_persona,
        EACM.fn_NombreCompletoPersona(c.id_persona),
        COUNT(DISTINCT r.id_reserva),
        ISNULL(SUM(p.monto), 0),
        'Por Clasificar'
    FROM EACM.cliente c
    LEFT JOIN EACM.reserva r ON c.id_persona = r.id_cliente
    LEFT JOIN EACM.pago p ON r.id_reserva = p.id_reserva
    GROUP BY c.id_persona;

    UPDATE @Reporte
    SET ClasificacionCliente = CASE 
        WHEN CantidadReservas > 15 THEN 'Cliente Vip'
        WHEN CantidadReservas > 5  THEN 'Cliente Frecuente'
        ELSE 'Cliente Nuevo'
    END;

    RETURN;
END;
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_MSTVFReporteClientesFrecuentes();