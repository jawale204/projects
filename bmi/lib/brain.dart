
import 'dart:math';

import 'package:flutter/cupertino.dart';

class Brain{
  Brain({@required this.height,@required this.weight});
  final height;
   final weight;
   double _bmi;
  String calBmi(){
    _bmi=weight/pow(height/100,2);
    return _bmi.toStringAsFixed(1);
  }
  String getResult(){
    if(_bmi>=25){
      return 'overweight';
    }
    if(_bmi<18.5){
      return 'underweight';
    }
    else{
      return 'Normal';
    }
  }
  String interpretationRes(){
    if(_bmi>=25){
      return 'You need to change your diet and eat healthy and excercise';
    }
    if(_bmi<18.5){
      return 'You need to eat a bit more ';
    }
    else{
      return 'Good job! You have normal body weight';
    }
  }
}