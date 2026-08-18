-- Consultar reservas por cliente y opcionalmente por estado
CREATE OR ALTER FUNCTION EACM.fn_MSTVFReservasClientePorEstado
(
    @IdCliente INT,
    @IdEstadoReserva INT = NULL
)
RETURNS @Resultado TABLE
(
    IdReserva INT,
    FechaReserva DATETIME,
    EstadoReserva VARCHAR(100),
    MontoTotalPagado MONEY
)
AS
BEGIN
    INSERT INTO @Resultado
    (
        IdReserva,
        FechaReserva,
        EstadoReserva,
        MontoTotalPagado
    )
    SELECT 
        r.id_reserva,
        r.fecha_reserva,
        er.nombre AS EstadoReserva,
        ISNULL(SUM(p.monto), 0) AS MontoTotalPagado
    FROM EACM.reserva r
    INNER JOIN EACM.estado_reserva er ON r.id_estado_reserva = er.id_estado_reserva
    LEFT JOIN EACM.pago p ON r.id_reserva = p.id_reserva
    WHERE r.id_cliente = @IdCliente
      AND (@IdEstadoReserva IS NULL OR r.id_estado_reserva = @IdEstadoReserva)
    GROUP BY 
        r.id_reserva,
        r.fecha_reserva,
        er.nombre;

    RETURN;
END;
GO

--Ejecutar (Trae todas las reservas sin filtrar por estado)
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_MSTVFReservasClientePorEstado(10, DEFAULT);

--Ejecutar (Filtrando por un estado específico)
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_MSTVFReservasClientePorEstado(10, 4);