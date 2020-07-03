import 'package:Contri/models/Groups.dart';
import 'package:Contri/models/HandleUser.dart';
import 'package:Contri/models/singleGroup.dart';
import 'package:Contri/widget/genbutton.dart';
import 'package:Contri/widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final Groups obj;
  Search({this.obj});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  Future<QuerySnapshot> userResult;
  handleSearchQuery(String query) {
    Future<QuerySnapshot> users =
        userRef.where('email', isEqualTo: query).getDocuments();
    setState(() {
      userResult = users;
    });
  }

  clears() {
    controller.clear();
  }

 

  AppBar headSearch() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'search for user...',
                prefixIcon: Icon(
                  Icons.account_box,
                  size: 35,
                  color: Colors.blue,
                ),
                suffixIcon:
                    IconButton(icon: Icon(Icons.clear), onPressed: clears()),
                filled: true),
            onFieldSubmitted: handleSearchQuery,
          ),
        ],
      ),
    );
  }
 final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldstate,
        backgroundColor: Colors.white,
        appBar: headSearch(),
        body: FutureBuilder(
            future: userResult,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress();
              } else {
                List<Container> searchResults = [];
                snapshot.data.documents.forEach((doc) {
                  User user = User.fromDocument(doc);
                  Container searchresult =
                      useRResult(user, context, widget.obj,_scaffoldstate);
                  searchResults.add(searchresult);
                });
                return ListView(
                  children: searchResults,
                );
              }
            }));
  }
}

Container useRResult(User users, context, obj,key) {
   
   snackBar(bool present) {
    var message = !present ? 'Member added' : ' Member already exists';
    final snackBar = SnackBar(content: Text(message));
    key.currentState.showSnackBar(snackBar);
  }
  final sg = Provider.of<SingleGroup>(context);
  doit() async {
   bool p = await sg.addMember(users, obj);
    snackBar(p);
    Navigator.pop(context);
  }

  return Container(
    color: Colors.grey[400],
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(child: Text('Add User ?')),
                    actions: <Widget>[
                      Center(
                        child: SaveButton(
                          onpress: () {
                            doit();
                          },
                          txt: 'Add',
                        ),
                      ),
                    ],
                  );
                })
          },
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(users.photoUrl),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                users.displayName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(users.email,
                  style: TextStyle(
                    color: Colors.white54,
                  ))),
        ),
        Divider(
          height: 2,
          color: Colors.white54,
        )
      ],
    ),
  );
}
