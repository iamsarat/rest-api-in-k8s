from flask import Flask, request
import json
import time

# create a Flask app.
rest = Flask(__name__)

@rest.route('/', methods=['GET', 'POST', 'PUT'])
def simple_restapi():
	return {
         "message": "Automate all the things",
         "timestamp": int(time.time())
        }

if __name__ == "__main__":
	rest.run(host='0.0.0.0', port=8080)
