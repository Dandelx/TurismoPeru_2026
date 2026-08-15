--Reserva de un cliente
CREATE OR ALTER FUNCTION EACM.fn_ReservaCliente
(
	@IdCliente int
)
RETURNS TABLE
RETURN
(
	SELECT
		id_reserva,
		fecha_reserva,
		ER.nombre as [Estado Reserva]
	FROM EACM.reserva R inner join
	EACM.estado_reserva ER on
	ER.id_estado_reserva = R.id_estado_reserva
	WHERE R.id_Cliente=@IdCliente
);
GO

--Ejecutar
SELECT *, 
	GETDATE() as Fecha_Consulta, 
	EACM.fn_NombreCompletoPersona (106) as Estudiante
FROM EACM.fn_ReservaCliente(2);
