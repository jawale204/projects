import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/Product.dart';

import 'package:shop/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName='/productdetailscreen';
  @override
  Widget build(BuildContext context) {
   final productId=ModalRoute.of(context).settings.arguments as String;
  Product finalProduct= Provider.of<Products>(context,listen:false).searchById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(finalProduct.title)
      ),
    );
  }
}