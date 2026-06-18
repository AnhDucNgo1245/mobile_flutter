import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_prm/ViewModel/cart_vm.dart';
import 'package:flutter_prm/ViewModel/product_vm.dart';

// CHỨC NĂNG: Hiển thị giỏ hàng và tương tác tăng/giảm số lượng, thanh toán.
// LÝ DO DÙNG CONSUMERWIDGET: Để lắng nghe thay đổi danh sách giỏ hàng và tổng tiền qua Riverpod.
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch danh sách sản phẩm trong giỏ hàng
    final cartItems = ref.watch(cartProvider);
    // Watch tổng tiền thanh toán (tự động cập nhật nhờ Riverpod)
    final double totalPrice = ref.watch(cartTotalPriceProvider);
    final dao = ref.watch(productDAOProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000080), // Màu Navy
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Giỏ hàng đang trống",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Danh sách sản phẩm trong giỏ hàng
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final double discountedPrice = dao.calculateDiscountedPrice(item.product);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Ảnh sản phẩm
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[100],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item.product.image.startsWith('http')
                                      ? Image.network(
                                          item.product.image,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.asset(
                                          item.product.image,
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Thông tin và bộ tăng giảm số lượng
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${discountedPrice.toStringAsFixed(1)}\$',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Bộ điều chỉnh tăng/giảm số lượng
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).decrementQuantity(item.product);
                                          },
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).incrementQuantity(item.product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Nút xóa sản phẩm khỏi giỏ
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () {
                                  ref.read(cartProvider.notifier).removeFromCart(item.product);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Phần tổng tiền và nút thanh toán dưới cùng
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(76),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount:",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${totalPrice.toStringAsFixed(2)}\$',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Nút thanh toán màu Navy
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
                            ref.read(cartProvider.notifier).clearCart();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Thành công"),
                                content: const Text("Cảm ơn bạn đã mua sắm! Đơn hàng đang được xử lý."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            "Checkout",
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
              ],
            ),
    );
  }
}
