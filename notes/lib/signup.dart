import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Mainpage.dart';


import 'brain.dart';
import 'constants.dart';

class SaveButton extends StatelessWidget {
 SaveButton({this.onpress,this.txt});
 final Function onpress;
 final String txt;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
          onPressed:onpress,
         child: Text(txt),
         height: 50,
         elevation: 5,
         color: Colors.blueAccent,
         textColor: Colors.white,
         minWidth: 250,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
        );
  }
}

class Signup extends StatefulWidget {
  static String id='Signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
   String _p1,_p2;
   TextEditingController controller1=TextEditingController();
   TextEditingController controller2=TextEditingController();
   @override 
   void dispose(){
  
     super.dispose();
   }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Password'),),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
            TextFormField(
              controller: controller1,
            obscureText: true,
            onChanged: (value){
              _p1=value;
            },
            decoration:  KTextDecoration.copyWith(hintText: 'Enter new password',hintStyle: TextStyle(
              color: Colors.black
            ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
      TextFormField(
        controller: controller2,
            obscureText: true,
            onChanged: (value){
              _p2=value;
            },
            decoration:  KTextDecoration.copyWith(hintText: 'Re-enter Password',hintStyle: TextStyle(
              color: Colors.black
            ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('For Recovery'),
             SizedBox(
            height: 10,
          ),
           SaveButton(
             onpress:(){
               setState(() {
                     controller1.clear();
               controller2.clear();
               Brain b=Brain();
               if(b.validateStructure(_p1)){
              if(_p1==_p2){
                b.ok(_p1);
                Navigator.pushNamed(context,Mainpage.id);
                }
                 else{
               createalertDialogue(context,'passwords do not match');
              }
              }
              else{
                createalertDialogue(context,'weak password please enter password with Minimum 1 Uppercase 1 Special Character 1 Numeric Number 1 lowercase'
             );
              }
               });
           
            },
             txt: 'Save',
           ),
        
        ],
      ),
       );
  }
}
 Future createalertDialogue(BuildContext context,String index){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Error'),
        content: Text(
           index),
           actions: <Widget>[
             FlatButton(child: Text('ok',style: TextStyle(fontSize: 20),),
             onPressed: (){
               Navigator.pop(context);
             },)
           ],
       
          );
        
        } 
      );
    }