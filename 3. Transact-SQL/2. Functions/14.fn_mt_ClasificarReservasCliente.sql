-- Clasificar las reservas de un cliente según su cantidad
CREATE OR ALTER FUNCTION EACM.fn_MSTVFClasificarReservasCliente
(
    @IdCliente INT
)
RETURNS @Resultado TABLE
(
    IdCliente INT,
    NombreCliente VARCHAR(200),
    TotalReservas INT,
    ClasificacionCliente VARCHAR(50)
)
AS
BEGIN
    DECLARE @Cantidad INT;
    DECLARE @Nombre VARCHAR(200);
    DECLARE @Clasificacion VARCHAR(50);

    SET @Nombre = EACM.fn_NombreCompletoPersona(@IdCliente);
    SELECT @Cantidad = COUNT(id_reserva)
    FROM EACM.reserva
    WHERE id_cliente = @IdCliente;
    IF @Cantidad > 15
        SET @Clasificacion = 'Cliente Vip';
    ELSE IF @Cantidad > 5
        SET @Clasificacion = 'Cliente Frecuente';
    ELSE
        SET @Clasificacion = 'Cliente Nuevo';
    INSERT INTO @Resultado (IdCliente, NombreCliente, TotalReservas, ClasificacionCliente)
    VALUES (@IdCliente, @Nombre, @Cantidad, @Clasificacion);

    RETURN;
END;
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_MSTVFClasificarReservasCliente(10);