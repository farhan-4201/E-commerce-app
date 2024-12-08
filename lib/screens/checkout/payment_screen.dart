import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardHolderName;

  const PaymentScreen({
    Key? key,
    required this.product,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardHolderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7CE7FF),
        elevation: 0,
        title: Text(
          'Payment',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Color(0xFFB0C7F7),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Image.asset(
                  product['images'][0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
                title: Text(
                  product['name'],
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'PKR ${product['price']}',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Card Holder Name: $cardHolderName',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Card Number: $cardNumber',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Expiry Date: $expiryDate',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'CVV: $cvv',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle payment confirmation logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Purchase confirmed!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7CE7FF), // Use color instead of primary
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Confirm Payment',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
