import 'package:Contri/models/HandleUser.dart';
import 'package:Contri/screen/Body.dart';
import 'package:Contri/widget/genbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Welcome extends StatefulWidget {
  @override
  static String id= 'Welcome';
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
 

    @override
  initState() {
    super.initState();
 }
   
  
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<HandleUser>(context);
    return Scaffold(
      // Checks if logged in 
    body:!user.isAuth? Center(
    child:
    //login option
    SaveButton(
      onpress:  (){
        user.login();
      },
       txt: 'Sign In With Google',
      )
     ):
     //main body if loggedin
     Body()
      );
  }
}



