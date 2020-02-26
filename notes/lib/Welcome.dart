import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Mainpage.dart';
import 'package:notes/constants.dart';
import 'package:notes/signup.dart';
import 'brain.dart';

class Welcome extends StatefulWidget {
  @override
  static String id= 'Welcome';
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController controller=TextEditingController();
    String _password;
    @override
    void initState(){
      super.initState();
    }
    @override
    void dispose(){
      SystemNavigator.pop();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
      Brain b=Brain();
    return Scaffold(
        body: Center(
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
                    Navigator.pushNamed(context,Mainpage.id);
                }
                else{
                   createalertDialogue(context,'Wrong password');
                 } });
            },
                 txt: 'login',
              ),
               SizedBox(
                 height: 30,
               ),
               Text('-----------or-----------'),
               SizedBox(
                 height: 30,
               ),
                 SaveButton(
                   onpress: (){
                setState (()async {
                 dynamic a= await b.oh(true);    
               if(a==2){
              Navigator.pushNamed(context, Signup.id);
                  }
               else{
                  createalertDialogue(context,'already signed in');
                   }
              });
              },
                   txt:'Signup'),
               SizedBox(
                 height: 50,
               ),
             ],
           ),
         )
    );
  }
}


