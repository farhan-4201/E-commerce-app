import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'catalogue_provider.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CatalogProvider>(context).cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.asset(
                    item['images'][0],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('PKR ${item['price']}'),
                );
              },
            ),
    );
  }
}
