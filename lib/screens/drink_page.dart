import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class DrinkPage extends StatefulWidget {
  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  List<dynamic> _drinks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDrinks();
  }

  void _loadDrinks() async {
    try {
      final drinks = await ApiService.fetchFoodsByCategory('Minuman');
      setState(() {
        _drinks = drinks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat minuman')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minuman'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _drinks.isNotEmpty
          ? GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: _drinks.length,
        itemBuilder: (context, index) {
          final drink = _drinks[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/order_screen',
                arguments: drink,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      drink['image_path'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      drink['name'] ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '\$${drink['price'] ?? '0.00'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF003366),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(child: Text('Tidak ada minuman tersedia')),
    );
  }
}
