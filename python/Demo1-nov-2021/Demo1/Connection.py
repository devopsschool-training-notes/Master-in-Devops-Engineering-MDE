import mysql.connector as c
con=c.connect(host="localhost", user="root", passwd="Deepak@2020", database="pythondemo")
if con.is_connected():
    print("Connection is successfully Established")
else:
    print("Connection Failed")
