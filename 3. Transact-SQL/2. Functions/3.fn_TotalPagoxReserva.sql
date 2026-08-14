--Total Pago por una reserva
CREATE OR ALTER FUNCTION EACM.fn_PagoTotalxReserva
(
	@IdReserva int
)
RETURNS Money
AS
BEGIN
	DECLARE @Total money 
	SELECT
		@Total = sum(monto)
	FROM EACM.pago
	WHERE id_reserva = @IdReserva;

	RETURN isnull(@Total,0);
END;

--Ejecutar
SELECT EACM.fn_PagoTotalxReserva(2) AS MontoPagado, GetDate() as Fecha_Consulta;