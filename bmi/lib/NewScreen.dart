import 'package:bmi_calculator/constant.dart';
import 'package:flutter/material.dart';
import 'primary_box.dart';

class Screen extends StatelessWidget {
  Screen({@required this.result,@required this.bmi,@required this.inter});
  final String result;
  final String bmi;
  final String inter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
          title: Text('BMI Calculator'),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
                  child: Text('Your Result',style: TextStyle(
            fontSize: 50)),
        ),
        Expanded(
          flex: 5,
            child: Primarybox(
            colour: activeBoxColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(result, style: TextStyle(
                    fontSize: 20,
                    )
                    ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(bmi,style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Center(
                  child: Text(inter,style: TextStyle(
                    fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
             
              ],
            ),
             ),
              ),
            GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
                      child: Container(
              child: Center(
                child: Text('Re-Calculate',style: TextStyle(
                  fontSize: 20 )),
              ),
              color: bottonHeightColor ,
              height: 65.0,
              width: double.infinity,
            ),
          )
      ],
    )

    );
  }
}