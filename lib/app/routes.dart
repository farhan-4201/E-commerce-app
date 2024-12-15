import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/catalogue/catalogue_screen.dart';
import '../screens/checkout/checkout_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignUpScreen(),
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
      '/logout': (context) => LogoutScreen(),
    };
  }
}

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulating logout functionality
    Future.delayed(Duration.zero, () {
      // Clear session data here (if necessary)
      // Navigate to the login screen
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
