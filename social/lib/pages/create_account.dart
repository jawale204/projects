import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}
final TextEditingController controller=TextEditingController();

class _CreateAccountState extends State<CreateAccount> {
  final _formKey=GlobalKey<FormState>();
  final _scaffoldkey=GlobalKey<ScaffoldState>();
  String username;
  submit(){ 
    setState(() {
      final form =_formKey.currentState;
      if(form.validate()){
       form.save();
       SnackBar snackBar=SnackBar(content: Text('Welcome $username'));
      _scaffoldkey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
    Navigator.pop(context,username);
     });
     
      }
  });
}
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: header(context,titleText: 'Set Up User Profile',leading: false),
      body: Container(
        child:Column(children: <Widget>[
          Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text('Create Username',style: TextStyle(
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
          ),
          ),
         Padding(
           padding:EdgeInsets.only(top:20),
           child: Form(
             key: _formKey,
             child: 
             TextFormField(
               autovalidate: true,
             validator: (val){
                if(val.trim().length<3 || val==null){
                  return 'username too short';
                }else if(val.trim().length>12){
                  return 'username too long';
                }  else{
                   return null; 
                  }
             },
             onSaved: (value){
                username=value;
             },
             controller: controller,
             decoration: InputDecoration(
               labelText:'Username',
               labelStyle: TextStyle(fontSize:15),
               hintText:'enter minimum 3 letter username',
               border:OutlineInputBorder()
             ),
           )
           ), 
         ),

             GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
        ],)
      ),
    );
  }
}
