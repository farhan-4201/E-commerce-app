import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'images': [
        'assets/AF1.jpg',
        'assets/AF1_1.jpg',
        'assets/AF1_2.jpg',
      ],
      'price': '3500',
      'name': 'Nike Air Force 1',
    },
    {
      'images': [
        'assets/adidas_shoe.jpg',
        'assets/adidas_shoe1.jpg',
        'assets/adidas_shoe2.jpg',
      ],
      'price': '8600',
      'name': 'Adidas UltraBoost',
    },
    {
      'images': [
        'assets/nike_shoe.jpg',
        'assets/nike_shoe1.jpg',
        'assets/nike_shoe2.jpg',
      ],
      'price': '3600',
      'name': 'Nike Revolution',
    },
    {
      'images': [
        'assets/converse_shoe.jpg',
        'assets/converse_shoe1.jpg',
        'assets/converse_shoe2.jpg',
      ],
      'price': '5600',
      'name': 'Converse Star',
    },
    {
      'images': [
        'assets/puma_shoe.jpg',
        'assets/puma_shoe1.jpg',
        'assets/puma_shoe2.jpg',
      ],
      'price': '6600',
      'name': 'Puma RS-X',
    },
  ];

  String searchQuery = '';
  List<Map<String, dynamic>> filteredProducts = [];
  Map<int, int> currentImageIndexMap = {};
  final List<Map<String, dynamic>> cart = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = products
          .where((product) =>
              product['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void updateImageIndex(int index, int productIndex, int totalImages) {
    setState(() {
      currentImageIndexMap[productIndex] = (index + totalImages) % totalImages;
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7CE7FF),
        elevation: 0,
        title: Text(
          'Store',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: navigateToCart,
                icon: const FaIcon(
                  FontAwesomeIcons.cartShopping,
                  color: Colors.black,
                ),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF7CE7FF),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: TextField(
                onChanged: updateSearch,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
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
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  int currentImageIndex = currentImageIndexMap[index] ?? 0;

                  return Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  product['images'][currentImageIndex],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text('Image not found'),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 40,
                                child: IconButton(
                                  onPressed: () {
                                    updateImageIndex(
                                      currentImageIndex - 1,
                                      index,
                                      product['images'].length,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 40,
                                child: IconButton(
                                  onPressed: () {
                                    updateImageIndex(
                                      currentImageIndex + 1,
                                      index,
                                      product['images'].length,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['name'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Text(
                          'PKR ${product['price']}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () => addToCart(product),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Add to Cart'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Bought ${product['name']}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text('Buy'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('No items in the cart'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(
                    item['images'][0],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('PKR ${item['price']}'),
                );
              },
            ),
    );
  }
}
