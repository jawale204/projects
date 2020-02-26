import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Mainpage.dart';
import 'package:notes/Welcome.dart';
import 'package:notes/demo.dart';
import 'package:notes/reset.dart';
import 'package:notes/signup.dart';

void main(){ 
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
    runApp(Notes());
  });
}

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}
String a;
class _NotesState extends State<Notes> {
  @override
  void initState(){
    super.initState();
  }
  @override 
  void dispose(){
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:Demo.id,
      routes: {
        Welcome.id:(context)=>Welcome(),
        Mainpage.id:(context)=>Mainpage(),
        Signup.id:(context)=>Signup(),
        Reset.id:(context)=>Reset(),
        Demo.id:(context)=>Demo(),
      }   
    );
  }
}