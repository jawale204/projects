import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product/_SearchRequest.dart';
import 'package:product/buildListView.dart';
import 'package:product/customTab.dart';

TextEditingController controller=TextEditingController();
class SearchPage extends StatefulWidget  {
  static String id="SearchPage";
 
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  with TickerProviderStateMixin{
  TabController _tabController;
  var AmazonProduct='';
  var FlipkartProduct="";
  @override
  void initState(){
    super.initState();
    controller.text="";
   _tabController= new TabController (length: 2,vsync: this ,initialIndex: 0);
  }
  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
      var name=[];
    var link=[];
    var rating=[];
    var price=[];
    var imageLink=[];
    int b;
    var aLL=[];
     var search;
   double screenHeight = MediaQuery.of(context).size.height;
   perform()async{
   AmazonProduct=await SearchRequest(controller.text,0);
   return AmazonProduct;
   }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
      body: Column(
        children:<Widget>[
          Expanded(
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
               
                onSubmitted: (value){
                      setState(() async{
                        AmazonProduct=await perform();
                        if (AmazonProduct==""){
                           b=1;}
                        else{
                          setState(() {
                             aLL=sort(AmazonProduct,name,link,rating,price,imageLink);
                             name=aLL[0];
                             link=aLL[1];
                             rating=aLL[2];
                             print(name);
                             print(link);
                             print(rating);
                          });
                          
                        }
                      });
                      
                  
               
              //   FlipkartProduct=await SearchRequest(controller.text,1);
                //  MyntraProduct=await SearchRequest(controller.text,2);
                // ShopcluesProduct=await SearchRequest(controller.text,3);
                },
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
       suffixIcon : GestureDetector(
         onTap: () async{
               AmazonProduct=await SearchRequest(controller.text,0);
                // FlipkartProduct=await SearchRequest(controller.text,1);
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
  ),
           Expanded(
             flex: 1,
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               TabBar(
               controller: _tabController,
                 labelColor: Colors.black87,
                 unselectedLabelColor: Colors.black87,
                 unselectedLabelStyle: TextStyle(color:Colors.black54),
                tabs: <Widget>[
                     customTab('Amazon'),
                     customTab('Flipkart'),
                   ] ,
                  isScrollable: true,
                   indicatorColor: Colors.grey[700],
                   indicatorWeight: 6  ,
                    )
             ],
             
          ),
          ),
          Expanded(
            flex: 7,
            child: Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
               ListView.builder(
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
       ),
                buildListView(aLL),
              ],
            ),
        ),
          )
        ]
      ),

    ));
  }

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
     return([name,link,rating,price,imageLink]);
}
