# -*- coding: utf-8 -*-

from flask import Flask
import cryptography

app = Flask(__name__)

import rds_db as db

@app.route('/')
def index():
    return 'Index Page'

@app.route('/db_connect')
def db_connect():
  try:
      conn = db.connect()
      return 'connected to SQL server', 200
  except:
      return 'NOT connected to SQL server', 500

if __name__ == "__main__":

    app.run(debug=False)
