import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';



class CryptoBox extends StatelessWidget {
   CryptoBox({
    @required this.cryptoType,
    @required this.currencyValue,
    @required this.selectedCurrency,
  
  }) ;
  final double currencyValue;
  final String selectedCurrency;
  final String cryptoType;
  


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoType = $currencyValue $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      onPressed:() {
           
      },
    );
  }
} 
