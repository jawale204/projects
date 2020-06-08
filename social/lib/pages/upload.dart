import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
 final User currentUser;
  Upload({this.currentUser});
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;
  takePhoto()async{
    Navigator.pop(context);
    File file=await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.file=file;
    });
  }
  selectFromGallery()async{
    Navigator.pop(context);
   File file=await ImagePicker.pickImage(source: ImageSource.gallery);
   setState(() {
      this.file=file;
    });
  }
 uploadTypeOption(parentContext){
    return showDialog(
      context: parentContext,
      builder: (context){
        return  SimpleDialog(
        title:Text('Create Post'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: ()async  { 
              await takePhoto();
             },
            child:  Text('Take a Photo'),
          ),
          SimpleDialogOption(
            onPressed: () async{ 
             await selectFromGallery();
             },
            child:  Text('Select from Gallery'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context); },
            child:  Text('Cancel'),
          ),
        ],
      );
      }
      );
  }


  Container buildSplashScreen(){
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/images/upload.svg',
          height: 260,
          width: 260,
          alignment:Alignment.center,
          ),
          Padding(padding: 
          EdgeInsets.only(top: 20),
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
            color: Colors.purple,
            onPressed: (){
              uploadTypeOption(context);
            } ,
            child: Text('Upload Photo',
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),) ,
            )
            ),
        ]      
        ),
    );
  }
 Scaffold buildUploadForm(){
    return Scaffold(
      appBar: AppBar(
        title:Text('Caption Post',style:TextStyle(color: Colors.white,
        fontSize: 20
        ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          setState(() {
            file=null;
          });
        }),
        actions: <Widget>[
          FlatButton(
            onPressed: (){},
            child: Text('Post',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color:Colors.white),),

            )
        ],
      ),
      body: ListView(
        children:<Widget> [
          Container(
              height: 220,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child:Container(
              decoration: BoxDecoration(
              image:DecorationImage(
                fit:BoxFit.contain,
                image: FileImage(file)
                )
            ),
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top:10)),
          ListTile(
            leading:CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl)
              ,backgroundColor: Colors.grey,
              ),
              title: TextFormField(decoration: InputDecoration(
                hintText: 'Write a Caption'
              ),),
               ),
              ListTile(
            leading:Icon(Icons.pin_drop,size: 40,color: Colors.orange,),
              title: TextFormField(decoration: InputDecoration(
                hintText: 'Add Location'
              ),),
               ),  
               Divider(),
               Container(
               height: 40,
               width: 70,
               alignment: Alignment.center,
                 child: RaisedButton.icon(
                   icon: Icon(Icons.my_location),
                   onPressed: (){},
                   color: Colors.blue,
                   label: Text('Use current location',style: TextStyle(color:Colors.white),),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                   )
               )
        ]
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return file==null ?buildSplashScreen():buildUploadForm();
}
}