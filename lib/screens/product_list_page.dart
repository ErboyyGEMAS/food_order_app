import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    try {
      final productList = await ApiService.getProducts();
      setState(() {
        products = productList;
      });
    } catch (e) {
      // Handle error
      print('Failed to load products: $e');
    }
  }

  void _deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      _loadProducts(); // Refresh the list
    } catch (e) {
      // Handle error
      print('Failed to delete product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product['image']),
            title: Text(product['name']),
            subtitle: Text('\$${product['price']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteProduct(product['id']);
              },
            ),
            onTap: () {
              Navigator.pushNamed(context, '/update_product', arguments: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_product');
        },
      ),
    );
  }
}
