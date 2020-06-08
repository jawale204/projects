

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/Product.dart';
import 'package:shop/screens/Productdetailscreen.dart';

class ProductItem extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    Product singlePro=Provider.of<Product>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
      child: GridTile(
      child: Image.network(singlePro.imageUrl,fit: BoxFit.cover),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title:Text(singlePro.title),
        leading: Consumer<Product>(
          builder: (context,product,child)=> IconButton(
              icon: Icon(singlePro.favourite?Icons.favorite:Icons.favorite_border,color: Theme.of(context).accentColor,),
              onPressed: (){
                singlePro.changeFavourateStatus();
              }),
        ),
        trailing: IconButton(icon: Icon(Icons.shopping_cart,color: Theme.of(context).accentColor), onPressed: (){

        }),
      ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: singlePro.id);
      },
          ),
    );
  }
}