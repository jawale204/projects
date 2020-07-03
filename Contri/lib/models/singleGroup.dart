import 'package:Contri/models/Groups.dart';
import 'package:Contri/models/HandleUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SingleGroup with ChangeNotifier {
  final Groups obj;
  String name;
  DateTime date;
  List expense;
  String docId;
  SingleGroup({this.obj, this.expense, this.name, this.date, this.docId});
  static CollectionReference groups = Firestore.instance.collection('GroupsDB');
  QuerySnapshot expenses;
  List docID = [];
  // returns members list
  Future<Map<String, Map<String, dynamic>>> allMembers(vobj) async {
    DocumentReference allMembersAndExpense = groups.document(vobj.groupId);
    QuerySnapshot members =
        await allMembersAndExpense.collection('Members').getDocuments();
    Map<String, Map<String, dynamic>> memberMap = {};
    var i = 0;
    members.documents.forEach((element) {
      i = i + 1;
      memberMap.addAll({'member' + i.toString(): element.data});
    });
    return memberMap;
  }

  //adds expense with expense list its description //obj for that particular group info
  addExpense(expense, description, obj, time) {
    groups
        .document(obj.groupId)
        .collection('Expense')
        .add({'name': description, 'expense': expense, 'Date&Time': time});

    notifyListeners();
  }

  Future<QuerySnapshot> allExpense(vobj) async {
    docID = [];
    DocumentReference allMembersAndExpense = groups.document(vobj.groupId);
    expenses = await allMembersAndExpense
        .collection('Expense')
        .orderBy('Date&Time', descending: true)
        .getDocuments();

    expenses.documents.forEach((element) {
      docID.add([element.documentID]);
    });
    return expenses;
  }

  factory SingleGroup.fromDocument(DocumentSnapshot doc) {
    return SingleGroup(
      name: doc['name'],
      expense: doc['expense'],
      date: doc['Date&Time'].toDate(),
    );
  }

  Future<bool> deleteExpense(docId, obj) async {
    await groups
        .document(obj.groupId)
        .collection('Expense')
        .document(docID[docId][0])
        .delete();

    notifyListeners();
    return true;
  }

  Future<bool> addMember(user, Groups obj) async {
    bool present;
    QuerySnapshot isPresent = await Firestore.instance
        .collection('GroupsDB')
        .document(obj.groupId)
        .collection('Members')
        .getDocuments();
    var a = isPresent.documents
        .any((element) => element.data.containsValue(user.uid));
    if (!a) {
      await Firestore.instance
          .collection('GroupsDB')
          .document(obj.groupId)
          .collection('Members')
          .document()
          .setData({
        'name': user.displayName,
        'uid': user.uid,
        'photoUrl': user.photoUrl,
        'email': user.email,
      });
      await userRef.document(user.uid).collection('Groups').add({
        'name': obj.groupName,
        'groupid': obj.groupId,
        'Date&Time': obj.date
      });
      present = false;
    } else {
      present = true;
    }
    notifyListeners();
    return (present);
  }
}
