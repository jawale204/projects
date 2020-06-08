import 'package:Contri/models/Groups.dart';
import 'package:Contri/widget/genbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {

Future<QuerySnapshot> b;
  @override
  Widget build(BuildContext context) {
  final groupsdoc=Provider.of<Groups>(context);
   Future<QuerySnapshot> a =groupsdoc.getGroups();
    return Column(children: <Widget>[
    FutureBuilder(
      future: a,
      initialData:b,
      builder:(BuildContext context,AsyncSnapshot snapshot){
      if(snapshot.hasData){
        List<GroupList> searchGroup=[];
        snapshot.data.documents.forEach((doc){
         Groups singleGroup= Groups.fromDocument(doc);
         GroupList list=GroupList(ekGroup:singleGroup);
        searchGroup.add(list);
        });
        return ListView(
          children: searchGroup,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          );

      }
      else{
        return SizedBox(
          height: 20,
        );
      }
    } ,
    ),
     SizedBox(
          height: 20,
        ),
        SaveButton(
    txt: 'Create a new Group',
    onpress: (){
      groupsdoc.createGroup();
    },
        )
      ],);
  }
}

class GroupList extends StatelessWidget {
  final Groups  ekGroup;
  GroupList({this.ekGroup});
  @override
  Widget build(BuildContext context) {
    return ListTile(
    title: Text(ekGroup.groupName),
    leading: Icon(Icons.library_books),
    );
  }
}