-- Clasificación del cliente
CREATE OR ALTER FUNCTION EACM.fn_ClasificacionCliente
(
    @IdCliente INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @CantidadReservas INT;
    DECLARE @Clasificacion VARCHAR(50);

    SELECT @CantidadReservas = COUNT(id_reserva)
    FROM EACM.reserva
    WHERE id_cliente = @IdCliente;

    IF @CantidadReservas > 15
        SET @Clasificacion = 'Cliente Vip';
    ELSE IF @CantidadReservas > 5
        SET @Clasificacion = 'Cliente Frecuente';
    ELSE
        SET @Clasificacion = 'Cliente Nuevo';

    RETURN @Clasificacion;
END;
GO

-- Ejecutar
SELECT 
    EACM.fn_ClasificacionCliente(1) AS Clasificacion,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante;