from flask import Flask
import socket
from MySQLdb import connect

ip = socket.gethostbyname(socket.gethostname())

def get_routers():
    db = connect(host='172.20.0.200', db='inventory')
    c = db.cursor()
    c.execute('SELECT * FROM routers')
    return c.fetchall()

app = Flask(__name__)

@app.route('/')
def home():
    out = (
        f"Welcome to Cisco Devnet.<br>"
        f"IP address of the server is {ip}.<br><br>"
        f"Welcome to the JamesBond world!<br><br>"
        f"Here is a list of the routers in the inventory:<br>"
    )
    out += "This is start of routers in the inventory:<br><br>"
    for r in get_routers():
        out += f"-> Hostname: {r[0]}, IP: {r[1]}<br>"
    out += "This is the end of the routers inventory"
    return out

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9000)