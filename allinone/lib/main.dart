import 'package:allinone/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){runApp (MyApp());});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SearchPage.id,
      routes: {
        SearchPage.id:(context)=>SearchPage(),
      },
    );
  }
}