import 'package:flutter/material.dart';
import 'package:notes/brain.dart';
import 'package:notes/signup.dart';

import 'constants.dart';
class Reset extends StatefulWidget {
  static String id='Reset';
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
    TextEditingController controller=TextEditingController();
    String _password;
  @override
  Widget build(BuildContext context) {
    Brain b= Brain();
    return Scaffold(
      body:Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
          TextFormField(
            controller: controller,
            obscureText: true,
            onChanged: (value){
              _password=value;
            },
            decoration:  KTextDecoration.copyWith(hintText: 'Enter password',hintStyle: TextStyle(
              color: Colors.black
            ),
            ),
          ),
          SizedBox(
                 height: 20,
               ),
              SaveButton(
               
                onpress:  (){
                setState(()async {
                 controller.clear();
                print(_password);
                dynamic a=1;
                a=await b.oh(_password);
                print(a);
                if(a==1){
                  Navigator.pushNamed(context, Signup.id);
                }
                else{
                   createalertDialogue(context,'Wrong password');
                 } });
            },
                 txt: 'Check',
              ),
             ],
           ),
         )
    );
  }
}