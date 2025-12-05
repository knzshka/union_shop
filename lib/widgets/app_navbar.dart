import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/auth_service.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;

  const AppNavbar({super.key, required this.currentRoute});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  bool _isActive(String route) => route == currentRoute;

  void _go(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      centerTitle: false,
      toolbarHeight: kToolbarHeight + 32,
      titleSpacing: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF4d2963),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: const Center(
              child: Text(
                'THE UNION SHOP – OFFICIAL UPSU STORE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                InkWell(
                  onTap: () => _go(context, '/'),
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: 26,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.storefront, size: 22),
                  ),
                ),
                const SizedBox(width: 24),
                _NavItem(
                  title: 'Home',
                  isActive: _isActive('/'),
                  onTap: () => _go(context, '/'),
                ),
                const SizedBox(width: 16),
                _NavItem(
                  title: 'Shop',
                  isActive: _isActive('/shop'),
                  onTap: () => _go(context, '/shop'),
                ),
                const SizedBox(width: 16),
                _NavItem(
                  title: 'Collections',
                  isActive: _isActive('/collections'),
                  onTap: () => _go(context, '/collections'),
                ),
                const SizedBox(width: 16),
                _NavItem(
                  title: 'SALE!',
                  isActive: _isActive('/sale'),
                  onTap: () => _go(context, '/sale'),
                ),
                const SizedBox(width: 16),
                _NavItem(
                  title: 'About',
                  isActive: _isActive('/about'),
                  onTap: () => _go(context, '/about'),
                ),
                const SizedBox(width: 24),
                // Search
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(ProductService()),
                    );
                  },
                ),
                // Account icon – меняем вид если пользователь залогинен
                IconButton(
                  icon: Icon(
                    auth.isSignedIn
                        ? Icons.person
                        : Icons.person_outline,
                  ),
                  tooltip: auth.isSignedIn
                      ? 'Signed in as ${auth.currentUserEmail}'
                      : 'Account login',
                  onPressed: () => _go(context, '/login'),
                ),
                // Cart
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () => _go(context, '/cart'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      foregroundColor: Colors.black,
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          decoration:
          isActive ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<Product?> {
  final ProductService service;

  ProductSearchDelegate(this.service)
      : super(searchFieldLabel: 'Search products…');

  List<Product> _search(String q) {
    if (q.trim().isEmpty) return [];
    final query = q.toLowerCase();
    return service
        .getAllProducts()
        .where((p) =>
    p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _search(query);
    if (results.isEmpty) {
      return const Center(child: Text('No matching items.'));
    }
    return _buildList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context, _search(query));
  }

  Widget _buildList(BuildContext context, List<Product> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final p = items[index];
        return ListTile(
          title: Text(p.name),
          subtitle: Text('£${p.displayPrice.toStringAsFixed(2)}'),
          onTap: () {
            close(context, p);
            Navigator.pushNamed(context, '/product', arguments: p);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );
}