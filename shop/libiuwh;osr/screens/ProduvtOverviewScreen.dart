import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product_provider.dart';

import 'package:shop/widgets/productGrid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  return ChangeNotifierProvider(
    create: (context)=>Products(),
      child: Scaffold(
        appBar: AppBar(
          title:Text('Products'),
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_){
               return [ 
                 PopupMenuItem(child: Text('Favourite')),
                   PopupMenuItem(child: Text('Favourite'))
                 
                 ];
              })
          ],),
        body: ProductGrid()
      ),
  );
  }
}

