from http import HTTPStatus
import json

from flask import Flask
from flask_cors import CORS

from flask_restx import Resource, Api, Namespace

app = Flask(__name__)
CORS(app)

api = Namespace("api")

api_ = Api()
api_.add_namespace(api)
api_.init_app(app)

DB="/breakfast/work/db.json"

@api.route('/breakfast')
class Breakfast(Resource):
    def get(self):
        with open(DB) as f:
            return json.load(f)

    def put(self):
        with open(DB, "w") as f:
            f.write(json.dumps(api.payload, indent=4, sort_keys=True))


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")