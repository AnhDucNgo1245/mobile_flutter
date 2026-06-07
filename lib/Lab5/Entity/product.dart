class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  bool isLiked;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.isLiked = false,
  });
}
