import 'package:flutter/material.dart';
import 'constant.dart';

class CardContent extends StatelessWidget {
  CardContent({ this.g, this.acon});
  final String g;
  final IconData acon;
  @override
   Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          acon,
          size: 80.0,
        ),
        SizedBox(
                    height: 10.0,
                ),
        Text('$g',style: labelTextStyle  ),
      ],
    );
  }
}
