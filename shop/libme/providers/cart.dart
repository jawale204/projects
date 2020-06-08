import 'package:flutter/material.dart';



class CartItem{
  final String id;
  final double price;
  final String title;
  final int quantity;
  CartItem({@required this.id,@required this.price,@required this.quantity,@required this.title});
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items={};

  Map<String,CartItem> get tellItems{
      return {..._items};
  }

  int get itemcount{
    return _items.length;
  }
  void addItem(String productId,double price,String title){
      if(_items.containsKey(productId)){
          _items.update(productId, (item) =>CartItem(price: item.price, title: item.title, id: item.id,quantity:item.quantity+1));
         notifyListeners();
      }
      else{
        _items.putIfAbsent(productId, () => CartItem(id: DateTime.now().toString(), price: price, quantity: 1, title: title));
         notifyListeners();
      }
     
  }
}