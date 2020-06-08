import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class OfflineUser {

  int islogged=0;
  String email='';

  OfflineUser(this.islogged,this.email);

}

class DataBaseHelper {
 String tableName='User';
 String colislogged='islogged';
 String colemail='email';
 Database _database;


  static DataBaseHelper _databasehelper;
  factory DataBaseHelper(){
    if(_databasehelper==null){
        _databasehelper=DataBaseHelper._createInstance();
    }
   return _databasehelper;
  }
  DataBaseHelper._createInstance();

  Future<Database>get database async{
    if(_database==null){
      _database=await initializeDatabase();
    }
    return _database;
  }

Future<Database> initializeDatabase()async{
      Directory directory=await getApplicationDocumentsDirectory();
      String path=directory.path+'Expense.db';
      var database =openDatabase(path,version:1,onCreate:_createdb);
      return database;
  }

  void _createdb(Database db,int version)async{
      await db.execute('CREATE TABLE $tableName($colemail TEXT PRIMARY KEY,$colislogged INTEGER)');
  }

 Future<List<Map<String,dynamic>>> getnoteMap()async{
    Database db=await this.database;
    var result =db.query(tableName);
    return result;
  }


	Future<int> insertNote(OfflineUser offlineUser) async {
		Database db = await this.database;
    var a={'email':offlineUser.email,'islogged':offlineUser.islogged};
		var result = await db.insert(tableName,a);
		return result;
	}

	Future<int> deleteNote(OfflineUser offlineUser) async {
		var db = await this.database;
    var a={'email':offlineUser.email,'islogged':offlineUser.islogged};
		int result = await db.delete(tableName);
		return result;
	}
}