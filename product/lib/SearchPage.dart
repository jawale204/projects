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
    
     var search;
   double screenHeight = MediaQuery.of(context).size.height;
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
               
                onSubmitted: (value)async{
                      setState(()async {
                         AmazonProduct=await SearchRequest(controller.text,0);
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
               buildListView(0,AmazonProduct),
                buildListView(1,FlipkartProduct),
              ],
            ),
        ),
          )
        ]
      ),

    ));
  }

}