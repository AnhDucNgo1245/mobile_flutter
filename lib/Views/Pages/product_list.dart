  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_prm/Entity/product.dart';
import 'package:flutter_prm/ViewModel/product_vm.dart';
import 'package:flutter_prm/Views/Pages/product_detail.dart';

// ĐỐI CHIẾU CŨ:
// class ProductListWidget extends StatefulWidget {
//   final String searchQuery;
//   const ProductListWidget({super.key, required this.searchQuery});
//   ...
// }
//
// ĐỐI CHIẾU MỚI (RIVERPOD):
// Chúng ta chuyển thành ConsumerWidget để có thể đọc trực tiếp các Provider của Riverpod
// qua đối tượng `WidgetRef ref` mà không cần truyền biến trung gian qua constructor.
class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TRUY XUẤT NỘI DUNG TRỰC TIẾP TỪ PROVIDER
    // Watch danh sách sản phẩm từ provider thay vì gọi qua database/service thủ công
    final List<Product> allProducts = ref.watch(productListProvider);
    // Watch từ khóa tìm kiếm trực tiếp từ Provider thay vì truyền qua widget cha
    final String searchQuery = ref.watch(searchQueryProvider);

    // Lọc danh sách theo từ khóa tìm kiếm
    final List<Product> products = allProducts.where((p) {
      return p.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // Lấy đối tượng DAO thông qua Provider để tính toán giá trị đã giảm
    final dao = ref.watch(productDAOProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

        // Tính toán số cột (crossAxisCount) theo yêu cầu:
        // - Chiều rộng <= 500: thẳng đứng -> 1 cột, nằm ngang -> 2 cột
        // - Chiều rộng > 500: thẳng đứng -> 2 cột, nằm ngang -> 3 cột
        int crossAxisCount = 1;
        if (width <= 500) {
          crossAxisCount = isLandscape ? 2 : 1;
        } else {
          crossAxisCount = isLandscape ? 3 : 2;
        }

        if (products.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Không tìm thấy sản phẩm nào",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Nằm trong SingleChildScrollView của HomePage
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: 130.0, // Chiều cao cố định của mỗi card để tránh tràn chữ
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final double discountedPrice = dao.calculateDiscountedPrice(product);

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      // TRUYỀN THÔNG TIN QUA PROVIDER
                      // Thay vì truyền Product qua Constructor của ProductDetail, ta lưu nó vào selectedProductProvider
                      ref.read(selectedProductProvider.notifier).state = product;

                      // Thực hiện điều hướng sang trang ProductDetail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductDetail(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Ảnh sản phẩm (hiển thị trọn vẹn)
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: product.image.startsWith('http')
                                  ? Image.network(
                                      product.image,
                                      fit: BoxFit.contain, // Hiển thị toàn bộ ảnh
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image, size: 50, color: Colors.grey);
                                      },
                                    )
                                  : Image.asset(
                                      product.image,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image, size: 50, color: Colors.grey);
                                      },
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Thông tin chi tiết
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Giá gốc gạch ngang
                                    Text(
                                      '${product.price.toStringAsFixed(0)}\$',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    // Giá sau giảm
                                    Text(
                                      '${discountedPrice.toStringAsFixed(1)}\$',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Góc trên bên phải hiển thị % giảm giá
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        '-${product.discountPercent}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
