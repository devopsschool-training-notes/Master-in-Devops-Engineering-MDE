import mysql.connector as c
con=c.connect(host="localhost", user="root", passwd="Deepak@2020", database="pythondemo2")
db_cursor = con.cursor()
student_query = "INSERT INTO student(id,name)VALUES(01,'DEEPAK')"
employee_query = "INSERT INTO employee(id,name,salary)VALUES(01,'DEEPAK1',5000)"
db_cursor.execute(student_query)
db_cursor.execute(employee_query)
con.commit()
print(db_cursor.rowcount, "Record is successfully added")
