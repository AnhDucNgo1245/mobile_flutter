import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_prm/Entity/product.dart';
import 'package:flutter_prm/ViewModel/product_vm.dart';
import 'package:flutter_prm/ViewModel/cart_vm.dart';

// ĐỐI CHIẾU CŨ:
// class ProductDetail extends StatefulWidget {
//   final Product product;
//   const ProductDetail({super.key, required this.product});
//   ...
// }
//
// ĐỐI CHIẾU MỚI (RIVERPOD):
// Sử dụng ConsumerWidget để lắng nghe sự thay đổi của selectedProductProvider.
// Không cần nhận đối tượng Product từ constructor nữa, lấy trực tiếp từ Provider.
class ProductDetail extends ConsumerWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TRUY XUẤT NỘI DUNG TRỰC TIẾP TỪ PROVIDER
    // Lấy thông tin sản phẩm được chọn từ selectedProductProvider
    final Product? product = ref.watch(selectedProductProvider);
    final dao = ref.watch(productDAOProvider);

    // Xử lý an toàn nếu chưa chọn sản phẩm nào (đề phòng)
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Chi tiết")),
        body: const Center(child: Text("Không có sản phẩm nào được chọn.")),
      );
    }

    final double discountedPrice = dao.calculateDiscountedPrice(product);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000080), // Màu Navy
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Quay về trang home
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ảnh sản phẩm hiển thị toàn bộ không bị che khuất
            Center(
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product.image.startsWith('http')
                      ? Image.network(
                          product.image,
                          fit: BoxFit.contain, // Hiển thị toàn bộ ảnh
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 80, color: Colors.grey);
                          },
                        )
                      : Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 80, color: Colors.grey);
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Tên, giá gốc, giá sau khi giảm và % discount hiển thị trên cùng 1 hàng
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tên sản phẩm
                Expanded(
                  flex: 3,
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                // Giá gốc (gạch ngang) và giá sau giảm
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(0)}\$',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '${discountedPrice.toStringAsFixed(1)}\$',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                // % discount
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '-${product.discountPercent}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Mô tả
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.des,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),

            // 4. Nút Add to Cart màu Navy
            // Khi nhấn nút, ta gọi CartNotifier của Riverpod để thêm sản phẩm vào giỏ hàng
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000080), // Màu Navy
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Gọi CartNotifier thông qua provider để thêm sản phẩm
                  ref.read(cartProvider.notifier).addToCart(product);

                  // Hiển thị thông báo nhẹ nhàng dưới góc màn hình
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã thêm ${product.name} vào giỏ hàng!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
