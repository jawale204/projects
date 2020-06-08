import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/activity_feed.dart';
import 'package:fluttershare/pages/create_account.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/search.dart';
import 'package:fluttershare/pages/timeline.dart';
import 'package:fluttershare/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn =GoogleSignIn();
final DateTime time=DateTime.now();
User userinfo;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userRef=Firestore.instance.collection('users');
  bool isAuth =false;
  int pageIndex=0;
  PageController pageController;
  @override
  initState(){
    super.initState();
    pageController=PageController(initialPage: 0);
    googleSignIn.onCurrentUserChanged.listen((account){
      handleSignin(account);
    }).onError((err){
      print('error occured $err');
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account){
      handleSignin(account);
    }).catchError((err){
       print('error occured $err');
    });
  }


createUserInFirebase()async {
  //check if the user alreay exixt in the database using their google id
final GoogleSignInAccount user= googleSignIn.currentUser;
 DocumentSnapshot doc= await userRef.document(user.id).get();
if(!doc.exists){
//if the user doesnot already exist then take them to the create user page
final username= await Navigator.push(context, MaterialPageRoute(builder:(context)=>CreateAccount()));
//get the user info and add that into database
await userRef.document(user.id).setData({
'id':user.id,
'username':username,
'photoUrl':user.photoUrl,
'email':user.email,
'displayName':user.displayName,
'timeStamp': time
});
 doc= await userRef.document(user.id).get();
}
 userinfo =User.fromDocument(doc);
 print(userinfo.email);
}
  handleSignin(GoogleSignInAccount account){
      if(account!= null){
            setState(() {
               createUserInFirebase();
              isAuth=true;
              });
            }
            else{
              setState(() {
              isAuth=false;
              });
            }
  }


  login()async{
   await googleSignIn.signIn();
   
  }
  logout()async{
   await googleSignIn.signOut();
  }
  onPageChanged(int lpageIndex){
    setState(() {
       this.pageIndex=lpageIndex;
       
    });   
  }
  onTap(int pageIndex){
   pageController.animateToPage(pageIndex,
   duration: Duration(milliseconds: 200),
   curve: Curves.easeInOut,
   );
  }
  Widget buildAuthPage(){
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
          RaisedButton(onPressed: (){
           logout();
           },
          child: Text('logout',textAlign: TextAlign.center,),
          ),
          ActivityFeed(),
          Upload(currentUser: userinfo),
          Search(),
          Profile()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.whatshot),title: Text('TImeline')),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active),title: Text('TImeline')),
            BottomNavigationBarItem(icon: Icon(Icons.photo_camera,size: 35,),title: Text('TImeline')),
            BottomNavigationBarItem(icon: Icon(Icons.search),title: Text('TImeline')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('TImeline'))
            ] 
        ),
    );
  }
  Scaffold buildnoAuthPage(){
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient:LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
        ]
            )
          ),
          alignment: Alignment.center,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            Text('FlutterShare',style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 90,
              color:Colors.white
            ),
            ),
            GestureDetector(
              onTap: (){
               login();
              },
              child: Container(
                height: 60,
                width: 260,
                decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage('assets/images/google_signin_button.png'),
                  fit: BoxFit.cover
                )
              ),)
            )
          ]
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return isAuth? buildAuthPage():buildnoAuthPage();
  }
}
