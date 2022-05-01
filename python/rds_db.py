# -*- coding: utf-8 -*-

import pymysql
import sql_credentials as rds

def connect():
  conn = pymysql.connect(
        host = rds.host, #endpoint link
        port = rds.port, # 3306
        user = rds.user, # admin
        password = rds.password, #adminadmin
        db = rds.db, #test
        )
  return conn
