import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/catalogue/catalogue_screen.dart';

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
        '/catalog': (context) => CatalogScreen(),
      },
    );
  }
}
