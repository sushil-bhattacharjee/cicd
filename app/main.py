from flask import Flask
import socket


ip = socket.gethostbyname(socket.gethostname())


app = Flask(__name__)

@app.route('/')
def home():
    out = (
        f"Welcome to Cisco Devnet.<br>"
        f"IP address of the server is {ip}.<br><br>"
        f"Welcome to the JamesBond world!<br><br>"
        f"Here is a list of the routers in the inventory:<br>"
    )
    return out

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9000)