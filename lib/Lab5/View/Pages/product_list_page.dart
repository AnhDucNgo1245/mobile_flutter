import 'package:flutter/material.dart';
import 'package:flutter_prm/Lab5/Entity/product.dart';
import 'package:flutter_prm/Lab5/ViewModel/product_service.dart';
import 'package:flutter_prm/Lab5/View/Pages/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final List<Product> products = _productService.getProducts();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Đo chiều rộng khả dụng của container
        final double width = constraints.maxWidth;

        // Tính toán số cột tương thích
        int crossAxisCount = 1;
        if (width >= 1000) {
          crossAxisCount = 3;
        } else if (width >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        // Tỷ lệ aspect ratio để card hiển thị cân đối
        final double cardWidth = width / crossAxisCount;
        final double childAspectRatio = cardWidth / 420;

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
            final product = products[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Cập nhật sản phẩm được lựa chọn trong ViewModel
                  _productService.selectProduct(product);
                  // Điều hướng trực tiếp sang trang chi tiết
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  ).then((_) {
                    // Cập nhật lại giao diện khi quay lại (nếu có thay đổi trạng thái Like)
                    setState(() {});
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ảnh sản phẩm Minion
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          product.image,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Tên và giá sản phẩm
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${product.price.toStringAsFixed(2)}\$',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  product.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                                  color: product.isLiked ? Colors.yellow : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _productService.toggleLike(product.id);
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
