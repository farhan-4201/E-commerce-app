import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/catalogue/catalogue_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/catalog': (context) => CatalogScreen(),

    };
  }
}
