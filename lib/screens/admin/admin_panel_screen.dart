import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_product_screen.dart';
import 'manage_order_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  static const routeName = '/admin-panel';

  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7CE7FF),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add Product Button
            GradientButton(
              icon: FontAwesomeIcons.plus,
              text: 'Add Product',
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
            ),
            const SizedBox(height: 20),

            // Manage Orders Button
            GradientButton(
              icon: FontAwesomeIcons.boxOpen,
              text: 'Manage Orders',
              onPressed: () {
                Navigator.pushNamed(context, ManageOrderScreen.routeName);
              },
            ),
            const SizedBox(height: 20),

            // Logout Button
            GradientButton(
              icon: FontAwesomeIcons.signOutAlt,
              text: 'Logout',
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Example logout functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully!')),
    );
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }
}

class GradientButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7CE7FF), Color(0xFFB0C7F7)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        icon: FaIcon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
