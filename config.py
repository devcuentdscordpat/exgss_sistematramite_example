import mysql.connector

config_credentials_db = {
  'user': 'root',
  'password': '',
  'host': '127.0.0.1',
  'database': 'sistematransito',
  'raise_on_warnings': True
}

def crear_conexion_db() -> mysql.connector.MySQLConnection: 
    cnx = mysql.connector.connect(**config_credentials_db)
    return cnx
    
