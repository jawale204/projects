import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool favourite;

  Product({@required this.id,
@required this.description,this.favourite=false,@required this.imageUrl,@required this.price,@required this.title});
  void changeFavourateStatus(){
   favourite=!favourite;
   notifyListeners();
  }
}