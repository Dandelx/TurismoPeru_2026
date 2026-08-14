--Obtener el nombre completo de una persona
CREATE OR ALTER FUNCTION EACM.fn_NombreCompletoPersona
(
@IdPersona int
)
RETURNS VARCHAR(200)
AS
BEGIN
	DECLARE @nombrecompleto VARCHAR(200)
	SELECT
	@nombrecompleto=
	nombres + ' ' +
	apaterno + ' '+
	amaterno
	FROM EACM.persona
	WHERE id_persona = @IdPersona;
	--
	RETURN @nombrecompleto
END
GO
--Ejecutar
SELECT EACM.fn_NombreCompletoPersona (106) as Persona, GETDATE() as FechaConsulta;
