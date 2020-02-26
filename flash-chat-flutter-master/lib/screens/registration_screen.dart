import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/requirements/text_button.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
   AnimationController controller;
  Animation animation;
  String email;
  String password;
  final _auth=FirebaseAuth.instance;
 
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,
    duration: Duration(seconds: 1)) ; 
    animation=ColorTween(begin:Colors.blueGrey ,end:Colors.white ).animate(controller);  
    setState(() {
      controller.forward();
    });
    controller.addListener((){
      setState(() {});
    });
    
 }
@override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
                          child: Hero(
                  tag: 'logo',
                  child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email=value;
              },
              decoration: KTextDecoration.copyWith(hintText:'Enter your Email id'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
               password=value;    
              },
              decoration: KTextDecoration.copyWith( hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextButtons(text: 'register',
            onPressed: ()async {
              try{
              var newUser = await  _auth.createUserWithEmailAndPassword(email: email,password: password);
              if (newUser!=null){
              Navigator.pushNamed(context, ChatScreen.id);
              }
              }
               catch(e){
                print(e);
              }
            },
            colour: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
