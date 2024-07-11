import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class CategoryFoodPage extends StatefulWidget {
  final String category;

  CategoryFoodPage({required this.category});

  @override
  _CategoryFoodPageState createState() => _CategoryFoodPageState();
}

class _CategoryFoodPageState extends State<CategoryFoodPage> {
  List<dynamic> _foods = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  void _loadFoods() async {
    try {
      final foods = await ApiService.fetchFoodsByCategory(widget.category);
      setState(() {
        _foods = foods;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat makanan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _foods.isNotEmpty
          ? GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, // Rasio aspek kotak katalog
        ),
        itemCount: _foods.length,
        itemBuilder: (context, index) {
          final food = _foods[index];
          return _buildFoodBox(
            food['name'] ?? 'Unknown',
            food['image_path'] ?? '',
            food['price'] ?? '0.00',
          );
        },
      )
          : Center(child: Text('Tidak ada makanan tersedia')),
    );
  }

  Widget _buildFoodBox(String name, String imagePath, String price) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              '\$${price}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
