import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get lineTotal => product.displayPrice * quantity;
}

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

  double get total =>
      _items.values.fold(0.0, (sum, item) => sum + item.lineTotal);

  void add(Product product, {int quantity = 1}) {
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
  }

  void updateQuantity(String productId, int quantity) {
    final item = _items[productId];
    if (item == null) return;
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      item.quantity = quantity;
    }
  }

  void remove(String productId) {
    _items.remove(productId);
  }

  void clear() => _items.clear();
}