import 'package:flutter_prm/Lab5/Entity/product.dart';
import 'package:flutter_prm/Lab5/Repository/product_dao.dart';

class ProductService {
  // Singleton pattern để chia sẻ trạng thái giữa các màn hình dễ dàng
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  final ProductDAO _productDAO = ProductDAO();

  // Sản phẩm hiện tại đang được chọn để xem chi tiết
  Product? _selectedProduct;

  // Lấy toàn bộ sản phẩm từ DAO
  List<Product> getProducts() {
    return _productDAO.getAllProducts();
  }

  // Lấy sản phẩm đang chọn
  Product? getSelectedProduct() {
    // Nếu chưa chọn sản phẩm nào, mặc định trả về sản phẩm đầu tiên để tránh lỗi giao diện
    _selectedProduct ??= _productDAO.getAllProducts().first;
    return _selectedProduct;
  }

  // Cập nhật sản phẩm đang chọn
  void selectProduct(Product product) {
    _selectedProduct = product;
  }

  // Thay đổi trạng thái Like
  void toggleLike(String id) {
    _productDAO.toggleLike(id);
  }
}
