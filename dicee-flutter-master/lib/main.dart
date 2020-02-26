import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade400,
        appBar: AppBar(
          title: Center(child:Text('Dice Play')),
          backgroundColor: Colors.blueGrey.shade800,
        ),
        body:SafeArea(
           child: Padding(
             padding: EdgeInsets.all(0.0),
            child: DicePage()
           )
           ),
      ),
    ),
  );
}
class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
   int leftdicechange=1,rightdicechange=1;
   void changeDiceFace(){
       setState(() {
                leftdicechange=1+Random().nextInt(6);
                rightdicechange=1+Random().nextInt(6);
                print("ellow there right mate");
              });
   }
   @override
  Widget build(BuildContext context) {
   
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
           Expanded( 
             flex: 2,
             child: FlatButton(
               onPressed: (){
                 changeDiceFace();
                 },
               child: Image.asset('images/dice$leftdicechange.png',height: 150.0,width: 150.0 ,)),
             ),
           Expanded( 
             flex: 2,
             child: FlatButton(
               onPressed: (){
                   changeDiceFace();
                },
               child: Image.asset('images/dice$rightdicechange.png',height: 150.0,width: 150.0 ,)),
            ),
           ],
        ),
        SizedBox(
          height: 50.0,
        ),
         RaisedButton(
           child: Text('Reset',
           style:TextStyle(
             fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
           ),
           ),
            onPressed:(){ setState(() {
              leftdicechange=1;
              rightdicechange=1;
            }); 
            },
         )
      ],
    );
  }
}
