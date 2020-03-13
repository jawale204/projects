import 'dart:convert';

import 'package:flutter/material.dart';



ListView buildListView(int which,String details) {
    var name=[];
    var link=[];
    var rating=[];
    var price=[];
    var imageLink=[];
    int b;
    if (details=="")
      b=1;
    else
      sort(details,name,link,rating,price,imageLink);
    return ListView.builder(
               itemCount:name.length,
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
                          child: Text(name[index])
           ),
         ));
             },
       );
  }
sort(details,name,link,rating,price,imageLink){
   String a="product";
     for (int i=1;i<15;i++){
      var pro=jsonDecode(details)[a+i.toString()];
      var nam=(pro)['name'];
      name.add(nam);
      var lin=(pro)['link'];
      link.add(lin);
      var rat=(pro)['rating'];
      rating.add(rat);
      var pri=(pro)['price'];
      price.add(pri);
      var img=(pro)['imglink'];
      imageLink.add(img);
    
     }
}