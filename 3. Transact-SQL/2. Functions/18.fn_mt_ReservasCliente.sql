-- Utilizar la función en un JOIN
CREATE OR ALTER FUNCTION EACM.fn_MSTVFReservasCliente
(
    @IdCliente INT
)
RETURNS @Resultado TABLE
(
    IdReserva INT,
    FechReserva DATE,
    EstadoReserva VARCHAR(100),
    TotalPagado MONEY
)
AS
BEGIN
    INSERT INTO @Resultado
    (
        IdReserva,
        FechReserva,
        EstadoReserva,
        TotalPagado
    )
    SELECT
        r.id_reserva,
        r.fecha_reserva,
        er.nombre AS EstadoReserva,
        ISNULL(SUM(p.monto), 0) AS TotalPagado
    FROM EACM.reserva r
    INNER JOIN EACM.estado_reserva er ON er.id_estado_reserva = r.id_estado_reserva
    LEFT JOIN EACM.pago p ON r.id_reserva = p.id_reserva
    WHERE r.id_cliente = @IdCliente
    GROUP BY
        r.id_reserva,
        r.fecha_reserva,
        er.nombre;

    RETURN;
END;
GO

-- Ejecutar usando un JOIN
SELECT 
    c.id_persona AS IdCliente,
    p.nombres + ' ' + p.apaterno + ' ' + ISNULL(p.amaterno, '') AS Cliente,
    res.IdReserva,
    res.FechReserva,
    res.EstadoReserva,
    res.TotalPagado,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.cliente c
INNER JOIN EACM.persona p 
    ON c.id_persona = p.id_persona
CROSS APPLY EACM.fn_MSTVFReservasCliente(c.id_persona) res;