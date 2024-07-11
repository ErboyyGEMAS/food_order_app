import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  OrderConfirmationScreen({required this.orderDetails});

  Future<void> _placeOrder(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://mobilecomputing.my.id/api_erga/orders.php'),
      body: {
        'user_id': '1', // Ganti dengan user_id yang sesuai
        'food_id': orderDetails['product']['id'].toString(),
        'quantity': orderDetails['quantity'].toString(),
        'order_date': DateTime.now().toIso8601String(),
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm your order for ${orderDetails['product']['name']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Quantity: ${orderDetails['quantity']}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _placeOrder(context),
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
