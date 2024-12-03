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
  Map<int, int> currentImageIndexMap = {}; // Track image index for each product

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
      ),
      body: Container(
        color: const Color(0xFF7CE7FF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle cart button click
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.cartShopping,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
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
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  int currentImageIndex = currentImageIndexMap[index] ?? 0;

                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        product['hover'] = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        product['hover'] = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: product['hover'] == true
                            ? Colors.grey.shade200
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5.0,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          // Add product to cart or navigate to product details
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    product['images'][currentImageIndex],
                                    height: product['hover'] == true ? 120 : 100,
                                    fit: BoxFit.cover,
                                  ),
                                  if (product['hover'] == true)
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.black38,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                              ),
                                              onPressed: () => updateImageIndex(
                                                currentImageIndex - 1,
                                                index,
                                                product['images'].length,
                                              ),
                                            ),
                                            const SizedBox(width: 10.0), // Space between buttons
                                            IconButton(
                                              icon: const Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              ),
                                              onPressed: () => updateImageIndex(
                                                currentImageIndex + 1,
                                                index,
                                                product['images'].length,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              product['name']!,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              'PKR ${product['price']}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
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
