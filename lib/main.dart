import 'package:flutter/material.dart';
import 'package:food_order_app/screens/login_screen.dart';
import 'package:food_order_app/screens/home_screen.dart';
import 'package:food_order_app/screens/add_food_page.dart';
import 'package:food_order_app/screens/category_food_page.dart'; // Import file baru
import 'package:food_order_app/screens/drink_page.dart';
import 'package:food_order_app/screens/read_food_page.dart';
import 'package:food_order_app/screens/snack_page.dart';
import 'package:food_order_app/screens/register_screen.dart';
import 'package:food_order_app/screens/order_confirmation_screen.dart'; // Import file baru
import 'package:food_order_app/screens/order_screen.dart'; // Import file baru

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/category_food':
            final category = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => CategoryFoodPage(category: category ?? 'Makanan'),
            );
          case '/order_confirmation':
            final orderDetails = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => OrderConfirmationScreen(orderDetails: orderDetails),
            );
          case '/order_screen':
            final product = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => OrderScreen(product: product),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => LoginScreen(),
            );
        }
      },
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add_food': (context) => AddFoodPage(),
        '/drink_page': (context) => DrinkPage(),
        '/snack_page': (context) => SnackPage(),
        '/register': (context) => RegisterScreen(),
        '/read_food': (context) => ReadFoodPage(),
      },
    );
  }
}
