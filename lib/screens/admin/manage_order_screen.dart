import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageOrderScreen extends StatelessWidget {
  static const routeName = '/manage-orders';

  const ManageOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'id': '1', 'customer': 'John Doe', 'status': 'Pending'},
      {'id': '2', 'customer': 'Jane Smith', 'status': 'Delivered'},
      {'id': '3', 'customer': 'Mike Ross', 'status': 'Shipped'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate backward when tapped
          },
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order ID: ${order['id']}'),
              subtitle: Text('Customer: ${order['customer']}'),
              trailing: Text(
                order['status']!,
                style: TextStyle(
                  color: order['status'] == 'Pending'
                      ? Colors.orange
                      : order['status'] == 'Delivered'
                          ? Colors.green
                          : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Details for Order ID: ${order['id']} (Status: ${order['status']})'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
