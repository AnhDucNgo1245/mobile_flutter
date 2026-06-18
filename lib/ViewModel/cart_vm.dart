import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_prm/Entity/product.dart';
import 'package:flutter_prm/Repository/product_dao.dart';

// Model đại diện cho một phần tử trong Giỏ hàng
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// 1. CartNotifier
// CHỨC NĂNG: Quản lý logic nghiệp vụ và thay đổi trạng thái của danh sách CartItem.
// CÁCH HOẠT ĐỘNG: Kế thừa StateNotifier để quản lý một danh sách không thay đổi trực tiếp (immutable state).
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  // Thêm sản phẩm vào giỏ hàng
  void addToCart(Product product) {
    // Tìm xem sản phẩm đã có trong giỏ hàng chưa
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // Nếu có rồi, tăng số lượng lên 1
      state[index].quantity += 1;
      state = [...state]; // Gán lại danh sách để kích hoạt rebuild widget
    } else {
      // Nếu chưa có, thêm mới CartItem
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  // Tăng số lượng sản phẩm trong giỏ hàng
  void incrementQuantity(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      state[index].quantity += 1;
      state = [...state];
    }
  }

  // Giảm số lượng sản phẩm trong giỏ hàng
  void decrementQuantity(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (state[index].quantity > 1) {
        state[index].quantity -= 1;
        state = [...state];
      } else {
        // Nếu số lượng giảm về 0, tiến hành xóa khỏi giỏ
        removeFromCart(product);
      }
    }
  }

  // Làm trống giỏ hàng sau khi mua hàng thành công
  void clearCart() {
    state = [];
  }
}

// 2. cartProvider
// LỰA CHỌN: StateNotifierProvider
// LÝ DO: Đây là sự lựa chọn phù hợp nhất cho các trạng thái phức tạp (danh sách đối tượng chứa các hàm thay đổi số lượng, thêm mới, xóa bỏ).
// Cách gọi:
//   - Đọc danh sách: `ref.watch(cartProvider)`
//   - Gọi hàm xử lý: `ref.read(cartProvider.notifier).addToCart(product)`
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// 3. cartTotalPriceProvider
// LỰA CHỌN: Provider thông thường phụ thuộc vào một Provider khác.
// LÝ DO: Tính toán tổng giá trị giỏ hàng bằng cách xem sự thay đổi (watch) của `cartProvider`.
// Bất cứ khi nào số lượng hoặc danh sách sản phẩm trong giỏ hàng thay đổi, tổng số tiền tự động tính lại.
final cartTotalPriceProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  final dao = ProductDAO();
  
  double total = 0.0;
  for (var item in cartItems) {
    final discountedPrice = dao.calculateDiscountedPrice(item.product);
    total += discountedPrice * item.quantity;
  }
  return total;
});

// 4. cartTotalCountProvider
// LỰA CHỌN: Provider thông thường.
// LÝ DO: Tính toán tổng số lượng sản phẩm có trong giỏ hàng để hiển thị huy hiệu (badge) số lượng trên Tab bar hoặc giỏ hàng.
final cartTotalCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});
