import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../services/cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cart = CartService();

  int get _totalItems =>
      _cart.items.fold(0, (sum, item) => sum + item.quantity);

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final items = _cart.items;

    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/cart'),
      body: items.isEmpty
          ? const Center(
        child: Text('Your cart is empty.'),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage(item.product.imageUrl),
                    onBackgroundImageError: (_, __) {},
                  ),
                  title: Text(item.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '£${item.product.displayPrice.toStringAsFixed(2)} each',
                      ),
                      Text(
                        'Line total: £${item.lineTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 190,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          tooltip: 'Remove item',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            _cart.remove(item.product.id);
                            _refresh();
                          },
                        ),
                        IconButton(
                          tooltip: 'Decrease quantity',
                          onPressed: () {
                            _cart.updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            );
                            _refresh();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          tooltip: 'Increase quantity',
                          onPressed: () {
                            _cart.updateQuantity(
                              item.product.id,
                              item.quantity + 1,
                            );
                            _refresh();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Items: $_totalItems',
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  'Total: £${_cart.total.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _cart.clear();
                        _refresh();
                      },
                      child: const Text('Clear cart'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _cart.clear();
                        _refresh();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text('Order placed (dummy checkout)'),
                          ),
                        );
                      },
                      child: const Text('PLACE ORDER'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/shop');
                  },
                  child: const Text('Continue shopping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}