from http import HTTPStatus
import json
import os
import uuid

from flask import Flask
from flask_cors import CORS

import restx_monkey as monkey

monkey.patch_restx()

from flask_restx import Resource, Api, fields, abort

app = Flask(__name__)
api = Api(app)
CORS(app)

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