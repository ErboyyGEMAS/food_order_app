import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class ReadFoodPage extends StatefulWidget {
  @override
  _ReadFoodPageState createState() => _ReadFoodPageState();
}

class _ReadFoodPageState extends State<ReadFoodPage> {
  Future<List<dynamic>>? _foods;

  @override
  void initState() {
    super.initState();
    _foods = ApiService.getFoods();
  }

  void _deleteFood(String foodId) async {
    try {
      await ApiService.deleteFood(foodId);
      setState(() {
        _foods = ApiService.getFoods(); // Refresh the list
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data makanan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat Makanan'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _foods,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data makanan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada makanan tersedia'));
          } else {
            final foods = snapshot.data!;
            return ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Dismissible(
                  key: Key(food['id']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteFood(food['id']);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Image.network(food['image_url']),
                    title: Text(food['name']),
                    subtitle: Text('Harga: ${food['price']}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
