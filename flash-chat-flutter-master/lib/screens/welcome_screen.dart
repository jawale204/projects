import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/requirements/text_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                    child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
               ScaleAnimatedTextKit(
                 text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            TextButtons(onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },
            text: 'login',
            colour: Colors.lightBlueAccent,),
              TextButtons(onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            text: 'Register',
            colour: Colors.blueAccent,),
            
          ],
        ),
      ),
    );
  }
}

