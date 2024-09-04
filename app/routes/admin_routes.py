from flask import (
    Blueprint, 
    render_template, 
    request, 
    redirect, 
    url_for, 
    flash, 
    send_from_directory, 
    session
    )


admin_bp = Blueprint('admin', __name__, static_folder='../templates/admin')


@admin_bp.route('/admin', methods=['GET'])
def show_admin_home():
    if 'username' in session:
        return render_template('admin/admin-base.html') 
    else:
        return redirect(url_for('login.show_login'))


@admin_bp.route('/admin/gestor-tramite', methods=['GET'])
def show_admin_gtramite():
    return render_template('admin/gestor-tramite/gestor-tramite.html')



@admin_bp.route('/admin/static/<path:filename>')
def admin_static(filename):
    return send_from_directory(admin_bp.static_folder, filename)
