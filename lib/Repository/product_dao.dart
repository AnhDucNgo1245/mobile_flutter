import 'package:flutter_prm/Entity/product.dart';

class ProductDAO {
  static final List<Product> productList = [
    Product(
      id: 'i1',
      name: 'iPhone 15 Pro Max',
      des: 'Experience the latest technology with the new iPhone 15 Pro Max. Stunning titanium design, powerful A17 Pro performance.',
      price: 1099,
      discountPercent: 10,
      image: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/517/334/products/ip-15-pro-max-mhm-xanh-9a4ac8db5bb34883956fc0704320830f-grande-f3c2eec1-29c9-4d80-804d-95b2dd812f46.jpg?v=1716308540803',
    ),
    Product(
      id: 's1',
      name: 'Samsung S24 Ultra',
      des: 'Experience the latest AI technology with the new Samsung Galaxy S24 Ultra. Stunning display, superior camera performance.',
      price: 999,
      discountPercent: 15,
      image: 'https://phucanhcdn.com/media/product/54244_dien_thoai_thong_minh_samsung_galaxy_s24_ultra_den_6.jpg',
    ),
    Product(
      id: 'm1',
      name: 'MacBook Air M3',
      des: 'Experience the latest technology with the new MacBook Air M3. Stunning thin design, all-day battery life, and powerful speed.',
      price: 1299,
      discountPercent: 8,
      image: 'https://cdn-v2.didongviet.vn/files/media/catalog/product/m/a/macbook-air-bac_1.jpg',
    ),
    Product(
      id: 'mb1',
      name: 'Minion Bob Ngáo Ngơ',
      des: 'Bob siêu lùn, siêu dễ thương và thích gấu bông Tim. Có xu hướng gọi mọi thứ là "Banana!" kể cả khi đó là một quả bom nổ chậm.',
      price: 99.99,
      discountPercent: 20,
      image: 'assets/images/Minions_poster.jpg',
    ),
    Product(
      id: 'ms1',
      name: 'Stuart Độc Nhãn Nghệ Sĩ',
      des: 'Chàng trai một mắt đam mê gảy đàn ukulele và luôn nghĩ mình là ngôi sao nhạc Rock thực thụ, dù nốt nhạc duy nhất gảy được là nốt... tịt.',
      price: 149.50,
      discountPercent: 12,
      image: 'assets/images/Minions_poster.jpg',
    ),
    Product(
      id: 'mk1',
      name: 'Kevin Lãnh Đạo Nghiêm Túc',
      des: 'Anh cả cao kều tự phong làm thủ lĩnh. Thích ra dáng người lớn nhưng thực chất chỉ muốn tìm một ác nhân bá đạo để... đi làm đầy tớ.',
      price: 199.99,
      discountPercent: 10,
      image: 'assets/images/Minions_poster.jpg',
    ),
  ];

  List<Product> getAllProducts() => productList;

  Product findProductById(String id) =>
      productList.firstWhere((e) => e.id == id);

  double calculateDiscountedPrice(Product p) =>
      p.price - p.price * p.discountPercent / 100;
}
