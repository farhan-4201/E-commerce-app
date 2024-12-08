import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/catalogue/catalogue_screen.dart';
import '../screens/checkout/checkout_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/catalog': (context) => const CatalogScreen(),
      '/checkout': (context) => CheckoutScreen(
        product: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>, // Get the product details passed during navigation
      ),
    };
  }
}
