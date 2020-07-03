import 'package:Contri/models/HandleUser.dart';
import 'package:Contri/models/singleGroup.dart';
import 'package:Contri/screen/Body.dart';
import 'package:Contri/screen/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


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
    return MultiProvider(
      providers:[ 
        ChangeNotifierProvider(
         create:  (context)=>HandleUser()
           ),
         ChangeNotifierProvider<SingleGroup>(
         create:  (context)=>SingleGroup()
           ),
        ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:Welcome.id,
        routes: {
           Welcome.id:(context)=>Welcome(),
            Body.id:(context)=>Body(),
        }   
      ),
    );
  }
}