import 'package:flutter/material.dart';

void main() {
   runApp(
   MyApp()
     );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
        MaterialApp(
       home: Scaffold(
         backgroundColor: Colors.black26,
         appBar: AppBar(
          title: Center(child : Text('i am fuckin rich')),
          backgroundColor: Colors.blueGrey,
          ),
         body: Center(
           child: Image(
             image: AssetImage('images/diamond.jpg'),
           ),
         ),
         ),

       );
}
}