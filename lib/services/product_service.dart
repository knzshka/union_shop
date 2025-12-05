import '../models/product.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  final List<Product> _products = [
    Product(
      id: 'tee-essential',
      name: 'Essential T-Shirt',
      description: 'Classic Union t-shirt, perfect for everyday wear.',
      price: 12.0,
      salePrice: 8.99,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/files/Sage_T-shirt_540x.png?v=1759827236',
      category: 't-shirt',
      tags: ['merch', 'student-essentials', 'autumn', 'sale'],
    ),
    Product(
      id: 'hoodie-zip',
      name: 'Zip Hoodie',
      description: 'Cosy hoodie with front zip and Union logo.',
      price: 30.0,
      salePrice: 24.99,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_540x.jpg?v=1749131089',
      category: 'hoodie',
      tags: ['merch', 'winter', 'student-essentials', 'sale'],
    ),
    Product(
      id: 'hoodie-classic',
      name: 'Classic Hoodie',
      description: 'Pullover hoodie for colder days.',
      price: 28.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal.jpg?v=1742201957',
      category: 'hoodie',
      tags: ['merch', 'winter', 'student-essentials'],
    ),
    Product(
      id: 'jacket-winter',
      name: 'Winter Jacket',
      description: 'Warm padded jacket with subtle branding.',
      price: 55.0,
      imageUrl:
      'https://optim.tildacdn.com/stor3065-3034-4362-b439-306233623137/-/format/webp/23266100.jpg.webp',
      category: 'jacket',
      tags: ['winter', 'student-essentials'],
    ),

    Product(
      id: 'sweatshirt-classic',
      name: 'Classic Sweatshirt',
      description: 'Comfy classic sweatshirt with Union branding.',
      price: 26.0,
      salePrice: 21.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/GreenSweatshirtFinal_360x.png?v=1741965433',
      category: 'sweatshirt',
      tags: ['sweatshirt', 'autumn', 'merch', 'sale'],
    ),
    Product(
      id: 'cap-classic',
      name: 'Classic Cap',
      description: 'Union-branded cap for sunny days.',
      price: 12.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/Caps-All_360x.jpg?v=1742201981',
      category: 'cap',
      tags: ['merch'],
    ),
    Product(
      id: 'hoodie-graduation',
      name: 'Graduation Hoodie',
      description: 'Graduation hoodie to remember your time at Portsmouth.',
      price: 35.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/GradGrey_360x.jpg?v=1657288025',
      category: 'hoodie',
      tags: ['merch', 'hoodie'],
    ),
    Product(
      id: 'shorts-heavy',
      name: 'Heavyweight Shorts',
      description: 'Comfortable heavyweight shorts with Union details.',
      price: 22.0,
      salePrice: 17.5,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/files/HeavyWeightShortspng_360x.png?v=1683815389',
      category: 'shorts',
      tags: ['merch', 'autumn', 'sale'],
    ),

    Product(
      id: 'notebook-lined',
      name: 'Lined Notebook',
      description: 'A5 notebook with Union crest.',
      price: 5.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/IMG_3403_1024x1024@2x.jpg?v=1581000979',
      category: 'notebook',
      tags: ['merch', 'student-essentials', 'autumn'],
    ),

    Product(
      id: 'id-holder',
      name: 'ID Holder',
      description: 'Keep your student card safe and visible.',
      price: 4.0,
      salePrice: 3.0,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/IMG_0651_1024x1024@2x.jpg?v=1557218799',
      category: 'id-holder',
      tags: ['merch', 'student-essentials', 'sale'],
    ),
    Product(
      id: 'lanyard',
      name: 'Lanyard',
      description: 'Durable Union-branded lanyard for everyday use.',
      price: 2.5,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/IMG_0645_1024x1024@2x.jpg?v=1557218961',
      category: 'id-holder',
      tags: ['merch', 'student-essentials'],
    ),

    Product(
      id: 'pen-blue',
      name: 'Union Pen',
      description: 'Smooth-writing ballpoint pen.',
      price: 1.5,
      imageUrl:
      'https://shop.upsu.net/cdn/shop/products/IMG_3454_b13bdf10-3a11-42d0-90ea-55cdd9314f48_1024x1024@2x.jpg?v=1648635743',
      category: 'pen',
      tags: ['merch', 'student-essentials'],
    ),
  ];

  List<Product> getAllProducts() => List.unmodifiable(_products);

  List<Product> getSaleProducts() =>
      _products.where((p) => p.isOnSale).toList();

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}