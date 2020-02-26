import 'package:flutter/material.dart';
import 'package:practice/Register.dart';
import 'package:practice/login.dart';
void main() => runApp(Myapp());
class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id:(context)=>LoadingScreen(),
        Login.id:(context)=>Login()
    },
    );
  }
}