import mysql.connector as c
con=c.connect(host="localhost", user="root", passwd="Deepak@2020")
db_cursor = con.cursor()
db_cursor.execute("CREATE DATABASE Pythondemo2")
db_cursor.execute("SHOW DATABASES")
for db in db_cursor:
    print(db)
