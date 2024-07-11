import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  OrderScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${product['name']}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['image_path']),
            SizedBox(height: 16),
            Text(
              product['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('\$${product['price']}'),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Simpan quantity dalam variabel atau state
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/order_confirmation',
                  arguments: {
                    'product': product,
                    'quantity': 1, // Ganti dengan quantity yang diinput oleh pengguna
                  },
                );
              },
              child: Text('Proceed to Order Confirmation'),
            ),
          ],
        ),
      ),
    );
  }
}
