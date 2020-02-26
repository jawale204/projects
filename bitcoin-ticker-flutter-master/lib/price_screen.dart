import 'package:bitcoin_ticker/crypto_box.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}


class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='USD';
   double currencyValue1=0;
      double currencyValue2=0;
         double currencyValue3=0;
   var data=[];

  void getData(String currency)async{
   
  for (String i in cryptoList){
  print(currency);
  http.Response coinData = await http.get('https://apiv2.bitcoinaverage.com/indices/global/ticker/$i$selectedCurrency');
  var instantData=coinData.body;
  data.add(instantData);
  print('yes');
  }

   setState(() {
      currencyValue1=jsonDecode(data[0])['open']['hour'];
       currencyValue2=jsonDecode(data[1])['open']['hour'];
        currencyValue3=jsonDecode(data[2])['open']['hour'];
      data=[];
  });


}
  DropdownButton<String> getDropdownItems() {

    List<DropdownMenuItem<String>> dropDownItems=[];
      for (String currency in currenciesList){
        var value= DropdownMenuItem(
           child: Text(currency),
           value: currency,
            );
         dropDownItems.add(value);
      }
       return  DropdownButton<String>(
              value: selectedCurrency,
              items: dropDownItems,
              onChanged: (value){
                setState(() {
                    selectedCurrency=value;
                    getData(selectedCurrency);

                });
               }
            );
        }

  @override
  void initState() {
    getData('USD');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CryptoBox(currencyValue: currencyValue1,selectedCurrency: selectedCurrency,cryptoType: 'BTC',),

          ),
           Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CryptoBox(currencyValue: currencyValue2,selectedCurrency: selectedCurrency,cryptoType: 'ETH',),

          ),
           Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CryptoBox(currencyValue: currencyValue3,selectedCurrency: selectedCurrency,cryptoType: 'LTC',),

          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isAndroid? getDropdownItems(): Text('to lazy to implement'),
            ),
            ]
            ),
          );
  }
} 
