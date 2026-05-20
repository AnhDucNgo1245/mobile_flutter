class Product {
  final String id;
  final String name;
  final String image;
  final double price;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // copyWith method to help with immutable edits
  Product copyWith({String? id, String? name, String? image, double? price}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  // Factory constructor to map JSON to Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  // Convert Product to JSON map (optional but useful)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }

  // Static list of products with default values
  static List<Product> list = [
    Product(
      id: 'p1',
      name: 'iPhone 15 Pro Max',
      image:
          'https://cdsassets.apple.com/live/7WUAS350/images/tech-specs/iphone-15-pro-max.png',
      price: 1299.00,
    ),
    Product(
      id: 'p2',
      name: 'MacBook Pro M3',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9PQMhK6nSNKIuDfT4NDBpkWmwFDFeqUGe_w&s',
      price: 1999.00,
    ),
    Product(
      id: 'p3',
      name: 'iPad Pro M2',
      image:
          'https://product.hstatic.net/1000259254/product/ipad_pro_m2_11_inch_wi-fi_space_gray-1_cc15575572d944f0bd998a380eff74a3_grande.jpg',
      price: 799.00,
    ),
    Product(
      id: 'p4',
      name: 'Apple Watch Ultra 2',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdJqkgvkAEjxGnYuthA7jqk4kOShvg59SVMA&s',
      price: 799.00,
    ),
    Product(
      id: 'p5',
      name: 'AirPods Pro 2',
      image:
          'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111851_sp880-airpods-Pro-2nd-gen.png',
      price: 249.00,
    ),
  ];

  // Method to add a product
  static void add(Product product) {
    list.add(product);
  }

  // Method to edit a product
  static bool edit(Product updatedProduct) {
    final index = list.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      list[index] = updatedProduct;
      return true;
    }
    return false;
  }

  // Method to find a product by ID
  static Product? find(String id) {
    try {
      return list.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search and Filter method (flexible / diverse criteria)
  static List<Product> search({
    String? query,
    double? minPrice,
    double? maxPrice,
  }) {
    return list.where((product) {
      // Filter by name/query
      if (query != null && query.isNotEmpty) {
        final matchesName = product.name.toLowerCase().contains(
          query.toLowerCase(),
        );
        final matchesId = product.id.toLowerCase().contains(
          query.toLowerCase(),
        );
        if (!matchesName && !matchesId) return false;
      }
      // Filter by min price
      if (minPrice != null && product.price < minPrice) {
        return false;
      }
      // Filter by max price
      if (maxPrice != null && product.price > maxPrice) {
        return false;
      }
      return true;
    }).toList();
  }

  // Increase price of all products by 10% using declarative map
  static void increasePrice() {
    list = list
        .map((product) => product.copyWith(price: product.price * 1.1))
        .toList();
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

void main() {
  print('=== INITIAL PRODUCT LIST ===');
  for (var p in Product.list) {
    print(p);
  }

  print('\n=== TESTING FIND METHOD (ID: p1) ===');
  var found = Product.find('p1');
  print(found ?? 'Product not found');

  print('\n=== TESTING ADD METHOD (Adding Vision Pro) ===');
  Product.add(Product(
    id: 'p6',
    name: 'Apple Vision Pro',
    image: 'https://www.apple.com/v/apple-vision-pro/a/images/overview/hero/hero_hardware__e40m5z966tea_large.jpg',
    price: 3499.00,
  ));
  print('Added product. New list count: ${Product.list.length}');
  print('Latest product: ${Product.list.last}');

  print('\n=== TESTING EDIT METHOD (Editing AirPods Pro 2) ===');
  var updatedAirPods = Product(
    id: 'p5',
    name: 'AirPods Pro 2 (USB-C)',
    image: 'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111851_sp880-airpods-Pro-2nd-gen.png',
    price: 229.00,
  );
  bool isEdited = Product.edit(updatedAirPods);
  print('Edit status: ${isEdited ? "Success" : "Failed"}');
  print('Updated product: ${Product.find("p5")}');

  print('\n=== TESTING SEARCH & FILTER METHOD (Query: "Pro", Price range: \$500 - \$2000) ===');
  var searchResults = Product.search(query: 'Pro', minPrice: 500.0, maxPrice: 2000.0);
  for (var p in searchResults) {
    print(p);
  }

  print('\n=== TESTING DECLARATIVE PRICE INCREASE (10%) ===');
  Product.increasePrice();
  print('Prices increased by 10% using declarative map:');
  for (var p in Product.list) {
    print(p);
  }
}
