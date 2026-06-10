import 'package:flutter/material.dart';
import 'package:flutter_prm/Views/Widgets/product_widget.dart';
import 'package:flutter_prm/product.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final List<Product> products = Product.list;

  @override
  Widget build(BuildContext context) {
    // Bước 1: Lấy chiều rộng màn hình hiện tại sử dụng MediaQuery
    // final double screenWidth = MediaQuery.of(context).size.width;

    // // Bước 2: Xác định số cột hiển thị (crossAxisCount) dựa trên chiều rộng màn hình để responsive
    // int crossAxisCount = 1;
    // if (screenWidth >= 1000) {
    //   crossAxisCount = 3; // Màn hình lớn (Desktop / Web rộng) -> hiển thị 3 cột
    // } else if (screenWidth >= 600) {
    //   crossAxisCount = 2; // Màn hình trung bình (Tablet) -> hiển thị 2 cột
    // } else {
    //   crossAxisCount = 1; // Màn hình nhỏ (Mobile) -> hiển thị 1 cột
    // }

    // // Bước 3: Tính toán tỷ lệ childAspectRatio để bảo toàn chiều cao mong muốn (500) của ProductWidget
    // final double cardWidth = screenWidth / crossAxisCount;
    // final double childAspectRatio = cardWidth / 500;

    // // Bước 4: Trả về GridView.builder giúp cuộn mượt mà và tiết kiệm tài nguyên
    // return GridView.builder(
    //   padding: const EdgeInsets.all(16.0),
    //   itemCount: products.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: crossAxisCount,
    //     childAspectRatio: childAspectRatio,
    //     crossAxisSpacing: 16.0,
    //     mainAxisSpacing: 16.0,
    //   ),
    //   itemBuilder: (context, index) {
    //     return ProductWidget(product: products[index]);
    //   },
    // );

    // Responsive bằng LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        int crossAxisCount = 1;
        if (screenWidth >= 1000) {
          crossAxisCount = 3;
        } else if (screenWidth >= 600) {
          crossAxisCount = 2;
        }
        final double cardWidth = screenWidth / crossAxisCount;
        final double childAspectRatio = cardWidth / 500;
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) {
            return ProductWidget(product: products[index]);
          },
        );
      },
    );
  }
}
