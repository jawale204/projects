import 'package:flash_chat/requirements/text_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id='LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool spinner=false;
  String email;
  String password;

final FirebaseAuth _auth = FirebaseAuth.instance;
 
  AnimationController controller;
  Animation animation;
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
      body: ModalProgressHUD(
        inAsyncCall: spinner,
              child: Padding(
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
                decoration: KTextDecoration.copyWith(hintText: 'Enter your email')
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
                decoration: KTextDecoration.copyWith(hintText: 'Enter your Password')
              ),
              SizedBox(
                height: 24.0,
              ),
              TextButtons(text: 'login',onPressed: ()async{
                try{
                  setState(() {
                    spinner=true;
                    print('ala re');
                  });
                  print('gela re');
                  var user = await _auth.signInWithEmailAndPassword(email: email,password: password);
                  print('milala re');
                  if (user!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    spinner=false;
                  });
                }
                catch(e){
                  print(e);
                }
              },colour: Colors.lightBlueAccent,)
            ],
          ),
        ),
      ),
    );
  }
}
