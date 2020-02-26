
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  
  void play(int a){
       final player = AudioCache();
       player.play('note$a.wav');
  }
  Expanded buildplay(int n,Color color){
    return Expanded(
      child: FlatButton(
      color: color,
      onPressed:(){
                 play(n);
                  },
      child: Text(''),
  )
  );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          buildplay(1, Colors.deepPurple),
          buildplay(2, Colors.orange),
          buildplay(3,Colors.yellow),
          buildplay(4,Colors.red),
          buildplay(5,Colors.blue),
          buildplay(6,Colors.purple),
          buildplay(7,Colors.green),
              ],
              )
        ),
      ),
    );
  }
}
