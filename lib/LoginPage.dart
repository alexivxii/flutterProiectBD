import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proiectbd/SignupPage.dart';
import 'package:proiectbd/Dashboard.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

Future postRequest (String user, String pass) async {
  var url ='http://10.0.2.2:5000/api/user/login';

  Map data = {
    'Username': user,
    'Password': pass
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print(response.body);
  return jsonDecode(response.body);
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10,15,20,10),
                  child: FlatButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: const Color(0xffff3737),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),

                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ));
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                  child: TextField(
                    obscureText: true,
                    cursorColor: const Color(0xffff3737),
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: const Color(0xffff3737),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: BorderSide(color: const Color(0xffff3737))
                      ),
                      child: Text('Log in', style: TextStyle(fontSize: 18),),
                      onPressed: () async {
                        print(nameController.text);
                        print(passwordController.text);

                        List<dynamic> Data;
                        Data = await postRequest(nameController.text,passwordController.text);
                        //print(Data[0]['Column1']);
                        if(Data[0]['Column1'] != 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardPage(),
                              ));
                        }
                      },
                    )),

              ],
            )));
  }
}