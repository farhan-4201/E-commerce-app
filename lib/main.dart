import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/catalogue/catalogue_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/admin/admin_panel_screen.dart';
import 'screens/admin/add_product_screen.dart';
import 'screens/admin/manage_order_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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
      // Set the initial route to LoginScreen
      initialRoute: '/login',
      // Define routes for navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/cart': (context) => const CartScreen(cart: []),
        '/checkout': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return CheckoutScreen(product: args);
        },
        AdminPanelScreen.routeName: (context) => const AdminPanelScreen(),
        AddProductScreen.routeName: (context) =>  AddProductScreen(),
        ManageOrderScreen.routeName: (context) => const ManageOrderScreen(),
      },
    );
  }
}
