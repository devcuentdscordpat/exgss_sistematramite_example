from config import crear_conexion_db
from typing import TypedDict, Optional, NamedTuple
from datetime import datetime

class Persona(NamedTuple):
    id: Optional[int]
    ci: str
    nombre: str
    ap_paterno: str
    ap_materno: str
    telefono: str
    direccion: str
    id_usuario: Optional[int]

class Tramite(NamedTuple):
    id: Optional[int]
    fecha_inicio: Optional[str]
    fecha_fin_probable: Optional[str]
    descripcion_documentos: str
    nro_patente: str
    observacion: Optional[str]
    id_estado: str
    id_tipo_tramite: int
    id_propietario: int
    id_gestor_tramite: int
    id_operador: int
    nombre_estado: Optional[str]


def obtener_persona(carnet: str) -> Persona | None:
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor(dictionary=True) # ¿dictionary?:Esto mapeara los datos retornados de la base de datos a un diccionario
        cursor.execute(
            "SELECT * FROM persona WHERE ci = %s;", 
            (carnet,)
        )
        res = cursor.fetchone()
        print(res)
        conexion.close()
        if res:
            persona = Persona(**res)
            return persona
        else:
            return None
    except Exception as e:
        print(f"Error al obtener la persona: {e}")
        return None


def registrar_persona(persona: Persona) -> bool:
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        cursor.execute("""
            INSERT INTO persona(id, ci, nombre, ap_paterno, ap_materno, telefono, direccion) VALUES(0, %s, %s, %s, %s, %s, %s);
            """,
            (persona.ci, persona.nombre, persona.ap_paterno, persona.ap_materno, persona.telefono, persona.direccion,))
        conexion.commit()
        return True
    except Exception as e:
        print(f"Error durante el insert persona: {e}")
        return False
    finally:
        cursor.close()
        conexion.close()

def registrar_tramite(tramite: Tramite) -> bool:
    '''Este metodo se encarga de realizar una transaccion
       de un nuevo tramite en la DB'''
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        # Empezamos la transaccionalidad
        if not verificar_persona_es_gestor_tramite(tramite.id_gestor_tramite):
            cursor.execute(
                "INSERT INTO gestor_tramite(id) VALUES(%s);", 
                (tramite.id_gestor_tramite,)
            )
        # Empezamos la transaccionalidad
        if not verificar_persona_es_propietario(tramite.id_propietario):
            cursor.execute(
                "INSERT INTO propietario(id) VALUES(%s);", 
                (tramite.id_propietario,)
            )
        
         # Insertar trámite
        cursor.execute("""
            INSERT INTO tramite (
                id,
                fecha_inicio, 
                descripcion_documentos, 
                fecha_fin_probable, 
                nro_patente, 
                observacion, 
                id_estado, 
                id_tipo_tramite, 
                id_propietario, 
                id_gestor_tramite, 
                id_operador) 
            VALUES (NULL,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
            """, (
            tramite.fecha_inicio, 
            tramite.descripcion_documentos, 
            tramite.fecha_fin_probable, 
            tramite.nro_patente, 
            tramite.observacion, 
            tramite.id_estado, 
            tramite.id_tipo_tramite, 
            tramite.id_propietario, 
            tramite.id_gestor_tramite, 
            tramite.id_operador
        ))
        conexion.commit()
        return True
    except Exception as e:
        print(f"Error durante la transacción: {e}")
        conexion.rollback()
        return False
    finally:
        cursor.close()
        conexion.close()

def verificar_persona_es_gestor_tramite(id) -> bool:
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        cursor.execute(
            "SELECT * FROM gestor_tramite WHERE id = %s;", 
            (id,)
        )
        conexion.close()
        res = cursor.fetchone()
        if res:
            return True
        return False
    except Exception as e:
        print(f"Error al verificar gestor: {e}")
        return False
    finally:
        cursor.close()
        conexion.close()

def verificar_persona_es_propietario(id) -> bool:
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor()
        cursor.execute(
            "SELECT * FROM propietario WHERE id = %s;", 
            (id,)
        )
        conexion.close()
        res = cursor.fetchone()
        if res:
            return True
        return False
    except Exception as e:
        print(f"Error al verificar propietario: {e}")
        return False
    finally:
        cursor.close()
        conexion.close()    


def obtener_datos_tramite(cod)->Tramite | None:
    try:
        conexion = crear_conexion_db()
        cursor = conexion.cursor(dictionary=True)
        cursor.execute(
            "SELECT tramite.*, estado.nombre as nombre_estado FROM tramite JOIN estado ON tramite.id_estado = estado.id WHERE tramite.id = %s;", 
            (cod,)
        )
        res = cursor.fetchone()
        
        if res:
            tramite: Tramite = Tramite(
                id=res['id'],
                fecha_inicio=str(res['fecha_inicio']),
                fecha_fin_probable=str(res['fecha_fin_probable']),
                descripcion_documentos=res['descripcion_documentos'],
                nro_patente=res['nro_patente'],
                observacion=res['observacion'],
                id_estado=res['id_estado'],
                id_tipo_tramite=res['id_tipo_tramite'],
                id_propietario=res['id_propietario'],
                id_gestor_tramite=res['id_gestor_tramite'],
                id_operador=res['id_operador'],
                nombre_estado=res['nombre_estado']
            )
            return tramite
        else: 
            return None
    except Exception as e:
        print(f"Error al obtener los datos tramite: {e}")
        return None
    finally:
        cursor.close()
        conexion.close()    

