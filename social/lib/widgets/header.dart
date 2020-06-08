import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText,bool leading=false}) {
  return AppBar(
    automaticallyImplyLeading: leading? true:false,
    title: Text(
      isAppTitle ? "FlutterShare" : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "Signatra" : "",
        fontSize: isAppTitle ? 50.0 : 22.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}