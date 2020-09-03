import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var fs = FirebaseFirestore.instance;

class _MyAppState extends State<MyApp> {
  String name;
  String cmd;

  usrinfoget() async {
    var usrget = await fs.collection('usr_info').get();
    print("Here is the complete data of all user with command and it's output");
    for (var i in usrget.docs) {
      print(i.data());
    }
    print("Total number of records/documents");
    print(usrget.docs.length);
  }

  savetodb(name, otpt, cmd) {
    fs.collection("usr_info").add({
      'name': name,
      'cmd': cmd,
      'output': otpt,
    });
    print("Information saved to database successfully");
    usrinfoget();
  }

  Future web(name, cmd) async {
    var url =
        "https://c18f2aebcb73.ngrok.io/cgi-bin/ssw.py?name=$name&cmd=$cmd";
    var response = await http.get(url);
    var otpt = response.body;
    print("Output For Your $cmd command is :" + response.body);
    savetodb(name, otpt, cmd);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task-3'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.lightBlue[100],
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (val) {
                    name = val;
                  },
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    cmd = value;
                  },
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Command",
                    prefixIcon: Icon(Icons.check_circle),
                  ),
                ),
                // Text(usrgetoutput ?? "output is coming .."),
                FlatButton(
                  onPressed: () {
                    web(name, cmd);
                  },
                  hoverColor: Colors.lightGreenAccent[200],
                  color: Colors.green[400],
                  child: Text('Run your Commmand'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
