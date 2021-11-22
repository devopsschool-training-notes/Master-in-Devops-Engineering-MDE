import mysql.connector as c
con=c.connect(host="localhost", user="root", passwd="Deepak@2020", database="pythondemo2")
db_cursor = con.cursor()
db_cursor.execute("CREATE TABLE student(id INT, name VARCHAR(255))")
db_cursor.execute("SHOW TABLES")
for db in db_cursor:
    print(db)
