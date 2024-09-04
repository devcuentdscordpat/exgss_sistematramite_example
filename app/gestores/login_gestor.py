# Importamos nuestra funcion de conexion con la base de datos
from config import crear_conexion_db

def validar_credenciales(nombre_usuario, password):
    conexion = crear_conexion_db()
    cursor = conexion.cursor()
    cursor.execute(
        "SELECT * FROM usuario WHERE nombre = %s AND password = %s ;", 
        (nombre_usuario, password)
    )
    usuario = cursor.fetchone()
    conexion.close()
    if usuario:
        return True
    else:
        return False


