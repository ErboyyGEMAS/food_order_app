import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart';
import 'package:food_order_app/screens/category_food_page.dart';
import 'package:food_order_app/screens/drink_page.dart';
import 'package:food_order_app/screens/snack_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Memuat..';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    try {
      final userInfo = await ApiService.getUserInfo();
      setState(() {
        username = userInfo['username'] ?? 'Pengguna Tidak Dikenal';
      });
    } catch (e) {
      setState(() {
        username = 'Gagal memuat nama pengguna';
      });
    }
  }

  void _showUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informasi Pengguna'),
          content: Text('Nama Pengguna: $username'),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMenuPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 250,
            margin: EdgeInsets.only(top: 40, left: 16),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              elevation: 5.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      // Tambahkan aksi logout di sini
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Tambah Makanan'),
                    onTap: () {
                      Navigator.pushNamed(context, '/add_food');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.visibility),
                    title: Text('Lihat Makanan'),
                    onTap: () {
                      Navigator.pushNamed(context, '/read_food');
                    },
                  ),
                  // Hapus opsi 'Update Makanan' dan 'Hapus Makanan'
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, Hungries...'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF003366), size: 30),
            onPressed: _showMenuPopup,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100], // Warna background seragam
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bar pencarian
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Color(0xFF003366)),
                  ),
                ),
              ),
            ),
            // Top Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Top Kategori',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ),
            // Kotak kategori
            SizedBox(
              height: 120, // Atur tinggi sesuai kebutuhan
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryBox('Makanan', 'assets/images/food.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryFoodPage(category: 'Makanan'),
                      ),
                    );
                  }),
                  _buildCategoryBox('Minuman', 'assets/images/drink.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrinkPage(),
                      ),
                    );
                  }),
                  _buildCategoryBox('Snack', 'assets/images/snack.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryFoodPage(category: 'Cemilan'),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Produk',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75, // Sesuaikan rasio tampilan item
                ),
                itemCount: 10, // Ganti dengan jumlah produk sebenarnya
                itemBuilder: (context, index) {
                  return _buildProductBox('Produk $index', 'assets/images/food.png', () {
                    // Tambahkan aksi saat kotak produk ditekan
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/add_food');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),
    );
  }

  Widget _buildCategoryBox(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120, // Sesuaikan lebar kategori
        margin: EdgeInsets.only(right: 16),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductBox(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
