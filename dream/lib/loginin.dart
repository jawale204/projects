import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loggedin=false;
  GoogleSignIn _googleSignIn= GoogleSignIn(scopes: ['email']);
  _login()async{
    try{
    await _googleSignIn.signIn();
    setState(() {
      _loggedin=true;
    });
    }
    catch(e){
      print(e);
    }
  }
  _logout()async{
    try{
    await _googleSignIn.signOut();
    setState(() {
      _loggedin=false;
    });
    }
    catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loggedin?
      Column(
        children: <Widget>[
          Image.network(_googleSignIn.currentUser.photoUrl),
          Text(_googleSignIn.currentUser.displayName),
          Text(_googleSignIn.currentUser.email),
          FlatButton.icon(onPressed: (){
            _logout();
          }, icon: Icon(Icons.add), label: Text('logout')),
        ],
      ): Column(
              children:<Widget>[FlatButton.icon(onPressed: (){
          _login();
        }, icon: Icon(Icons.add), label: Text('login')),]
      )
    );

  }
}