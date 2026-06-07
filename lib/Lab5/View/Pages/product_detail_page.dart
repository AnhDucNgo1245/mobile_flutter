import 'package:flutter/material.dart';
import 'package:flutter_prm/Lab5/Entity/product.dart';
import 'package:flutter_prm/Lab5/ViewModel/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm lớn ở phía trên
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset(
                    product.image,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.amber,
                      icon: const Icon(Icons.shopping_cart, color: Colors.black),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên sản phẩm và nút Like
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          product.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          color: product.isLiked ? Colors.yellow : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _productService.toggleLike(product.id);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Giá sản phẩm
                  Text(
                    'Price: ${product.price.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tiêu đề Mô tả
                  const Text(
                    "Mô tả sản phẩm:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Nội dung mô tả hài hước
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
