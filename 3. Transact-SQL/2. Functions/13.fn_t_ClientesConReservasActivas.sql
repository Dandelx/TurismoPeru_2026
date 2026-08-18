-- Clientes con reservas activas
CREATE OR ALTER FUNCTION EACM.fn_ClientesConReservasActivas()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        c.id_persona AS id_cliente,
        p.nombres,
        p.apaterno,
        p.amaterno,
        er.nombre AS EstadoReserva
    FROM EACM.cliente c
    INNER JOIN EACM.persona p ON c.id_persona = p.id_persona
    INNER JOIN EACM.reserva r ON c.id_persona = r.id_cliente
    INNER JOIN EACM.estado_reserva er ON r.id_estado_reserva = er.id_estado_reserva
    WHERE er.nombre IN ('Pendiente', 'Confirmada', 'En Proceso', 'Activa')
);
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_ClientesConReservasActivas();