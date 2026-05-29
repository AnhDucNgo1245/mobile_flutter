import 'package:flutter/material.dart';
import 'package:flutter_prm/View/Widgets/product_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ProductWidget(),
        );
      },
    );
  }
}
