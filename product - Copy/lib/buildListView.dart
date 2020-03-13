import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product/_SearchBar.dart';

ListView buildListView(int which,String details) {
    int b;
    if (details=="")
      b=1;
    else
      sort(details);
    return ListView.builder(
              itemCount: 0,
               itemBuilder: (context,index){
               return(
                     Container(
                        width: 250,
                        height: 120,
                        margin: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('')
           ),
         ));
             },
       );
  }
sort(details){
  String s="product";
 
  if (jsonDecode(details)['Available']==null)  
    print('no products available');
  else if (jsonDecode(details)['TotalProducts']>1)
    try{
      for(int i=0;i<20;i++){
        var pro=jsonDecode(details)[s+i.toString()];
        // var name=(pro)['name'];
      //  print(pro);
      }
    }
  catch(e){
     print(e);
  }
}