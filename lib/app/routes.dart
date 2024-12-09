import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/catalogue/catalogue_screen.dart';
import '../screens/checkout/checkout_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) =>  SignUpScreen(),
      '/catalog': (context) => const CatalogScreen(),
      '/checkout': (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments;
        if (arguments is Map<String, dynamic>) {
          return CheckoutScreen(product: arguments);
        } else {
          // Provide fallback or error handling if arguments are missing
          return const Scaffold(
            body: Center(
              child: Text('No product details provided for checkout!'),
            ),
          );
        }
      },
    };
  }
}
