import 'package:flutter/material.dart';

class CatalogProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _products = [
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

  List<Map<String, dynamic>> _filteredProducts = [];
  final List<Map<String, dynamic>> _cart = [];
  final Map<int, int> _currentImageIndexMap = {};

  CatalogProvider() {
    _filteredProducts = List.from(_products);
  }

  List<Map<String, dynamic>> get products => _filteredProducts;
  List<Map<String, dynamic>> get cart => _cart;
  Map<int, int> get currentImageIndexMap => _currentImageIndexMap;

  void updateSearch(String query) {
    _filteredProducts = _products
        .where((product) =>
            product['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void updateImageIndex(int productIndex, int index, int totalImages) {
    _currentImageIndexMap[productIndex] =
        (index + totalImages) % totalImages;
    notifyListeners();
  }

  void addToCart(Map<String, dynamic> product) {
    _cart.add(product);
    notifyListeners();
  }
}
