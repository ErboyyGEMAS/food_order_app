import 'package:flutter/material.dart';
import 'package:food_order_app/services/api_service.dart'; // Perbaiki nama import jika diperlukan

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final result = await ApiService.login(username, password);
      if (result['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${result['message']}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with clouds
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  left: -60,
                  child: Image.asset(
                    'assets/images/cloud1.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 150,
                  child: Image.asset(
                    'assets/images/cloud2.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 50,
                  child: Image.asset(
                    'assets/images/cloud3.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 280,
                  left: 180,
                  child: Image.asset(
                    'assets/images/cloud1.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 380,
                  left: 30,
                  child: Image.asset(
                    'assets/images/cloud2.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 120,
                  child: Image.asset(
                    'assets/images/cloud3.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 200,
                  left: 60,
                  child: Image.asset(
                    'assets/images/cloud1.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 300,
                  right: 140,
                  child: Image.asset(
                    'assets/images/cloud2.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 400,
                  left: 220,
                  child: Image.asset(
                    'assets/images/cloud3.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 100,
                  right: -30,
                  child: Image.asset(
                    'assets/images/cloud2.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: -20,
                  child: Image.asset(
                    'assets/images/cloud1.png',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // Half-circle panel at the top
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xFF003366),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: Center(
                child: Text(
                  'ErFood',
                  style: TextStyle(
                    fontFamily: 'ITCKRIST',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Main content
          Positioned.fill(
            top: 80,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                fontFamily: 'ITCKRIST',
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            SizedBox(height: 24),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person, color: Color(0xFF003366)),
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Color(0xFF003366)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF003366)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF003366)),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock, color: Color(0xFF003366)),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Color(0xFF003366)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF003366)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF003366)),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF003366),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Don\'t have an account? Register here',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
