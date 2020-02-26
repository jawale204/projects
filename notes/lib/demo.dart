import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Demo extends StatefulWidget {
  static String id='demo'; 
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  rah()async{
  var databasePath=await getDatabasesPath();
  String path=join(databasePath,'demo.db');
  Database database= await openDatabase(path,version: 1,onCreate: (Database db,int version)async {
    db.execute('CREATE TABLE test (URL TEXT PRIMARY KEY, name TEXT, value TEXT, num REAL)');
    
  });
//   await database.transaction((txn)async{
//     int a=await txn.rawInsert('INSERT INTO test(URL,name,value,num)VALUES("r","rahul","rahul",5676)');
//     print(a);
//  return;
//   });
int counts = await database.rawUpdate(
    'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
    ['updated name', '9876', 'some name']);

int count= await database.rawUpdate('UPDATE test SET name = ?, value = ?,WHERE URL = ?', ['rah','rahul','r']);

print('updated: $count');












 return 'jgj';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(rah()),
    );
  }
}