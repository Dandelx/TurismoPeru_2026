--Calcular el IGV de un pago
CREATE OR ALTER FUNCTION EACM.fn_CalcularIGVPago
(
	@monto money
)
RETURNS money
AS
BEGIN
	RETURN @monto*0.18;
END;
GO
--Ejecutar
SELECT EACM.fn_CalcularIGVPago (459) AS IGV, 
GETDATE() AS Fecha_Consulta;

--Ejecutar
SELECT monto, EACM.fn_CalcularIGVPago (monto) AS IGV, 
GETDATE() AS Fecha_Consulta
FROM EACM.pago
WHERE monto>=0;
