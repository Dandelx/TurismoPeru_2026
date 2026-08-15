--Habitaciones por alojamiento
CREATE OR ALTER FUNCTION EACM.fn_HabitacionesAlojamiento
(
	@IdAlojamiento int
)
RETURNS TABLE
RETURN
(
	SELECT
		h.id_alojamiento,
		H.numero_habitacion,
		TH.nombrehabitacion,
		tH.capacidad_personas,
		H.precio_noche,
		H.estado,
		H.descripcion
	FROM EACM. habitacion H inner join
	EACM.tipo_habitacion TH on
	H.id_tipo_habitacion = TH.id_tipo_habitacion
	where id_alojamiento=@IdAlojamiento
);
GO

--Ejecutar
SELECT *,
	GETDATE() AS Fecha_Consulta,
	EACM.fn_NombreCompletoPersona (106) as Estudiante
FROM EACM.fn_HabitacionesAlojamiento(2);