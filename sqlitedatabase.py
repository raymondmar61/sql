import sqlite3

#connecttotemporarydatabaseinmemory = sqlite3.connect(":memory:")
connectdatabase = sqlite3.connect("customers.db") #if customer.db doesn't exist, sqlite3 creates customer.db file

#Create a cursor.  A cursor tells the database what to do.  A cursor is a variable to execute SQL code?
cursorc = connectdatabase.cursor()

#Create a table
# cursorc.execute("""
# CREATE TABLE customers(firstname text, lastname text, email text)
# """) #case sensitive or case matters
# #Five datatypes in sqlite3 null, integer, real, text, blob such as an image, mp3
# connectdatabase.commit()
# connectdatabase.close()  #run close method after create a table

#Insert data one at a time.  Text is single quotes because I'm using triple quotes for execute method.
# cursorc.execute("""
# INSERT INTO customers
# VALUES('John','Elder','john@codemy.com')""")
# cursorc.execute("""
# INSERT INTO customers
# VALUES('Tim','Smith','tim@codemy.com')""")
# cursorc.execute("""
# INSERT INTO customers
# VALUES('Mary','Brown','mary@codemy.com')""")
# connectdatabase.commit()
# connectdatabase.close()

#Insert data many at a time.  Text is single quotes because I'm using triple quotes for execute method.  Create a list.
# manycustomerslist = [('Wes', 'Brown', 'wes@brown.com'), ('Steph', 'Kuewa', 'steph@kuewa.com'), ('Dan', 'Pas', 'dan@pas.com'), ]
# cursorc.executemany("INSERT INTO customers VALUES (?,?,?)", manycustomerslist) #(?,?,?) is (firstname, lastname, email)
# connectdatabase.commit()
# connectdatabase.close()

#Query the database and fetchall
cursorc.execute("SELECT * FROM customers")
print(cursorc.fetchone()) #return the first row ('John', 'Elder', 'john@codemy.com')
print(cursorc.fetchmany(3)) #return the first three rows [('John', 'Elder', 'john@codemy.com'), ('Tim', 'Smith', 'tim@codemy.com'), ('Mary', 'Brown', 'mary@codemy.com')]
print(cursorc.fetchall()) #return all rows [('John', 'Elder', 'john@codemy.com'), ('Tim', 'Smith', 'tim@codemy.com'), ('Mary', 'Brown', 'mary@codemy.com'), ('Wes', 'Brown', 'wes@brown.com'), ('Steph', 'Kuewa', 'steph@kuewa.com'), ('Dan', 'Pas', 'dan@pas.com')]
forloop = cursorc.fetchall()
for eachforloop in forloop:
    print(eachforloop)
    '''
    ('John', 'Elder', 'john@codemy.com')
    ('Tim', 'Smith', 'tim@codemy.com')
    ('Mary', 'Brown', 'mary@codemy.com')
    ('Wes', 'Brown', 'wes@brown.com')
    ('Steph', 'Kuewa', 'steph@kuewa.com')
    ('Dan', 'Pas', 'dan@pas.com')
    '''
for printfullname in forloop:
    print(printfullname[0] + " " + printfullname[1])
    '''
    John Elder
    Tim Smith
    Mary Brown
    Wes Brown
    Steph Kuewa
    Dan Pas
    '''

#Primary key.  sqlite automatically creates a primary key as the rowid.  You can deactivate the auto rowid.
cursorc.execute("SELECT rowid, firstname, lastname FROM customers")
forlooprowid = cursorc.fetchall()
for eachforlooprowid in forlooprowid:
    print(eachforlooprowid)
    '''
    (1, 'John', 'Elder')
    (2, 'Tim', 'Smith')
    (3, 'Mary', 'Brown')
    (4, 'Wes', 'Brown')
    (5, 'Steph', 'Kuewa')
    (6, 'Dan', 'Pas')
    '''

#Search for specific rows using where clause.  Use standard SQL code.
cursorc.execute("SELECT * FROM customers WHERE lastname LIKE 'Br%'")
forloopreturnrows = cursorc.fetchall()
for eachforloopreturnrows in forloopreturnrows:
    print(eachforloopreturnrows) #print ('Mary', 'Brown', 'mary@codemy.com')\n ('Wes', 'Brown', 'wes@brown.com')

#Update records, update rows
cursorc.execute("""
UPDATE customers SET firstname = 'Bob'
WHERE lastname = 'Elder'
""")
connectdatabase.commit()
cursorc.execute("SELECT * FROM customers")
print(cursorc.fetchone()) #print ('Bob', 'Elder', 'john@codemy.com')
cursorc.execute("""
UPDATE customers SET firstname = 'John'
WHERE rowid = 1
""")
connectdatabase.commit()
cursorc.execute("SELECT * FROM customers")
print(cursorc.fetchone()) #print ('John', 'Elder', 'john@codemy.com')