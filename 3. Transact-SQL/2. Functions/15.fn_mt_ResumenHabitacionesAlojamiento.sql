-- Información resumida de las habitaciones de un alojamiento
CREATE OR ALTER FUNCTION EACM.fn_MSTVFResumenHabitacionesAlojamiento
(
    @IdAlojamiento INT
)
RETURNS @Resultado TABLE
(
    IdAlojamiento INT,
    TotalHabitaciones INT,
    HabitacionesDisponibles INT,
    PrecioPromedio DECIMAL(10,2),
    PrecioMinimo DECIMAL(10,2),
    PrecioMaximo DECIMAL(10,2)
)
AS
BEGIN
    INSERT INTO @Resultado
    (
        IdAlojamiento,
        TotalHabitaciones,
        HabitacionesDisponibles,
        PrecioPromedio,
        PrecioMinimo,
        PrecioMaximo
    )
    SELECT 
        @IdAlojamiento,
        COUNT(id_habitacion),
        SUM(CASE WHEN estado = 'Disponible' THEN 1 ELSE 0 END),
        ISNULL(AVG(precio_noche), 0),
        ISNULL(MIN(precio_noche), 0),
        ISNULL(MAX(precio_noche), 0)
    FROM EACM.habitacion
    WHERE id_alojamiento = @IdAlojamiento;

    RETURN;
END;
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_MSTVFResumenHabitacionesAlojamiento(1);