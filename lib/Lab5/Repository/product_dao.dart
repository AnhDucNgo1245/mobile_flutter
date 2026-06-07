import 'package:flutter_prm/Lab5/Entity/product.dart';

class ProductDAO {
  // Danh sách giả lập 6 sản phẩm Minions với mô tả hài hước
  static final List<Product> _mockProducts = [
    Product(
      id: 'm1',
      name: 'Minion Bob Ngáo Ngơ',
      image: 'assets/images/Minions_poster.jpg',
      price: 99.99,
      description: 'Bob siêu lùn, siêu dễ thương và thích gấu bông Tim. Có xu hướng gọi mọi thứ là "Banana!" kể cả khi đó là một quả bom nổ chậm.',
    ),
    Product(
      id: 'm2',
      name: 'Stuart Độc Nhãn Nghệ Sĩ',
      image: 'assets/images/Minions_poster.jpg',
      price: 149.50,
      description: 'Chàng trai một mắt đam mê gảy đàn ukulele và luôn nghĩ mình là ngôi sao nhạc Rock thực thụ, dù nốt nhạc duy nhất gảy được là nốt... tịt.',
    ),
    Product(
      id: 'm3',
      name: 'Kevin Lãnh Đạo Nghiêm Túc',
      image: 'assets/images/Minions_poster.jpg',
      price: 199.99,
      description: 'Anh cả cao kều tự phong làm thủ lĩnh. Thích ra dáng người lớn nhưng thực chất chỉ muốn tìm một ác nhân bá đạo để... đi làm đầy tớ.',
    ),
    Product(
      id: 'm4',
      name: 'Otto Thích Nói Nhiều',
      image: 'assets/images/Minions_poster.jpg',
      price: 88.88,
      description: 'Thành viên mới đeo niềng răng, nói siêu nhiều và có khả năng đánh mất bảo vật quan trọng chỉ vì đổi lấy một hòn đá vẽ hình mặt cười.',
    ),
    Product(
      id: 'm5',
      name: 'Minion Đột Biến Tím Lịm',
      image: 'assets/images/Minions_poster.jpg',
      price: 299.00,
      description: 'Phiên bản Minion hóa điên sau khi tiêm huyết thanh PX-41. Tóc dựng ngược, màu tím hoa cà, ăn mọi thứ từ bàn ghế cho đến quả bom nguyên tử.',
    ),
    Product(
      id: 'm6',
      name: 'Banana Vàng Chói Lọi',
      image: 'assets/images/Minions_poster.jpg',
      price: 999.99,
      description: 'Quả chuối tối thượng - lẽ sống của toàn bộ gia tộc Minion. Bất cứ ai sở hữu quả chuối này sẽ nhận được sự phục tùng tuyệt đối (cho đến khi họ ăn mất nó).',
    ),
  ];

  // Lấy toàn bộ danh sách sản phẩm
  List<Product> getAllProducts() {
    return _mockProducts;
  }

  // Tìm kiếm sản phẩm theo ID
  Product? getProductById(String id) {
    try {
      return _mockProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  // Cập nhật trạng thái Like của sản phẩm
  void toggleLike(String id) {
    final product = getProductById(id);
    if (product != null) {
      product.isLiked = !product.isLiked;
    }
  }
}
