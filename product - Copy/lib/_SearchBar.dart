import 'package:flutter/material.dart';
import 'package:product/_SearchRequest.dart';
import 'package:product/SearchPage.dart';
var AmazonProduct='';
var FlipkartProduct='';
var MyntraProduct='';
var ShopcluesProduct='';
var products=[];
Widget SearchBar(BuildContext context){
  var search;
   double screenHeight = MediaQuery.of(context).size.height;
  return Expanded(
    flex: 2,
      child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), 
      color: Colors.black87,),
       margin: EdgeInsets.only(left: 16.0, right: 16.0,top: 16),
        child: Column(
            children:<Widget>[
              SizedBox(
                height: 40,
              ),
              TextField(
               
                onSubmitted: (value)async{
                AmazonProduct=await SearchRequest(controller.text,0);
                 FlipkartProduct=await SearchRequest(controller.text,1);
                //  MyntraProduct=await SearchRequest(controller.text,2);
                // ShopcluesProduct=await SearchRequest(controller.text,3);
                },
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
       suffixIcon : GestureDetector(
         onTap: () async{
               AmazonProduct=await SearchRequest(controller.text,0);
                 FlipkartProduct=await SearchRequest(controller.text,1);
                //  MyntraProduct=await SearchRequest(controller.text,2);
                // ShopcluesProduct=await SearchRequest(controller.text,3);
                
         },
         child: Container(child: Icon(Icons.search,color: Colors.white,))
         ),
            hintStyle: TextStyle(color :Colors.white),
              hintText: 'Search',
            enabledBorder: OutlineInputBorder(
                    borderSide:
            BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide:
            BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
              ),
            ]
        ) ,
      ),
  );
}
