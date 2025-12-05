import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = <_CollectionTile>[
      _CollectionTile(
        title: 'Autumn Favourites',
        tag: 'autumn',
        imageUrl:
        'https://shop.upsu.net/cdn/shop/products/GreenSweatshirtFinal_360x.png?v=1741965433',
      ),
      _CollectionTile(
        title: 'Winter Collection',
        tag: 'winter',
        imageUrl:
        'https://optim.tildacdn.com/stor3065-3034-4362-b439-306233623137/-/format/webp/23266100.jpg.webp',
      ),
      _CollectionTile(
        title: 'Clothing',
        category: 'hoodie', // покажем худи / одежду
        imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal.jpg?v=1742201957',
      ),
      _CollectionTile(
        title: 'Student Essentials',
        tag: 'student-essentials',
        imageUrl:
        'https://shop.upsu.net/cdn/shop/products/IMG_3403_1024x1024@2x.jpg?v=1581000979',
      ),
      _CollectionTile(
        title: 'SALE',
        tag: 'sale',
        imageUrl:
        'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_540x.jpg?v=1749131089',
      ),
      _CollectionTile(
        title: 'Merch',
        tag: 'merch',
        imageUrl:
        'https://shop.upsu.net/cdn/shop/products/IMG_3454_b13bdf10-3a11-42d0-90ea-55cdd9314f48_1024x1024@2x.jpg?v=1648635743',
      ),
    ];

    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/collections'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Collections',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount = width > 900
                    ? 3
                    : width > 600
                    ? 2
                    : 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      final c = collections[index];
                      return _CollectionCard(tile: c);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
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

class _CollectionTile {
  final String title;
  final String imageUrl;
  final String? tag;
  final String? category;

  _CollectionTile({
    required this.title,
    required this.imageUrl,
    this.tag,
    this.category,
  });
}

class _CollectionCard extends StatelessWidget {
  final _CollectionTile tile;

  const _CollectionCard({required this.tile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/shop',
          arguments: <String, String>{
            if (tile.tag != null) 'tag': tile.tag!,
            if (tile.category != null) 'category': tile.category!,
          },
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              tile.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.35),
            ),
            Center(
              child: Text(
                tile.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}