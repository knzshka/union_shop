import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import '../widgets/app_navbar.dart';

enum SortOption { none, nameAsc, priceAsc, priceDesc }

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ProductService _service = ProductService();

  String? _selectedCategory; // t-shirt, hoodie, etc.
  String? _selectedTag; // merch, sale, winter, etc.
  SortOption _sortOption = SortOption.none;
  String _searchQuery = '';

  bool _initialisedFromArgs = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialisedFromArgs) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      if (args['tag'] is String) {
        _selectedTag = args['tag'] as String;
      }
      if (args['category'] is String) {
        _selectedCategory = args['category'] as String;
      }
      if (args['search'] is String) {
        _searchQuery = args['search'] as String;
      }
    }
    _initialisedFromArgs = true;
  }

  List<Product> get _filteredProducts {
    List<Product> products = _service.getAllProducts();

    // search filter
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      products = products
          .where((p) =>
      p.name.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q))
          .toList();
    }

    // category filter
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      products = products
          .where((p) => p.category == _selectedCategory)
          .toList();
    }

    // tag / collection filter
    if (_selectedTag != null && _selectedTag!.isNotEmpty) {
      final tag = _selectedTag!;
      if (tag == 'sale') {
        products = products.where((p) => p.isOnSale).toList();
      } else {
        products = products.where((p) => p.hasTag(tag)).toList();
      }
    }

    // sorting
    switch (_sortOption) {
      case SortOption.nameAsc:
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.priceAsc:
        products.sort(
                (a, b) => a.displayPrice.compareTo(b.displayPrice));
        break;
      case SortOption.priceDesc:
        products.sort(
                (a, b) => b.displayPrice.compareTo(a.displayPrice));
        break;
      case SortOption.none:
        break;
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900
        ? 3
        : width > 600
        ? 2
        : 1;

    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/shop'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFilters(),
            const Divider(height: 1),
            if (products.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No products match the filters.'),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              ),
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Purchase online 24/7',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Monday - Friday'),
                  Text('on site opening time 10am'),
                  Text('on site closing time 6pm'),
                  SizedBox(height: 8),
                  Text(
                    'any more questions? contact us at shopupsu@myport.ac.uk',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search products…',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() => _searchQuery = value);
            },
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              DropdownButton<String>(
                value: _selectedCategory,
                hint: const Text('Category'),
                items: const [
                  DropdownMenuItem(
                      value: 't-shirt', child: Text('T-shirts')),
                  DropdownMenuItem(
                      value: 'hoodie', child: Text('Hoodies')),
                  DropdownMenuItem(
                      value: 'sweatshirt', child: Text('Sweatshirts')),
                  DropdownMenuItem(
                      value: 'shorts', child: Text('Shorts')),
                  DropdownMenuItem(
                      value: 'jacket', child: Text('Jackets')),
                  DropdownMenuItem(
                      value: 'notebook', child: Text('Notebooks')),
                  DropdownMenuItem(
                      value: 'id-holder', child: Text('ID Holders')),
                  DropdownMenuItem(value: 'pen', child: Text('Pens')),
                  DropdownMenuItem(value: 'cap', child: Text('Caps')),
                ],
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              ),
              DropdownButton<String>(
                value: _selectedTag,
                hint: const Text('Collections'),
                items: const [
                  DropdownMenuItem(
                      value: 'merch', child: Text('Merch')),
                  DropdownMenuItem(
                      value: 'student-essentials',
                      child: Text('Student essentials')),
                  DropdownMenuItem(
                      value: 'autumn', child: Text('Autumn')),
                  DropdownMenuItem(
                      value: 'winter', child: Text('Winter')),
                  DropdownMenuItem(
                      value: 'sale', child: Text('SALE')),
                ],
                onChanged: (value) {
                  setState(() => _selectedTag = value);
                },
              ),
              DropdownButton<SortOption>(
                value: _sortOption,
                hint: const Text('Sort'),
                items: const [
                  DropdownMenuItem(
                      value: SortOption.none, child: Text('Default')),
                  DropdownMenuItem(
                      value: SortOption.nameAsc,
                      child: Text('Name A → Z')),
                  DropdownMenuItem(
                      value: SortOption.priceAsc,
                      child: Text('Price low → high')),
                  DropdownMenuItem(
                      value: SortOption.priceDesc,
                      child: Text('Price high → low')),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _sortOption = value);
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = null;
                    _selectedTag = null;
                    _sortOption = SortOption.none;
                    _searchQuery = '';
                  });
                },
                child: const Text('Clear filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}