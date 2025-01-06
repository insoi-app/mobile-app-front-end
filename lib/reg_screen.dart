import 'package:flutter/material.dart';
import 'package:mobile_app/api_service.dart'; // Import your API service
import 'reg_success_screen.dart'; // Import RegistrationSuccessScreen

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  RegScreenState createState() => RegScreenState();
}

class RegScreenState extends State<RegScreen> {
  // Controllers for capturing input data
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;  // To track loading state

  // Register user function that will call the API
  Future<void> _registerUser() async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    // Basic validation
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError('All fields are required.');
      return;
    }

    if (password != confirmPassword) {
      _showError('Passwords do not match.');
      return;
    }

    // Simple email validation regex
    if (!_isValidEmail(email)) {
      _showError('Please enter a valid email address.');
      return;
    }

    // Set loading state to true
    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = ApiService(); // Instantiate the API service
      final response = await apiService.registerUser(username, email, password, confirmPassword);

      setState(() {
        _isLoading = false;
      });

      // Handle success: If response is not empty or as expected, navigate to success screen
      if (response.isNotEmpty) {
        _showSuccess('Registration successful!');
        // Navigate to Registration Success Screen
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const RegistrationSuccessScreen()),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showError(error.toString());
    }
  }

  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // Show success message
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // Basic email validation function
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container with gradient
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
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Main container for the registration form wrapped inside a SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height, // Adjust height to screen size
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // User Icon Image
                      Image.asset(
                        'assets/img/user.png', // Add path to your image
                        width: 128.0, // Adjust the size as needed
                        height: 128.0, // Adjust the size as needed
                      ),
                      const SizedBox(height: 30),

                      // Username TextField
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email TextField
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password TextField
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button with loading state
                      GestureDetector(
                        onTap: _isLoading ? null : _registerUser, // Disable button while loading
                        child: Container(
                          height: 55,
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
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator()) // Show loading indicator
                              : const Center(
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 50),
                       const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            Text(
                              "Login",
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
