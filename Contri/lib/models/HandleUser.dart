import 'package:Contri/screen/Welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final userRef = Firestore.instance.collection('users');
final DateTime time = DateTime.now();
final FirebaseAuth _auth = FirebaseAuth.instance;

class User {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  User({this.uid, this.email, this.photoUrl, this.displayName});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: doc['Uid'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
    );
  }
}

class HandleUser with ChangeNotifier {
  bool isAuth = false;
  static User userinfo;
  User tocopy;

  login() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    isAuth = true;
    DocumentSnapshot doc = await userRef.document(currentUser.uid).get();
    if (!doc.exists) {
      createUserInFirebase(doc, currentUser);
    } else {
      userinfo = User.fromDocument(doc);
    }

    notifyListeners();
  }

  logout(context) async {
    await googleSignIn.signOut();
    _auth.signOut();
    isAuth = false;
    userinfo = tocopy;
    notifyListeners();
    Navigator.of(context).popUntil(ModalRoute.withName(Welcome.id));
  }

  createUserInFirebase(doc, user) async {
    if (!doc.exists) {
      await userRef.document(user.uid).setData({
        'Uid': user.uid,
        'photoUrl': user.photoUrl,
        'email': user.email,
        'displayName': user.displayName,
        'timeStamp': time,
      });
      doc = await userRef.document(user.uid).get();
    }
    userinfo = User.fromDocument(doc);
  }
}
