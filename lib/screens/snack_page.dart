import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class SnackPage extends StatefulWidget {
  @override
  _SnackPageState createState() => _SnackPageState();
}

class _SnackPageState extends State<SnackPage> {
  List<dynamic> _snacks = [];

  @override
  void initState() {
    super.initState();
    _loadSnacks();
  }

  void _loadSnacks() async {
    try {
      final snacks = await ApiService.fetchFoodsByCategory('Cemilan'); // Pastikan kategori sesuai
      setState(() {
        _snacks = snacks;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cemilan'),
      ),
      body: ListView.builder(
        itemCount: _snacks.length,
        itemBuilder: (context, index) {
          final snack = _snacks[index];
          return ListTile(
            leading: Image.network(snack['image_path']),
            title: Text(snack['name']),
            subtitle: Text('\$${snack['price']}'),
          );
        },
      ),
    );
  }
}
