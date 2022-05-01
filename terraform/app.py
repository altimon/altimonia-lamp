# -*- coding: utf-8 -*-
"""
Created on Sat Jul 25 12:02:51 2020

@author: hp
"""

from flask import Flask, render_template, request, flash, redirect,url_for, jsonify, session
from flask import Response,send_file
import cryptography

app = Flask(__name__)

import rds_db as db

# @app.route('/')
# def index():
#    return render_template('index.html')

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


# @app.route('/insert',methods = ['post'])
# def insert():
#
#     if request.method == 'POST':
#         name = request.form['name']
#         email = request.form['email']
#         gender = request.form['optradio']
#         comment = request.form['comment']
#         db.insert_details(name,email,comment,gender)
#         details = db.get_details()
#         print(details)
#         for detail in details:
#             var = detail
#         return render_template('index.html',var=var)



if __name__ == "__main__":

    app.run(debug=False)
