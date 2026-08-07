CREATE OR ALTER PROCEDURE EACM.sp_ListarPersonas
AS
BEGIN
    Select id_persona, tipo_persona, nombres, apaterno, amaterno, estado
    From EACM.persona
END
GO