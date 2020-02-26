import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/constants.dart';
import 'package:notes/reset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/signup.dart';

class Mainpage extends StatefulWidget {
  static String id='Mainpage';
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  String _password,_domain,_id;
  List<String> _list=[];
  String nameKey ='_key_name';
@override
void initState(){
  super.initState();
  const MethodChannel('plugins.flutter.io/shareed_preferences')
  .setMethodCallHandler(
    (MethodCall methodCall)async{
      if(methodCall.method=='getAll'){
        return{'flutter.' +nameKey:'[no name saved]'};
      }
      return null;
    });
  setData();
}
@override
void dispose(){
   SystemNavigator.pop();
   saveData();

  super.dispose();
}
 Future<bool> saveData() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return await preferences.setStringList(nameKey,_list);
 }
 Future<List> loadData() async {
  SharedPreferences preferences= await SharedPreferences.getInstance();
  return preferences.getStringList(nameKey);
 }
 setData()async{
  await loadData().then(
     (value){
       setState((){
         print(value);
         _list=[];
         for (var i in value){
           _list.add(i.toString());
         }
       });
     });
 }
 password(int index){
  List b=_list[index].split('/2610/');
  return b[1];
 } 
 userId(int index){
  List b=_list[index].split('/2610/');
  return b[2];
 } 
 domain(int index){
  List b=_list[index].split('/2610/');
  return b[0];
 }
 Future createAlertDialogue(BuildContext context){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('New field'),
            content: Container(
              width: 250,
              height: 170,
                 child: Column(              
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               TextField(                  
              onChanged: (value){
                _domain=value;
                print(_domain);
              },
              decoration: KTextDecoration.copyWith(hintText: 'Enter domain name',hintStyle: TextStyle(color: Colors.black54))
                 ),
              SizedBox(
              height: 5,
             ),
              TextField(
              onChanged: (value){
                _password=value;
                print(_password);
              },
              decoration: KTextDecoration.copyWith(hintText: 'Enter User Id',hintStyle: TextStyle(color: Colors.black54))
                 ),
                 SizedBox(
              height: 5,
             ),
                 TextField(
              obscureText: true,
              onChanged: (value){
                _id=value;
                print(_id);
              },
              decoration: KTextDecoration.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.black54))
                 )
               ],
              ),
            ),
             actions: <Widget>[
              SaveButton(
                onpress: (){
                   String a =_domain+"/2610/"+_password+"/2610/"+_id;
                   Navigator.pop(context);
                  _list.add(a);
                   saveData();
                   setData();
                },
                txt: 'Save',
              ),
            ],
          );
        } 
      );
    }
  Future createalertDialogue(BuildContext context,int index){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Delete the Field'),
        content: const Text(
            'The selected field will be deleted permanently'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('DELETE'),
            onPressed: () {
              setState(() {
                _list.removeAt(index); 
              });
              Navigator.of(context).pop();
             },
          )
        ],
          );
        
        } 
      );
    }
     _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}){
        return ListTile(
          title: Row(
            children: <Widget>[
              Icon(icon),
              SizedBox(
                width: 20,
              ),
              Text(text),
            ],
          ),
          onTap: onTap,
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
            ),
            _createDrawerItem(icon:Icons.autorenew,text: 'Reset Password',onTap: (){
              Navigator.pushNamed(context, Reset.id);
            }),
             _createDrawerItem(icon:Icons.share,text: 'Share app',onTap: (){
            }),
          ],
        ),),
      appBar: AppBar(title: Text('Passwords'),
      
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.add_circle),
           onPressed: ()async{
           await createAlertDialogue(context);
           },
         ),
       ],
      ),
      body: ListView.builder(
       itemCount: _list.length ,
       itemBuilder: (context,index){   
         return GestureDetector(
           onTap: (){
             createalertDialogue(context,index);
             },
            child: Container(
             width: 250,
             height: 90,
             margin: EdgeInsets.all(15.0),
             decoration: BoxDecoration(
             color: Colors.grey[300],
             borderRadius: BorderRadius.circular(10.0),),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Domain :',style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500]
                      ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(domain(index),style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                       
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('User Id :',style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500]
                      ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(userId(index),style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                       
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Password :',style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500]
                    ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(password(index),style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                     
                  ],
                ),
             ],
            ),
             ),
           ),
         );
       },
      ),
    );
  }
}