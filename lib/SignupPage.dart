import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}



Future<http.Response> postRequest (String user, String pass) async {
  var url ='http://10.0.2.2:5000/api/user';

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
  return response;
}

class _State extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List DataListUserExists;

  Future<String> _verifyUserExists(String username) async {

    final response =
    await http.get('http://10.0.2.2:5000/api/user/userexists/${username}');
    print("a");
    DataListUserExists = json.decode(response.body);
    print(DataListUserExists);
    print(DataListUserExists.length);

    return "Succes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('Login Screen App'),
//        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    padding: EdgeInsets.fromLTRB(0,20,20,25),
                    child: Row(
                      children: <Widget>[
                        IconButton(

                          icon: Icon(Icons.arrow_back_ios),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 135),
                        Text(
                          'Signup Page',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
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
                      child: Text('Register', style: TextStyle(fontSize: 18),),
                      onPressed: () async{
                        print(nameController.text);
                        print(passwordController.text);

                       await _verifyUserExists(nameController.text);

                        if(DataListUserExists[0]['Column1']==0)
                          postRequest(nameController.text,passwordController.text);
                        else print("User Already Exists");


                      },
                    )),
              ],
            )));
  }
}