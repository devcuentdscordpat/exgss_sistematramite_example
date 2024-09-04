from config import crear_conexion_db
from typing import TypedDict, Optional, NamedTuple
from datetime import datetime


def obtener_todos_revisores():
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        cursor.execute("Select * from revisores;")
        res = cursor.fetchall()
    except Exception as e:
        print("Error al obtener los revisores")
        return None
    finally:
        cursor.close()
        conexion.close()

def asignar_tramite(id_revisor, id_tramite, descripcion):
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        fecha = datetime.now().strftime('%Y/%m/%d')
        cursor.execute(
            "INSERT INTO tramite_subida VALUES (null, %s, %s, %s, %s);",
            (descripcion, fecha, id_revisor, id_tramite)
        )
        conexion.commit()
        return True
    except Exception as e:
        print(f"Error al asignar tramite: {e}")
        return False
    finally:
        cursor.close()
        conexion.close()


def obtener_revisor_ci(ci: str):
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        cursor.execute("SELECT persona.* FROM persona JOIN revisor ON persona.id revisor.id WHERE persona.ci = %s;", (ci,))
        res = cursor.fetchone()
        if res:
            return res
        else:
            return None
    except Exception as e:
        print(f"Error al obtener el revisor")



