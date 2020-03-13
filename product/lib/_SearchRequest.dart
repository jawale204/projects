import 'package:http/http.dart'as http;
import 'dart:convert';
SearchRequest(String productName,int index) async{
    var names=['amazon','flipkart','myntra','shopclues'];
    String url="http://192.168.0.104:5000/"+names[index]+"?name=";
   http.Response response=await http.get(url+productName);
   if (response.statusCode==200){
          String data=response.body;
          return (data);
    }
     else{
      print(response.statusCode);
     }
}
