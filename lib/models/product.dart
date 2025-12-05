class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? salePrice;
  final String imageUrl;

  final String category;

  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.salePrice,
    required this.imageUrl,
    required this.category,
    required this.tags,
  });

  bool get isOnSale => salePrice != null;
  double get displayPrice => salePrice ?? price;

  bool hasTag(String tag) => tags.contains(tag);
}