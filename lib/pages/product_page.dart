import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../widgets/app_navbar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedColour;
  String? _selectedSize;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  bool _isClothing(Product product) {
    const clothingCategories = ['t-shirt', 'hoodie', 'sweatshirt'];
    return clothingCategories.contains(product.category);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Product? product = args is Product ? args : null;

    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/product'),
      body: product == null
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'No product data was provided.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 420,
                  color: Colors.white,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: Image.network(
                      product.imageUrl,
                      errorBuilder: (_, __, ___) => Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '£${product.displayPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      if (product.isOnSale) ...[
                        const SizedBox(width: 8),
                        Text(
                          '£${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  if (_isClothing(product)) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Personalisation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add your own text and choose a colour. '
                          'This is demonstration only and not real printing.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _textController,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        labelText: 'Custom text',
                        border: OutlineInputBorder(),
                        isDense: true,
                        helperText: 'Max 20 characters',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedSize,
                      decoration: const InputDecoration(
                        labelText: 'Size',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'S', child: Text('S')),
                        DropdownMenuItem(
                            value: 'M', child: Text('M')),
                        DropdownMenuItem(
                            value: 'L', child: Text('L')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedSize = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedColour,
                      decoration: const InputDecoration(
                        labelText: 'Item colour',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'white', child: Text('White')),
                        DropdownMenuItem(
                            value: 'black', child: Text('Black')),
                        DropdownMenuItem(
                            value: 'navy', child: Text('Navy')),
                        DropdownMenuItem(
                            value: 'burgundy',
                            child: Text('Burgundy')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedColour = value);
                      },
                    ),
                  ],

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        CartService().add(product);

                        String extra = '';
                        if (_isClothing(product)) {
                          final text = _textController.text.trim();
                          final colour = _selectedColour ?? '–';
                          final size = _selectedSize ?? '–';
                          extra =
                          '\nSize: $size, Text: ${text.isEmpty ? '–' : text}, Colour: $colour';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to cart.$extra'),
                          ),
                        );
                      },
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
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
}