-- Cantidad de reservas por cliente
CREATE OR ALTER FUNCTION EACM.fn_CantidadReservasCliente
(
    @IdCliente INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Cantidad INT;

    SELECT @Cantidad = COUNT(id_reserva)
    FROM EACM.reserva
    WHERE id_cliente = @IdCliente;

    RETURN ISNULL(@Cantidad, 0);
END;
GO

-- Ejecutar
SELECT EACM.fn_CantidadReservasCliente(2) AS CantidadReservas,
GETDATE() AS Fecha_Consulta,EACM.fn_NombreCompletoPersona(106) AS Estudiante;