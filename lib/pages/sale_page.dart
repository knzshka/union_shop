import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';
import '../widgets/app_navbar.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductService().getSaleProducts();
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900
        ? 3
        : width > 600
        ? 2
        : 1;

    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/sale'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (products.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No sale items at the moment.'),
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
}