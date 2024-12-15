import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final void Function(Map<String, dynamic> product) onRemove; // Required parameter

  const CartScreen({
    super.key,
    required this.cart,
    required this.onRemove, // Ensure this is passed correctly
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeFromCart(int index) {
    final product = widget.cart[index]; // Get the product to pass it to onRemove
    widget.onRemove(product); // Call the onRemove callback
    setState(() {
      widget.cart.removeAt(index); // Remove the product from the cart
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
      ),
    );
  }

  void buyItem(BuildContext context, Map<String, dynamic> product) {
    // Logic to handle buying the item
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bought ${product['name']}!'),
      ),
    );

    // Navigate to the checkout screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7CE7FF),
        elevation: 0,
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16.0),
              ),
            )
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final product = widget.cart[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      product['images'][0],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      product['name'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'PKR ${product['price']}',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.green),
                          onPressed: () {
                            buyItem(context, product); // Pass the product to the checkout screen
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.trashAlt, color: Colors.red),
                          onPressed: () {
                            removeFromCart(index); // Remove the item from the cart
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
