import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/Product.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/widgets/ProductItem.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
            create: (context) => products[i],
            child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
