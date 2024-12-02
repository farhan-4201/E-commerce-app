import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'image': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.marecentre.nl%2F%3Fm%3D36368614&psig=AOvVaw37tr8GFehYYGlkwtE5MHuG&ust=1733248359162000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLCsobjTiYoDFQAAAAAdAAAAABAE', 'price': '3500'},
    {'image': 'https://via.placeholder.com/150/FF4500', 'price': '3600'},
    {'image': 'https://via.placeholder.com/150/DC143C', 'price': '3700'},
    {'image': 'https://via.placeholder.com/150/FF8C00', 'price': '3800'},
    {'image': 'https://via.placeholder.com/150/FF6347', 'price': '3900'},
    {'image': 'https://via.placeholder.com/150/FF4500', 'price': '4000'},
    {'image': 'https://via.placeholder.com/150/FF0000', 'price': '4100'},
    {'image': 'https://via.placeholder.com/150/E9967A', 'price': '4200'},
    {'image': 'https://via.placeholder.com/150/FF1493', 'price': '4300'},
    {'image': 'https://via.placeholder.com/150/FFA07A', 'price': '4400'},
    {'image': 'https://via.placeholder.com/150/FF7F50', 'price': '4500'},
    {'image': 'https://via.placeholder.com/150/CD5C5C', 'price': '4600'},
    {'image': 'https://via.placeholder.com/150/DB7093', 'price': '4700'},
    {'image': 'https://via.placeholder.com/150/B22222', 'price': '4800'},
    {'image': 'https://via.placeholder.com/150/FA8072', 'price': '4900'},
    {'image': 'https://via.placeholder.com/150/FF69B4', 'price': '5000'},
    {'image': 'https://via.placeholder.com/150/C71585', 'price': '5200'},
    {'image': 'https://via.placeholder.com/150/FF4500', 'price': '5400'},
    {'image': 'https://via.placeholder.com/150/FF6347', 'price': '5600'},
    {'image': 'https://via.placeholder.com/150/FF4500', 'price': '6000'},
  ];

  CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Store',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'New Arrivals',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          product['image']!,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'PKR ${product['price']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
