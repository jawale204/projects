import 'package:flutter/material.dart';

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