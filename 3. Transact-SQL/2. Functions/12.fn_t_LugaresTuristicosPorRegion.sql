-- Lugares turísticos por región
CREATE OR ALTER FUNCTION EACM.fn_LugaresTuristicosPorRegion
(
    @IdRegion INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        lt.id_lugarturistico,
        lt.nombre AS [Lugar Turistico],
        CAST(lt.descripcion AS NVARCHAR(MAX)) AS descripcion,
        lt.precio_entrada,
        lt.horario_apertura,
        lt.horario_cierre,
        lt.estado,
        r.nombreregion AS Region
    FROM EACM.lugar_turistico lt
    INNER JOIN EACM.direccion_lugarturistico dlt ON lt.id_lugarturistico = dlt.id_lugarturistico
    INNER JOIN EACM.direccion d ON dlt.id_direccion = d.id_direccion
    INNER JOIN EACM.ciudad c ON d.id_ciudad = c.id_ciudad
    INNER JOIN EACM.subregion sr ON c.id_subregion = sr.id_subregion
    INNER JOIN EACM.region r ON sr.id_region = r.id_region
    WHERE r.id_region = @IdRegion
);
GO

--Ejecutar
SELECT *,
    GETDATE() AS Fecha_Consulta,
    EACM.fn_NombreCompletoPersona(106) AS Estudiante
FROM EACM.fn_LugaresTuristicosPorRegion(2);