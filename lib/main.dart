import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCGASmmg9W5cTzwrPCgGPSL44x4WcIq4n0",
        appId: "1:525473371840:android:8e8e0a54565df01460bf25",
        messagingSenderId: "525473371840",
        projectId: "e-commerce-7d2ad",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  WidgetsFlutterBinding.ensureInitialized();
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
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/cart': (context) => CartScreen(
          cart: [], // Ensure the correct argument type
          onRemove: (Map<String, dynamic> product) {
            // Implement your logic to remove a product from the cart
          },
        ),
        '/checkout': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return CheckoutScreen(product: args);
        },
        AdminPanelScreen.routeName: (context) => const AdminPanelScreen(),
        AddProductScreen.routeName: (context) => AddProductScreen(),
        ManageOrderScreen.routeName: (context) => const ManageOrderScreen(),
      },
    );
  }
}
