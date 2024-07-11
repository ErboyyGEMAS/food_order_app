import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class AddFoodPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();

  void _addFood(BuildContext context) async {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();
    final category = _categoryController.text.trim();
    final imagePath = _imagePathController.text.trim();

    if (name.isEmpty || price.isEmpty || category.isEmpty || imagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    final foodData = {
      'name': name,
      'price': price,
      'category': category,
      'image_path': imagePath,
    };

    try {
      final result = await ApiService.addFood(foodData);
      print('API Response: $result'); // Debugging response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Berhasil menambahkan makanan')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e'); // Debugging error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan makanan')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Makanan'),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number, // Memastikan hanya angka yang dimasukkan
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Kategori'),
            ),
            TextField(
              controller: _imagePathController,
              decoration: InputDecoration(labelText: 'Path Gambar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addFood(context),
              child: Text('Tambah'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF003366)),
            ),
          ],
        ),
      ),
    );
  }
}
