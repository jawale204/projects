import 'package:flutter/material.dart';

void main() {
  runApp(
   MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        backgroundColor: Colors.teal,
        body: Center(
          child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('images/me.jpg'),
                  ),
                   Text('Rahul Jawale',style: TextStyle(
                                          fontFamily: 'Pacifico',
                                          fontSize: 40.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                  ),),
                  Text('FLUTTER DEVELOPER',
                                      style: TextStyle(
                                       fontFamily: 'SourceSansPro',
                                       fontSize: 20.0,
                                       color: Colors.teal.shade100,
                                       letterSpacing: 2.5,
                                       fontWeight: FontWeight.bold,
                                     ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade200,
                    ),
                  ),
                  Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                   child: ListTile(
                     leading:Icon(Icons.phone,color: Colors.teal),
                        title:Text('+91 8425030489'),
                   )

                   ),
                   Card(
                   color: Colors.white,               
                   margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                   child: ListTile(
                     leading: Icon(Icons.email,color: Colors.teal) ,
                     title: Text('jawale204@gmail.com'),
                   )
                   ),

               ],
              )
            ),
        ),
        ),
      );
  }
}
