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
  Product copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
  }) {
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
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  // Static list of products with default values
  static List<Product> list = [
    Product(
      id: 'p1',
      name: 'iPhone 15 Pro Max',
      image: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569',
      price: 1299.00,
    ),
    Product(
      id: 'p2',
      name: 'MacBook Pro M3',
      image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      price: 1999.00,
    ),
    Product(
      id: 'p3',
      name: 'iPad Pro M2',
      image: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0',
      price: 799.00,
    ),
    Product(
      id: 'p4',
      name: 'Apple Watch Ultra 2',
      image: 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9',
      price: 799.00,
    ),
    Product(
      id: 'p5',
      name: 'AirPods Pro 2',
      image: 'https://images.unsplash.com/photo-1588449668338-d15168b3a533',
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
        final matchesName = product.name.toLowerCase().contains(query.toLowerCase());
        final matchesId = product.id.toLowerCase().contains(query.toLowerCase());
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
    list = list.map((product) => product.copyWith(price: product.price * 1.1)).toList();
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}
