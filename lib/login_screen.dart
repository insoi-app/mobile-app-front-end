import 'package:flutter/material.dart';
import 'package:mobile_app/api_service.dart'; // Import your API service
import 'home.dart'; // Import your HomeScreen (make sure to replace with actual path)

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // Controllers for the TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // To manage loading state during API call
  String _errorMessage = ''; // To display error messages if any

  // Method to handle login
  void _login() async {
    // Validate email and password
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Clear previous error message
    });

    try {
      // Call the login API
      final response = await ApiService().loginUser(
        _emailController.text,
        _passwordController.text,
      );

      // Check if the login response has tokens
      if (response.containsKey('tokens')) {
        // If login is successful, navigate to the Home screen
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // If tokens are not in response, show an error
        setState(() {
          _errorMessage = 'Invalid credentials';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading after API call
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure screen adjusts for the keyboard
      body: Stack(
        children: [
          // Background Container with Gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 49, 48, 48),
                  Color.fromARGB(255, 0, 0, 0),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 20),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Login form Container wrapped inside a SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height, // Adjust height to screen size
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // User Icon Image
                      const SizedBox(height: 30),
                      Image.asset(
                        'assets/img/user1.png', // Path to your image
                        width: 128.0, // Adjust the size as needed
                        height: 128.0, // Adjust the size as needed
                      ),
                      const SizedBox(height: 30), // Add space below the image

                      // Email (Username) TextField
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: true, // Hide password text
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Forgot Password link
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Error Message Display
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      // Sign In Button
                      _isLoading
                          ? const CircularProgressIndicator() // Show loading indicator when API call is in progress
                          : GestureDetector(
                              onTap: _login,
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 49, 48, 48),
                                      Color.fromARGB(255, 0, 0, 0),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      const SizedBox(height: 60),

                      // Sign Up Text
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
