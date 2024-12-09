import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/cart/cart_screen.dart';
import '/screens/checkout/checkout_screen.dart';
import '/screens/admin/admin_panel_screen.dart'; // Import AdminPanelScreen

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
    currentImageIndexMap = {
      for (int i = 0; i < products.length; i++) i: 0,
    };
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = products
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void updateImageIndex(int productIndex, int delta) {
    setState(() {
      int totalImages = products[productIndex]['images'].length;
      currentImageIndexMap[productIndex] =
          (currentImageIndexMap[productIndex]! + delta + totalImages) %
              totalImages;
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      if (!cart.contains(product)) {
        cart.add(product);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: cart),
      ),
    );
  }

  void navigateToCheckout(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(product: product),
      ),
    );
  }

  void navigateToAdminPanel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminPanelScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(82, 167, 237, 1)),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.user),
              title: const Text('Switch to Admin'),
              onTap: navigateToAdminPanel, // Navigate to Admin Panel
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.signOutAlt),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7CE7FF),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.black,
            ),
          ),
        ),
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
                  FontAwesomeIcons.shoppingCart,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search products...',
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
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text('Image not found'),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    top: 85,
                                    child: IconButton(
                                      onPressed: () {
                                        updateImageIndex(index, -1);
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 85,
                                    child: IconButton(
                                      onPressed: () {
                                        updateImageIndex(index, 1);
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.chevronRight,
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PKR ${product['price']}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      addToCart(product);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.cartPlus,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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
