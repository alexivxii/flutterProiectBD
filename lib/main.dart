import "package:flutter/material.dart";
import "package:proiectbd/LoginPage.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
    );
  }
}

