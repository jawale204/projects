import 'package:Contri/models/Groups.dart';
import 'package:Contri/screen/GroupContent.dart';
import 'package:Contri/widget/constants.dart';
import 'package:Contri/widget/genbutton.dart';
import 'package:Contri/widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime date = DateTime.now();

class Group extends StatefulWidget {
  static String id = 'Group';
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  TextEditingController controller = TextEditingController();
  Future<QuerySnapshot> b;

  @override
  Widget build(BuildContext context) {
    final groupsdoc = Provider.of<Groups>(context);
    //gets the groups of user
    Future<QuerySnapshot> a = groupsdoc.getGroups();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(children: <Widget>[
            FutureBuilder(
              future: a,
              initialData: b,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<GroupList> searchGroup = [];
                  snapshot.data.documents.forEach((doc) {
                    Groups singleGroup = Groups.fromDocument(doc);
                    GroupList list = GroupList(ekGroup: singleGroup);
                    searchGroup.add(list);
                  });
                  return ListView(
                    children: searchGroup,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  );
                } else {
                  return circularProgress();
                }
              },
            ),
            Positioned(
              bottom: 20,
              right: 50,
              left: 50,
              child: SaveButton(
                txt: 'Create a new Group',
                onpress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Create New Group'),
                          content: Container(
                            width: 250,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                    controller: controller,
                                    decoration: KTextDecoration.copyWith(
                                        hintText: 'Enter group Name',
                                        hintStyle:
                                            TextStyle(color: Colors.black54))),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Center(
                              child: SaveButton(
                                onpress: () {
                                  if (controller.value.text
                                      .toString()
                                      .isNotEmpty) {
                                    //creates Group
                                    groupsdoc.createGroup(
                                        controller.value.text.toString(), date);
                                    controller.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                txt: 'Save',
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class GroupList extends StatelessWidget {
  final Groups ekGroup;
  //takes Groups object for that group
  GroupList({this.ekGroup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        title: Text(ekGroup.groupName),
        leading: Icon(Icons.group),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              //pass that Groups object to the GroupContent page
              builder: (context) => GroupContent(obj: ekGroup),
            ),
          );
        },
      ),
    );
  }
}
