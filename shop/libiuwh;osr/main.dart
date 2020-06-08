import 'package:flutter/material.dart';
import 'package:shop/screens/Productdetailscreen.dart';
import 'package:shop/screens/ProduvtOverviewScreen.dart';
import 'package:provider/provider.dart';

import 'provider/product_provider.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> Products(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orangeAccent
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName:(context)=> ProductDetailScreen()
        },
      ),
    );
  }
}

