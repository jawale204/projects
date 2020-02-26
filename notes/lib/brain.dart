import 'package:shared_preferences/shared_preferences.dart';

class Brain{

  String pass='pass';
  static String _MainPassword;
 Future<bool> saveData()async {
  SharedPreferences preferences= await SharedPreferences.getInstance();
  return await preferences.setString(pass,_MainPassword);
  }
  Future<String> loadData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(pass);
  }
 Future setData()async{
   await loadData().then((value)
   {   print(value);   
      _MainPassword=value;
   });
 }
 are(){
   setData();
   return _MainPassword;
 }
  ok(String p){
    _set(p);
  }
  oh(p){
  return _check(p);
  }
  _set(String p ){
    _MainPassword=p;
    saveData();
  }
 Future<dynamic>_check(p)async{
  await setData();
    if(_MainPassword==null){
      return 2;
    }
    if(_MainPassword==p){
      return 1;
      }
    if(_MainPassword!=p){
      return(0);
    }
  } 
   bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
}