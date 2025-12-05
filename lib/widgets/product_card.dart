import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  void _openProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product', arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openProduct(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          product.isOnSale
              ? Row(
            children: [
              Text(
                "£${product.salePrice!.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Color(0xFF4d2963),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "£${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          )
              : Text(
            "£${product.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}