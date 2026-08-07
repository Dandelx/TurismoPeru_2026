from database.connection import conectar

def listarpersonas():

    conexion = conectar()

    try:

        cursor = conexion.cursor()

        cursor.execute("EXEC EACM.sp_ListarPersonas")

        personas = cursor.fetchall()

        return personas

    finally:

        cursor.close()

        conexion.close()

def listarclientes():

    conexion = conectar()

    try:

        cursor = conexion.cursor()

        cursor.execute("EXEC EACM.sp_ListarClientes")

        clientes = cursor.fetchall()

        return clientes

    finally:

        cursor.close()

        conexion.close()
