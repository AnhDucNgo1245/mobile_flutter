import 'package:flutter/material.dart';
import 'package:flutter_prm/View/Widgets/product_widget.dart';
import 'package:flutter_prm/product.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final List<Product> products = Product.list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ProductWidget(product: products[index]),
        );
      },
    );
  }
}
