--Reserva Cliente
CREATE OR ALTER FUNCTION EACM.fn_MSTVFReservasCliente
(
	@Idcliente int
)
RETURNS @resultado table
(
	IdReserva int,
	FechReserva date,
	EstadoReserva varchar(100),
	TotalPagado money
)
AS
BEGIN
	INSERT INTO @resultado
	(
		IdReserva ,
		FechReserva ,
		EstadoReserva ,
		TotalPagado 
	)
	SELECT
		R.id_reserva,
		R.fecha_reserva,
		er.nombre, -- estado reserva
		isnull(sum(P.monto),0)
	FROM EACM.reserva R 
	INNER JOIN
		EACM.estado_reserva ER on
		ER.id_estado_reserva = r.id_estado_reserva
	LEFT JOIN
		EACM.pago P on 
		R.id_reserva = p.id_reserva
	WHERE R.id_cliente = @Idcliente
	GROUP BY
		R.id_reserva,
		R.fecha_reserva,
		ER.nombre;
	RETURN;
END;
GO

--Ejecutar
SELECT *,
GETDATE() AS Fecha_Consulta,
EACM. fn_NombreCompletoPersona (106) as Estudiante
FROM EACM.fn_MSTVFReservasCliente (10);