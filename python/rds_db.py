# -*- coding: utf-8 -*-

import pymysql
import sql_credentials as rds
import get_secrets as get_sec

def connect():
  secrets = get_sec.get_secret(rds.secret_name,rds.region_name)
  print(secret)
  if secrets:
     if 'host' in secrets.keys():
         rds.host = secrets['host']
     if 'username' in secrets.keys():
         rds.user = secrets['username']
     if 'port' in secrets.keys():
         rds.port = secrets['port']
     if 'password' in secrets.keys():
         rds.password = secrets['password']
     if 'dbname' in secrets.keys():
         rds.db = secrets['dbname']
  conn = pymysql.connect(
        host = rds.host, #endpoint link
        port = rds.port, # 3306
        user = rds.user, # admin
        password = rds.password, #adminadmin
        db = rds.db, #test
        )
  return conn
