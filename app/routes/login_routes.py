from flask import (
    Blueprint, 
    render_template, 
    request, 
    redirect, 
    url_for, 
    flash, 
    send_from_directory,
    session)
import app.gestores.login_gestor as login_gestor # Importamos el modulo de login_gestor

# login_bp es un Blueprint sirve para manejar rutas
login_bp = Blueprint('login', __name__, static_folder='../templates/login')


@login_bp.route('/login', methods=['GET'])
def show_login():
    return render_template('login/login.html') 


@login_bp.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    
    # Llamamos a la funcion validar_credenciales del modulo login_gestor
    if login_gestor.validar_credenciales(username, password):

        tipo_user = 'ADM' # Esto manejar por base de datos
        if tipo_user == 'ADM':
            session['Nombre_Completo'] = ''
            session['username'] = username
            session['tipo_user'] = tipo_user

            return redirect('/admin')
        elif tipo_user == 'ENC':
            #return redirect('/encargado')
            pass
        else:
            flash('Ocurrio un error inesperado al ingresar')
            return redirect(url_for('login.show_login'))
    else:
        flash('Nombre de usuario o contraseña incorrectos')
        return redirect(url_for('login.show_login'))


@login_bp.route('/cerrar-sesion')
def cerrar_session():
    session.pop('Nombre_Completo', None)
    session.pop('username', None) 
    session.pop('tipo_user', None)
    return redirect(url_for('login.show_login'))


# Ruta para los archivos del componente de Login
@login_bp.route('/login/static/<path:filename>')
def login_static(filename):
    return send_from_directory(login_bp.static_folder, filename)
