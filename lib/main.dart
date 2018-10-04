import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String url = "http://crm.emastpa.com.my/MemberInfo.json";

class EmployeeInfo {
  String Employee;
  String empname;
  String empdep;
  Map<String, dynamic> EmployeeJSON = new Map<String, dynamic>();
}

Future<String> jsonContent() async {
  var res = await http.get(
      Uri.encodeFull("http://crm.emastpa.com.my/MemberInfo.json"),
      headers: {"Accept": "application/json"});
  return res.body;
}

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MemberInfoState createState() => new MemberInfoState();
}

class MemberInfoState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: new Container(
          child: new Center(
            child: new FutureBuilder<String>(
              future: jsonContent(),
              builder: (context, snapshot) {
                if (snapshot?.hasData) {
                  var mydata = json.decode(snapshot.data);
                  final name = mydata["Employee"]["Name"];

                  return new ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new ListTile(
                              title: new Text("Name "),
                              subtitle: new Text(name),
                            ),
                            new ListTile(
                              title: new Text("Identification "),
                              subtitle: new Text(
                                  mydata["Employee"]["Identification"]),
                            ),
                            new ListTile(
                              title: new Text("Company "),
                              subtitle: new Text(
                                  mydata["Employee"]["Company"]),
                            ),
                            new ListTile(
                              title: new Text("Date Of Birth "),
                              subtitle: new Text(
                                  mydata["Employee"]["DateOfBirth"]),
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 50.0,
                            ),
                            new MaterialButton(
                              color: Colors.indigo,
                              height: 50.0,
                              minWidth: 50.0,
                              textColor: Colors.white,
                              child: new Text("More"),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: mydata == null ? 0 : mydata.length,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
