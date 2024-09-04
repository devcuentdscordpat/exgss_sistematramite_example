import os
from flask import Flask, redirect
from app.routes.login_routes import login_bp
from app.routes.admin_routes import admin_bp
from app.routes.gestor_tramite_routes import gestor_tramite_bp

# Aquin instanciamos la aplicacion Flask
app = Flask(__name__, template_folder='app/templates', static_folder='app/static')
app.secret_key = 'secret' # Esta llave nos servira para el tema de sesiones y cookies


#Nuestra ruta principal o root
@app.route('/')
def index():
    return redirect('/login') # Redirigiendo a la ruta del login

# Rutas
app.register_blueprint(login_bp) # Cargando rutas que programamos en login_routes.py
app.register_blueprint(admin_bp) # Cargando rutas que programamos en admin_routes.py
app.register_blueprint(gestor_tramite_bp) #...

if __name__ == "__main__":
    app.run(debug=True) # Aqui ejecutamos la aplicacion en modo debug.

