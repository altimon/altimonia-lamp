# -*- coding: utf-8 -*-

from flask import Flask
import cryptography
import sql_credentials as rds
import get_secrets as get_sec
from os import environ

app = Flask(__name__)

import rds_db as db

@app.route('/')
def index():
    return 'Index Page'

@app.route('/db_connect')
def db_connect():

# get info gto AWS secrets
  secrets = get_sec.get_secret(rds.secret_name,rds.region_name)
  if secrets:
     if 'host' in secrets.keys():
         rds.host = secrets['host']
     if 'username' in secrets.keys():
         rds.user = secrets['username']
     if 'port' in secrets.keys():
         rds.port = secrets['port']
     if 'password' in secrets.keys():
         rds.password = secrets['password']
         passwd=rds.password[0:3]+'*****'+rds.password[len(rds.password)-3:]
     if 'dbname' in secrets.keys():
         rds.db = secrets['dbname']

# to use hostname from env var if defined
  if "host" in environ:
      rds.host = environ.get('host','127.0.0.1')

  msg = 'connected to SQL server {0}:{1} usr={2} passwd={3} db={4}'.format(rds.host,rds.port,rds.user,passwd,rds.db)
  try:
      conn = db.connect()
      return msg, 200
  except:
      return 'NOT '+msg , 500

if __name__ == "__main__":

    app.run(debug=False)
