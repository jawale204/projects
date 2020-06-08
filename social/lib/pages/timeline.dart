import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';


final userRef= Firestore.instance.collection('users');
class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}
class _TimelineState extends State<Timeline> {
 
  @override
  void initState() {
    super.initState();
  }
  // getUsers (){
  //     userRef.getDocuments().then((QuerySnapshot snapshot){
  //       snapshot.documents.forEach((DocumentSnapshot doc){
  //         print(doc.data);
  //         print(doc.documentID);
  //       });
  //     });
  //   }
//   getUsers()async{
//  QuerySnapshot snapshots=await userRef
//  .getDocuments();
//     snapshots.documents.forEach((DocumentSnapshot doc ){
//           print(doc.data);
//       });
//   }
// updateUser()async{
//  final doc= await userRef.document('mfZbbBNbTzCq2Og3uBL0').get();
//  if(doc.exists){
//    doc.reference.setData({'username':'Rahul','age':20,'postcount':101});
//  }
// }
// deleteUser()async{
//  final doc= await userRef.document('aEybH4Rm5nDyDShzszQ5').get();
//  if(doc.exists){
//    doc.reference.delete();
//  }
// }
// StreamBuilder<QuerySnapshot>(
//           stream: userRef.snapshots(),
//           builder: (context,snapshots){
//            if(!snapshots.hasData){
//              return circularProgress();
//            }
//           List<Text> users=snapshots.data.documents.map((users)=>Text(users['username'])).toList();
//            return ListView(
//              children: users);
//           }
//           ),
    @override
    Widget build(context) {
      return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: Text('rar')
      );
    }
  }
  
