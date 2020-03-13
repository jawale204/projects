import 'package:flutter/material.dart';
import 'package:product/_SearchBar.dart';
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
    double screenheight = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
      body: Column(
        children:<Widget>[
          SearchBar(context),
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
                    //  customTab('Myntra'),
                    //  customTab('Shopclues'),
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
                  // buildListView(2,MyntraProduct),
                //   //  buildListView(3,ShopcluesProduct)
                //           buildListView(0,AmazonProduct),
                // buildListView(1,FlipkartProduct),
              ],
            ),
        ),
          )
        ]
      ),

    ));
  }

}