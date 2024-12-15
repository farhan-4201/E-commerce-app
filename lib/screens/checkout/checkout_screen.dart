import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const CheckoutScreen({super.key, required this.product});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  String cardHolderName = '';

  // Helper method to validate the card number
  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    // Add a simple validation check for card number format
    if (value.length != 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  // Helper method to validate expiry date
  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiry date';
    }
    // Check format MM/YY
    final expiryDatePattern = RegExp(r'^(0[1-9]|1[0-2])\/(\d{2})$');
    if (!expiryDatePattern.hasMatch(value)) {
      return 'Invalid expiry date format (MM/YY)';
    }
    return null;
  }

  // Helper method to validate CVV
  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVV';
    }
    if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    return null;
  }

  void goToPaymentScreen(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            product: widget.product,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cvv: cvv,
            cardHolderName: cardHolderName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid card details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7CE7FF),
        elevation: 0,
        title: Text(
          'Checkout',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFFB0C7F7),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Image.asset(
                  widget.product['images'][0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
                title: Text(
                  widget.product['name'],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'PKR ${widget.product['price']}',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Card Holder Name'),
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                    validator: validateCardNumber,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                    validator: validateExpiryDate,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'CVV'),
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    validator: validateCVV,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      goToPaymentScreen(context); // Navigate to the payment screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7CE7FF), // Use color instead of primary
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      'Confirm Purchase',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
