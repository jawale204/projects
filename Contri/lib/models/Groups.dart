import 'package:Contri/models/HandleUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';

class Groups with ChangeNotifier{
CollectionReference groups=Firestore.instance.collection('GroupsDB');
final String groupName;
final String groupId;
QuerySnapshot groupDoc;
QuerySnapshot a;
Groups({this.groupName,this.groupId});
createGroup(){
DocumentReference doc =groups.document();
var groupID=doc.documentID;
  doc.collection('Members').document().setData({
    'admin': HandleUser.userinfo.uid
  });
 userRef.document(HandleUser.userinfo.uid).collection('Groups').add({'name':groupID});
  //.setData({'name':groupID},merge: true);
  notifyListeners();
}

Future<QuerySnapshot>getGroups()async{
 groupDoc=await userRef.document(HandleUser.userinfo.uid).collection('Groups').getDocuments();
print('idarse');
return groupDoc;
  
}
factory Groups.fromDocument(DocumentSnapshot doc){
  return Groups(
    groupName: doc['name'],
    groupId: 'id'
  );
}
dip(){
  groupDoc=a;
  notifyListeners();
}
}