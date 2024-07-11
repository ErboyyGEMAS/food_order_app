import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class UpdateProductPage extends StatefulWidget {
  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  int? _productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _productId = product['id'];
    _nameController.text = product['name'];
    _priceController.text = product['price'].toString();
    _imageController.text = product['image'];
  }

  void _updateProduct() async {
    try {
      final name = _nameController.text;
      final price = double.parse(_priceController.text);
      final imageUrl = _imageController.text;

      if (_productId != null) {
        await ApiService.updateProduct(_productId!, name, price, imageUrl);
        Navigator.pop(context);
      }
    } catch (e) {
      // Handle error
      print('Failed to update product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduct,
              child: Text('Update Produk'),
            ),
          ],
        ),
      ),
    );
  }
}
