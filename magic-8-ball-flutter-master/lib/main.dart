import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
       home: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.blueGrey,
           title: Text('Ask me',style: TextStyle(
             fontSize: 20.0,
             ),
             ),
         ),
         body: Decision(),
       ),
      ),
    );
class Decision extends StatefulWidget {
  @override
  _DecisionState createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  @override
  int a=1;
  void random(){
    a= Random().nextInt(5)+1;
  }
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              random();
            });
          },
        child: Image.asset('images/ball$a.png') 
        )
      ],
    );
  }
}