import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://mobilecomputing.my.id/api_erga';

  // Login
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'username': username, 'password': password},
    );
    return json.decode(response.body);
  }

  // Register
  static Future<Map<String, dynamic>> register(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {'username': username, 'password': password, 'email': email},
    );
    return json.decode(response.body);
  }

  // Mengambil daftar makanan berdasarkan kategori
  static Future<List<dynamic>> fetchFoodsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/foods.php?category=$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['foods']; // Pastikan data['foods'] sesuai dengan struktur JSON Anda
    } else {
      throw Exception('Failed to load foods');
    }
  }

  // Mengambil semua makanan
  static Future<List<dynamic>> fetchFoods() async {
    final response = await http.get(Uri.parse('$baseUrl/foods.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load foods');
    }
  }

  // Menambahkan makanan
  static Future<Map<String, dynamic>> addFood(Map<String, String> foodData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_food.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: foodData,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add food');
    }
  }


  // Mengambil informasi pengguna
  static Future<Map<String, dynamic>> getUserInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/user_info.php'));
    return json.decode(response.body);
  }

  // Menambahkan produk


  // Mengambil semua produk
  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/get_products.php'));
    return jsonDecode(response.body);
  }

  static Future<void> deleteFood(String foodId) async {
    final response = await http.post(
      Uri.parse('https://mobilecomputing.my.id/api_erga/delete_food.php'),
      body: {'id': foodId},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data makanan');
    }
  }

  // Mengupdate produk
  static Future<Map<String, dynamic>> updateProduct(int id, String name, double price, String imageUrl) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_product.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'name': name,
        'price': price,
        'image': imageUrl,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<bool> addOrder(int userId, int foodId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_order.php'),
      body: {
        'user_id': userId.toString(),
        'food_id': foodId.toString(),
        'quantity': quantity.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add order');
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to add order');
    }
  }

  // Menghapus produk
  static Future<Map<String, dynamic>> deleteProduct(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_product.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );
    return jsonDecode(response.body);
  }
  static Future<List<dynamic>> getFoods() async {
    final response = await http.get(Uri.parse('https://mobilecomputing.my.id/api_erga/get_foods.php'));

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Cek jika response body kosong
      if (response.body.isEmpty) {
        print('Response body kosong');
        return [];
      }

      // Parsing JSON
      final List<dynamic> data = json.decode(response.body);
      print('Data: $data');
      return data;
    } else {
      throw Exception('Gagal memuat data makanan');
    }
  }
}
