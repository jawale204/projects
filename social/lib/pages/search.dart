import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/timeline.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller=TextEditingController();
  Future<QuerySnapshot> userResult;
  handleSearchQuery(String query){
   Future<QuerySnapshot> users = userRef.where('username',isGreaterThanOrEqualTo: query).getDocuments();
  setState(() {
    userResult=users;
  });

    } 
    clears(){
      controller.clear();
    }
 AppBar headSearch(){
     return AppBar(
       backgroundColor: Colors.white,
       title: TextFormField(
         decoration: InputDecoration(
           hintText:'search for user...',
           prefixIcon: Icon(
             Icons.account_box,
             size: 15,),
             suffixIcon: IconButton(
               icon: Icon(Icons.clear),
             onPressed: clears()
             ),
             filled: true
         ),
        onFieldSubmitted: handleSearchQuery,
        
       ),
     );
  }
Container noContentBody(){
Orientation O= MediaQuery.of(context).orientation;
return Container(
  child: Center(
    child: ListView(
      shrinkWrap: true,
     children:<Widget>[
       SvgPicture.asset('assets/images/search.svg',height: O==Orientation.portrait? 300:200,alignment: Alignment.center,),
       Text('Find User',textAlign: TextAlign.center,
       style: TextStyle(
         fontStyle: FontStyle.italic,
         color:Colors.white,
         fontWeight: FontWeight.w600,
         fontSize: 60
       ),)
     ] 
    ),
  ),
);

  }

buildUserResults(){
   return FutureBuilder(
     future: userResult,
     builder: (context,snapshot){
       if(!snapshot.hasData){
         return circularProgress();
       }else{
         List<UserResult> searchResults=[];
          snapshot.data.documents.forEach((doc){
          User user =User.fromDocument(doc);
          UserResult searchresult =UserResult(user);
          searchResults.add(searchresult);
          });
          return ListView(
            children: searchResults,
          );
         }
     }
   );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar : headSearch(),
      body: userResult==null? noContentBody():
      buildUserResults(),
    );
  }
}

class UserResult extends StatelessWidget {

  UserResult(this.users);
  final User users;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: ()=>print('tapped'),
            child: ListTile(
            leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
       users.photoUrl
     ),
            backgroundColor: Colors.grey,
            
          ),
          title: Text(users.displayName,style: TextStyle(color:Colors.white,
          fontWeight: FontWeight.bold)
          
          ,),
          subtitle: Text(users.username,style: TextStyle(
              color: Colors.white54,
          )
          )
          ),
          ),
         Divider(
           height: 2,
           color:Colors.white54,
         )
        ],
      ),
    );
  }
}
