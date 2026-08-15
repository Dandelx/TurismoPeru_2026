-- Sintaxis Funcion Tabla Multiples Sentencias 
CREATE OR ALTER FUNCTION EACM.FN_NOMBREFUNCION
(
--Parametro TipoDato
	@EDAD INT
)
RETURNS @Resultado TABLE
(
	Columna1 tipodato,
	Columna2 tipodato,
	Columna3 tipodato,
)
AS
BEGIN
--instrucciones SQL
	RETURN;
END;
GO