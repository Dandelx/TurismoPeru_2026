CREATE OR ALTER PROCEDURE EACM.sp_ListarClientes
AS
BEGIN
    Select p.id_persona, p.tipo_persona, nombres, apaterno, amaterno, estado
    From EACM.persona p
    inner join EACM.cliente c
    on p.id_persona = c.id_persona
END
GO