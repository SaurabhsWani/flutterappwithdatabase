# flutterappwithdatabase
Here is the working of the app in given diagram

![](working%20of%20app.jpg)

You should have the firebase account and app connected to the firestore database.
Then download the main.dart file and the pubsec.yaml file and paste to your app
changes should be done in the dart file only 

1)change the ip/domain/website url in the web() function of dart file 

2)change the database/collection name in the userinfoget() and savetodb() functions in dart file

3)update your server file by copy paste the code of ssw.py file (in /var/www/cgi-bin/ if you have configure the httpd server in your os), here i have used the redhat8 to configure the httpd server

and then run the app
