import 'dart:convert';
import 'package:allinone/customTab.dart';
import 'package:flutter/material.dart';
import 'package:allinone/searchRequest.dart';

class SearchPage extends StatefulWidget {
   static String id="SearchPage";
 
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  TextEditingController controller=TextEditingController();
   TabController _tabController;
   var detail1='';
   var detail2='';
    var _name1=[];
  var _link1=[];
  var _rating1=[];
  var _price1=[];
  var _imageLink1=[];
   var _name=[];
  var _link=[];
  var _rating=[];
  var _price=[];
  var _imageLink=[];
 
   @override
  void initState(){
    super.initState();
   _tabController= new TabController (length: 2,vsync: this ,initialIndex: 0);

  }
  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }
  _set()async{
    _name=[];
    _link=[];
    _rating=[];
    _price=[];
    _imageLink=[];
    _name1=[];
    _link1=[];
    _rating1=[];
    _price1=[];
    _imageLink1=[];
    detail1= await SearchRequest(controller.text,0);
    sort(detail1,_name,_link,_rating,_price,_imageLink);
    detail2= await SearchRequest(controller.text,1);
    sort(detail2,_name1,_link1,_rating1,_price1,_imageLink1);
 }
  sort(details,nameN,linkL,ratingR,priceP,imageLinkI){
    setState(() {
        String a="product";
     for(int i=1;i<15;i++){
      var pro=jsonDecode(details)[a+i.toString()];
      var nam=(pro)['name'];
      nameN.add(nam);
      var lin=(pro)['link'];
      linkL.add(lin);
      var rat=(pro)['rating'];
      ratingR.add(rat);
      var pri=(pro)['price'];
      priceP.add(pri);
      var img=(pro)['imglink'];
      imageLinkI.add(img);
      }
     });
}
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
           buildExpanded(),
           tabView(), 
           resultView()
         ]
        ),
      ),
    );
  }
///Result
  Expanded resultView() {
    return Expanded(
          flex: 7,
          child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
            buildListView(_name,_link,_rating,_price,_imageLink),
            buildListView(_name1,_link1,_rating1,_price1,_imageLink1),
            ],
          ),
      ),
        );
  }
///TabBar
  Expanded tabView() {
    return Expanded(
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
        );
  }
///SearchBar
  Expanded buildExpanded() {
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
             
              onSubmitted: (value){
             setState(() {
               _set();
               });
          },
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
     suffixIcon : GestureDetector(
       onTap: (){
          setState(() {
             _set();
          });
              
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
///listView
  ListView buildListView(name,link,rating,price,imageLink) {
    return ListView.builder(
            itemCount: name.length,
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
                        child: Row(
                          children: <Widget>[
                            Image.network(imageLink[index],width:100 ,height: 100,),
                            Flexible(
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:<Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(name[index],
                                 // overflow: TextOverflow.fade,
                                    //softWrap: false,
                                    maxLines: 3,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text("Rating:"+rating[index]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text("Price:"+price[index]),
                                  )
                                ]
                              ),
                            )
                          ],)
         ),
       ));
           },
     );
  }
}