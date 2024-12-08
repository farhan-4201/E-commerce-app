import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/catalogue/catalogue_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/admin/admin_panel_screen.dart';
import 'screens/admin/add_product_screen.dart';
import 'screens/admin/manage_order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/cart': (context) => const CartScreen(cart: []),
        '/checkout': (context) => CheckoutScreen(
          product: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {}, // Ensure default value
        ),
        AdminPanelScreen.routeName: (context) => const AdminPanelScreen(),
        AddProductScreen.routeName: (context) =>  AddProductScreen(),
        ManageOrderScreen.routeName: (context) =>  ManageOrderScreen(),
      },
    );
  }
}
