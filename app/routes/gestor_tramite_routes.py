from flask import Blueprint, jsonify, request, render_template
import app.gestores.gestor_tramite_gestor as gestor_tramite_gestor
from datetime import datetime


gestor_tramite_bp = Blueprint('gestor_tramite', __name__, static_folder='../templates/tramite')


@gestor_tramite_bp.route('/gestor_tramite/obtener_persona/<carnet>', methods=['GET'])
def obtener_persona(carnet):
    try:
        persona = gestor_tramite_gestor.obtener_persona(carnet)
        if persona:
            return jsonify(persona._asdict())
        else:
            return jsonify({"error": "Persona no encontrada"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@gestor_tramite_bp.route('/gestor_tramite/registrar_tramite', methods=['POST'])
def registrar_tramite():
    data = request.get_json()
    
    tramitador_id = data.get('tramitador_id')
    propietario_id = data.get('propietario_id')
    tipo_tramite_id = data.get('tipo_tramite')
    nro_patente = data.get('nro_patente')
    descripcion_documentos_entregados = data.get('descripcion_documentos_entregados')
    fecha_estimada_entrega = data.get('fecha_estimada_entrega')
    fecha_inicio = datetime.now() 

    # Instanciar Tramite
    tramite = gestor_tramite_gestor.Tramite(
        id=None,  # Si no tienes un ID para el nuevo trámite
        fecha_inicio=fecha_inicio.strftime("%Y-%m-%d"),  # Formato de fecha
        fecha_fin_probable=fecha_estimada_entrega,
        descripcion_documentos=descripcion_documentos_entregados,
        nro_patente=nro_patente,
        observacion="",
        id_estado=1,
        id_tipo_tramite=tipo_tramite_id,
        id_propietario=propietario_id,
        id_gestor_tramite=tramitador_id,
        id_operador=4, # Aqui cambiar para obtener el ID Operador dependiendo del usuario operador que se haya logueado.
        nombre_estado=None
    )

    if gestor_tramite_gestor.registrar_tramite(tramite):
        return jsonify({"message": "Trámite registrado correctamente"}), 201
    else:
        return jsonify({"message": "Error al registrar el trámite"}), 500


@gestor_tramite_bp.route('/gestor_tramite/registrar_persona', methods=['POST'])
def registrar_persona():
    data = request.get_json()
    persona = gestor_tramite_gestor.Persona(
        id=None,
        ci=data.get('carnet'),
        nombre=data.get('nombre'),
        ap_paterno=data.get('ap_paterno'),
        ap_materno=data.get('ap_materno'),
        telefono=data.get('tel'),
        direccion=data.get('direccion'),
        id_usuario=None
    )
    res = gestor_tramite_gestor.registrar_persona(persona)
    if res:
        return jsonify({"message": "Persona registrada correctamente"}), 201
    else:
        return jsonify({"message": "Error al registrar persona"}), 500


@gestor_tramite_bp.route('/ver_tramite', methods=['GET'])
def show_ver_tramite_get():
    return render_template('tramite/tramite.html')

@gestor_tramite_bp.route('/ver_tramite', methods=['POST'])
def show_ver_tramite_post():
    cod = request.form.get('codigo')
    tramite = gestor_tramite_gestor.obtener_datos_tramite(cod)
    
    if tramite: 
        return render_template('tramite/tramite.html', tramite = tramite)
    else: 
        return render_template('tramite/tramite.html', tramite = None)

