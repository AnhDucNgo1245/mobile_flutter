import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_prm/Entity/product.dart';
import 'package:flutter_prm/Repository/product_dao.dart';

// ĐỐI CHIẾU: Trước đây sử dụng Class ProductService truyền thống.
// GIỜ ĐÂY: Dùng Riverpod Providers để quản lý State và Business Logic một cách Reactive.

// 1. productDAOProvider
// CHỨC NĂNG: Cung cấp đối tượng DAO để truy cập dữ liệu thô.
// LỰA CHỌN: Sử dụng 'Provider' thông thường (Read-only) vì DAO chỉ chứa các hàm tiện ích tĩnh và danh sách mẫu không đổi, không cần quan sát sự thay đổi trạng thái của chính DAO này.
final productDAOProvider = Provider<ProductDAO>((ref) {
  return ProductDAO();
});

// 2. productListProvider
// CHỨC NĂNG: Cung cấp toàn bộ danh sách sản phẩm từ Repository.
// LỰA CHỌN: Sử dụng 'Provider' vì danh sách sản phẩm mẫu là cố định. Khi cần lấy dữ liệu, các Widget chỉ cần `ref.watch(productListProvider)`.
final productListProvider = Provider<List<Product>>((ref) {
  final dao = ref.watch(productDAOProvider);
  return dao.getAllProducts();
});

// 3. searchQueryProvider
// CHỨC NĂNG: Quản lý từ khóa tìm kiếm (search query) nhập vào từ TextField.
// LỰA CHỌN: Sử dụng 'StateProvider' (kiểu String) vì trạng thái tìm kiếm chỉ là một giá trị đơn giản (String), thay đổi thường xuyên khi người dùng gõ phím.
// CÁCH DÙNG: Cập nhật bằng `ref.read(searchQueryProvider.notifier).state = value;` và quan sát bằng `ref.watch(searchQueryProvider)`.
final searchQueryProvider = StateProvider<String>((ref) => "");

// 4. selectedProductProvider
// CHỨC NĂNG: Lưu trữ thông tin sản phẩm đang được chọn để xem chi tiết.
// LỰA CHỌN: Sử dụng 'StateProvider<Product?>' để quản lý trạng thái chọn sản phẩm hiện tại.
// LÝ DO: Khi người dùng nhấp vào một thẻ sản phẩm trong danh sách:
//   - Ta ghi đè giá trị: `ref.read(selectedProductProvider.notifier).state = product;`
//   - Sau đó chuyển trang. Tại `ProductDetail`, chỉ cần `ref.watch(selectedProductProvider)` để lấy thông tin trực tiếp từ Provider mà không cần truyền tham số qua Constructor của Widget.
final selectedProductProvider = StateProvider<Product?>((ref) => null);
